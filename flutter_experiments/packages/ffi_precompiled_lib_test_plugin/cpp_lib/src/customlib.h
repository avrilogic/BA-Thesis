#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

// ffigen can parse only valid C code. 
// For the c++ lib, we still have to disable name mangling.
#ifdef __cplusplus
extern "C" { 
#endif

FFI_PLUGIN_EXPORT const char* hello_world();

#ifdef __cplusplus
} // closing brace for extern "C"
#endif