#include <iostream>
#include "lib/lib.h"
#include "config.h"
#include "dynlib.hpp"

using namespace std;

void print(const char *msg)
{
  cout << msg << endl;
}

int main()
{
  DllLoader loader;
  loader.load(MY_LIBRARY_NAME);
  auto add = loader.getAddFunction();
  auto createTestlib = loader.getCreateTestlibFunction();
  auto destroyTestlib = loader.getDestroyTestlibFunction();
  cout << "1 + 2: " << add(1, 2) << endl;
  Testlib *lib = createTestlib();
  lib->set_millis(2000);
  cout << "Millis: " << lib->get_millis() << endl;
  lib->count();
  Frame *pic = lib->get_frame();
  cout << pic->toString();
  cout << "Pixel: " << pic->at(0, 0).toString() << endl;

  destroyTestlib(lib);
  loader.unload();
  return 0;
}
