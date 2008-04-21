// Copyright 2007 Ben Hutchings.
// See the file "COPYING" for licence details.

#ifndef DVSWITCH_DIF_H
#define DVSWITCH_DIF_H

#include <stddef.h>
#include <stdint.h>

#include "geometry.h"

#define DIF_BLOCK_SIZE 80
#define DIF_BLOCKS_PER_SEQUENCE 150
#define DIF_SEQUENCE_SIZE (DIF_BLOCK_SIZE * DIF_BLOCKS_PER_SEQUENCE)
#define DIF_MAX_FRAME_SIZE (DIF_SEQUENCE_SIZE * 12)

#define DIF_BLOCK_ID_SIZE 3
#define DIF_PACK_SIZE 5

enum dv_sample_rate
{
    dv_sample_rate_48k,
    dv_sample_rate_44k1,
    dv_sample_rate_32k,
    dv_sample_rate_count
};

struct dv_system
{
    const char * common_name;
    unsigned frame_width, frame_height;
    struct rectangle active_region;
    unsigned frame_rate_numer, frame_rate_denom;
    struct {
	unsigned width, height;
    } pixel_aspect_normal, pixel_aspect_wide;
    unsigned seq_count;
    size_t size;
    struct {
	unsigned min_count, max_count;
    } sample_limits[dv_sample_rate_count];
};

extern const struct dv_system dv_system_625_50, dv_system_525_60;

static inline
const struct dv_system * dv_buffer_system(const uint8_t * buffer)
{
    return (buffer[3] & 0x80) ? &dv_system_625_50 : &dv_system_525_60;
}

#endif // !defined(DVSWITCH_DIF_H)
