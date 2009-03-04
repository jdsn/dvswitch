/* Copyright 2007-2009 Ben Hutchings.
 * See the file "COPYING" for licence details.
 */

#include <assert.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <fcntl.h>
#include <getopt.h>
#include <sys/types.h>
#include <unistd.h>
#include <netinet/in.h>

#include <asoundlib.h>

#include "config.h"
#include "dif.h"
#include "protocol.h"
#include "socket.h"

static struct option options[] = {
    {"host",   1, NULL, 'h'},
    {"port",   1, NULL, 'p'},
    {"system", 1, NULL, 's'},
    {"rate",   1, NULL, 'r'},
    {"delay",  1, NULL, 'd'},
    {"help",   0, NULL, 'H'},
    {NULL,     0, NULL, 0}
};

static char * mixer_host = NULL;
static char * mixer_port = NULL;

static void handle_config(const char * name, const char * value)
{
    if (strcmp(name, "MIXER_HOST") == 0)
    {
	free(mixer_host);
	mixer_host = strdup(value);
    }
    else if (strcmp(name, "MIXER_PORT") == 0)
    {
	free(mixer_port);
	mixer_port = strdup(value);
    }
}

static void usage(const char * progname)
{
    fprintf(stderr,
	    "\
Usage: %s [{-h|--host} MIXER-HOST] [{-p|--port} MIXER-PORT] \\\n\
           [{-s|--system} ntsc|pal] [{-r|--rate} 48000|32000|44100] \\\n\
           [{-d|--delay} DELAY] [DEVICE]\n",
	    progname);
}

struct transfer_params {
    snd_pcm_t *              pcm;
    snd_pcm_uframes_t        hw_sample_count;
    const struct dv_system * system;
    enum dv_sample_rate      sample_rate_code;
    snd_pcm_uframes_t        delay_size;
    int                      sock;
};

static void dv_buffer_fill_dummy(uint8_t * buf, const struct dv_system * system)
{
    unsigned seq_num, block_num;
    uint8_t * block = buf;

    for (seq_num = 0; seq_num != system->seq_count; ++seq_num)
    {
	for (block_num = 0; block_num != DIF_BLOCKS_PER_SEQUENCE; ++block_num)
	{
	    uint8_t type, typed_block_num;

	    // Set block id
	    if (block_num == 0) // header
	    {
		type = 0x1f;
		typed_block_num = 0;
	    }
	    else if (block_num < 3) // subcode
	    {
		type = 0x3f;
		typed_block_num = block_num - 1;
	    }
	    else if (block_num < 6) // VAUX
	    {
		type = 0x56;
		typed_block_num = block_num - 3;
	    }
	    else if (block_num % 16 == 6) // audio
	    {
		type = 0x76;
		typed_block_num = block_num / 16;
	    }
	    else // video
	    {
		type = 0x96;
		typed_block_num = (block_num - 7) - (block_num - 7) / 16;
	    }
	    block[0] = type;
	    block[1] = (seq_num << 4) | 7;
	    block[2] = typed_block_num;

	    // Clear rest of the block
	    memset(block + DIF_BLOCK_ID_SIZE,
		   0xff,
		   DIF_BLOCK_SIZE - DIF_BLOCK_ID_SIZE);

	    // Set system code
	    if (block_num == 0)
		block[DIF_BLOCK_ID_SIZE] = (system == &dv_system_625_50) ? 0xbf : 0x3f;

	    block += DIF_BLOCK_SIZE;
	}
    }
}

static void transfer_frames(struct transfer_params * params)
{
    static uint8_t buf[DIF_MAX_FRAME_SIZE];
    static const unsigned channel_count = 2;
    unsigned avail_count = 0;
    unsigned serial_num = 0;

    const snd_pcm_uframes_t buffer_size =
	(params->delay_size >= 2000 ? params->delay_size : 2000)
	+ params->hw_sample_count - 1;
    int16_t * samples = malloc(sizeof(int16_t) * channel_count * buffer_size);

    dv_buffer_fill_dummy(buf, params->system);

    for (;;)
    {
	unsigned sample_count = 
	    params->system->sample_counts[params->sample_rate_code].std_cycle[
		serial_num % params->system->sample_counts[params->sample_rate_code].std_cycle_len];

	while (avail_count < params->delay_size || avail_count < sample_count)
	{
	    snd_pcm_sframes_t rc = snd_pcm_readi(params->pcm,
						 samples + channel_count * avail_count,
						 params->hw_sample_count);
	    if (rc != (snd_pcm_sframes_t)params->hw_sample_count)
	    {
		fprintf(stderr, "ERROR: snd_pcm_readi: %s\n",
			(rc < 0) ? snd_strerror(rc) : "underrun");
		exit(1);
	    }
	    avail_count += rc;
	}

	dv_buffer_set_audio(buf, params->sample_rate_code, sample_count, samples);

	if (write(params->sock, buf, params->system->size)
	    != (ssize_t)params->system->size)
	{
	    perror("ERROR: write");
	    exit(1);
	}

	memmove(samples, samples + channel_count * sample_count,
		sizeof(int16_t) * channel_count * (avail_count - sample_count));
	avail_count -= sample_count;
	++serial_num;
    }
}

int main(int argc, char ** argv)
{
    /* Initialise settings from configuration files. */
    dvswitch_read_config(handle_config);

    struct transfer_params params;
    char * system_name = NULL;
    long sample_rate = 48000;
    double delay = 0.2;

    /* Parse arguments. */

    int opt;
    while ((opt = getopt_long(argc, argv, "h:p:s:r:d:", options, NULL)) != -1)
    {
	switch (opt)
	{
	case 'h':
	    free(mixer_host);
	    mixer_host = strdup(optarg);
	    break;
	case 'p':
	    free(mixer_port);
	    mixer_port = strdup(optarg);
	    break;
	case 's':
	    free(system_name);
	    system_name = strdup(optarg);
	    break;
	case 'r':
	    sample_rate = strtol(optarg, NULL, 10);
	    break;
	case 'd':
	    delay = strtod(optarg, NULL);
	    break;
	case 'H': /* --help */
	    usage(argv[0]);
	    return 0;
	default:
	    usage(argv[0]);
	    return 2;
	}
    }

    if (!mixer_host || !mixer_port)
    {
	fprintf(stderr, "%s: mixer hostname and port not defined\n",
		argv[0]);
	return 2;
    }

    if (!system_name || !strcasecmp(system_name, "pal"))
    {
	params.system = &dv_system_625_50;
    }
    else if (!strcasecmp(system_name, "ntsc"))
    {
	params.system = &dv_system_525_60;
    }
    else
    {
	fprintf(stderr, "%s: invalid system name \"%s\"\n", argv[0], system_name);
	return 2;
    }

    if (sample_rate == 32000)
    {
	params.sample_rate_code = dv_sample_rate_32k;
    }
    else if (sample_rate == 44100)
    {
	params.sample_rate_code = dv_sample_rate_44k1;
    }
    else if (sample_rate == 48000)
    {
	params.sample_rate_code = dv_sample_rate_48k;
    }
    else
    {
	fprintf(stderr, "%s: invalid sample rate %ld\n", argv[0], sample_rate);
	return 2;
    }

    if (delay >= 0.0)
    {
	params.delay_size = delay * sample_rate;
    }
    else
    {
	fprintf(stderr, "%s: delays do not work that way!\n", argv[0]);
	return 2;
    }

    if (argc > optind + 1)
    {
	fprintf(stderr, "%s: excess argument \"%s\"\n",
		argv[0], argv[optind + 1]);
	usage(argv[0]);
	return 2;
    }


    const char * device = (argc == optind) ? "default" : argv[optind];
    int rc;

    /* Prepare to capture and connect a socket to the mixer. */

    printf("INFO: Capturing from %s\n", device);
    rc = snd_pcm_open(&params.pcm, device, SND_PCM_STREAM_CAPTURE, 0);
    if (rc < 0)
    {
	fprintf(stderr, "ERROR: snd_pcm_open: %s\n", snd_strerror(rc));
	return 1;
    }

    snd_pcm_hw_params_t * hw_params;
    snd_pcm_hw_params_alloca(&hw_params);
    rc = snd_pcm_hw_params_any(params.pcm, hw_params);
    if (rc < 0)
    {
	fprintf(stderr, "ERROR: snd_pcm_hw_params_any: %s\n", snd_strerror(rc));
	return 1;
    }
    rc = snd_pcm_hw_params_set_access(params.pcm, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED);
    if (rc >= 0)
	rc = snd_pcm_hw_params_set_format(params.pcm, hw_params, SND_PCM_FORMAT_S16);
    if (rc >= 0)
	snd_pcm_hw_params_set_channels(params.pcm, hw_params, 2);
    if (rc >= 0)
	snd_pcm_hw_params_set_rate_resample(params.pcm, hw_params, 1);
    if (rc >= 0)
	snd_pcm_hw_params_set_rate(params.pcm, hw_params, sample_rate, 0);
    if (rc >= 0)
    {
	params.hw_sample_count =
	    params.system->sample_counts[params.sample_rate_code].std_cycle[0];
	rc = snd_pcm_hw_params_set_period_size_near(params.pcm, hw_params,
						    &params.hw_sample_count, 0);
    }
    if (rc >= 0)
    {
	unsigned buffer_time = 250000;
	rc = snd_pcm_hw_params_set_buffer_time_near(params.pcm, hw_params,
						    &buffer_time, 0);
    }
    if (rc >= 0)
	rc = snd_pcm_hw_params(params.pcm, hw_params);
    if (rc < 0)
    {
	fprintf(stderr, "ERROR: snd_pcm_hw_params: %s\n", snd_strerror(rc));
	return 1;
    }

    printf("INFO: Connecting to %s:%s\n", mixer_host, mixer_port);
    params.sock = create_connected_socket(mixer_host, mixer_port);
    assert(params.sock >= 0); /* create_connected_socket() should handle errors */
    if (write(params.sock, GREETING_SOURCE, GREETING_SIZE) != GREETING_SIZE)
    {
	perror("ERROR: write");
	exit(1);
    }

    transfer_frames(&params);

    close(params.sock);
    snd_pcm_close(params.pcm);

    return 0;
}
