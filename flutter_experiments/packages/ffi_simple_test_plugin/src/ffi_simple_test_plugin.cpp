#include "ffi_simple_test_plugin.h"
#include <string.h>

// Simple function that returns a string
const char* hello_world() {
  return "Hello from the C++ Code in ffi_simple_test_plugin!";
}

// Simple function that receives a string and returns it reversed
const char* reverse(char* str) {
  int length = strlen(str);
  char* reversed = (char*)malloc(length + 1);
  for (int i = 0; i < length; i++) {
    reversed[i] = str[length - i - 1];
  }
  reversed[length] = '\0';
  return reversed;
}



// Simple function that receives two numbers and a calculation type and returns the result
double calculate(calculation_request request) {
  switch (request.type) {
    case ADD:
      return request.a + request.b;
    case SUBTRACT:
      return request.a - request.b;
    case MULTIPLY:
      return request.a * request.b;
    case DIVIDE:
      return request.a / request.b;
  }
}

const void free_string(char* str) {
  free(str);
}

calculation_request create_request(double a, double b, int operation) {
  calculation_request request;
  request.a = a;
  request.b = b;
  request.type = CalculationType(operation);
  return request;
}
