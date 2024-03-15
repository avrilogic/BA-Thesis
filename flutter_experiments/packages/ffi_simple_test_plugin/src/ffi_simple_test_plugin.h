#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "structs.h"

extern "C" {
  const char* hello_world();
  const char* reverse(char* str);
  const void free_string(char* str);
  double calculate(calculation_request request);
  calculation_request create_request(double a, double b, int operation);
  void free_request(calculation_request request);
}
