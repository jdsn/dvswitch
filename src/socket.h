#ifndef DVSWITCH_SOCKET_H
#define DVSWITCH_SOCKET_H

#ifdef __cplusplus
extern "C" {
#endif

int create_connected_socket(const char * host, const char * port);

#ifdef __cplusplus
}
#endif

#endif /* !defined(DVSWITCH_SOCKET_H) */
