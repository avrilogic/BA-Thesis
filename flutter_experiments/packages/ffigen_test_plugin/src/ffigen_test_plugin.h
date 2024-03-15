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

FFI_PLUGIN_EXPORT char* hello_world();
FFI_PLUGIN_EXPORT char* hello_world_delayed();
FFI_PLUGIN_EXPORT int add(int a, int b);
FFI_PLUGIN_EXPORT int subtract(int a, int b);
FFI_PLUGIN_EXPORT int multiply(int a, int b);
FFI_PLUGIN_EXPORT int divide(int a, int b);

FFI_PLUGIN_EXPORT int* add2(int* a, int* b);


FFI_PLUGIN_EXPORT char* reverse(char* str);

struct MatrixData {
  size_t rows;
  size_t cols;
  double* data;
};

#ifdef __cplusplus
} // closing brace for extern "C"
#endif