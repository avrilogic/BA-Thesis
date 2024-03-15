#include <iostream>
#include "lib/lib.h"
#include "staticlib.h"

int main()
{
  int i = test();
  std::cout << "The Answer is: " << i << std::endl;

  Testlib lib;
  lib.set_millis(1000);
  std::cout << "Millis: " << lib.get_millis() << std::endl;
  return 0;
}