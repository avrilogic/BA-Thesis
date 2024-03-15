#include "staticlib.h"
#include <iostream>

using namespace std;
extern "C" int add(int x, int y)
{
  return x + y;
}

extern "C" Testlib* createTestlib(){
    return new Testlib();
}

extern "C" void destroyTestlib(Testlib* testlib){
    delete testlib;
}

char Testlib::get_char()
{
  return 'a';
}

Version Testlib::get_version()
{
  
  Version v;
  v.major = 1;
  v.minor = 0;
  return v;
}

void Testlib::set_millis(long millis)
{
  #ifdef DEBUG
  cout << "Setting millis to " << millis << endl;
  #endif
  this->millis = millis;
}

long Testlib::get_millis()
{
  #ifdef DEBUG
  cout << "Getting millis" << endl;
  #endif
  return millis;
}

Frame *Testlib::get_frame()
{
  #ifdef DEBUG
  cout << "Getting frame" << endl;
  #endif
  Frame *frame = new Frame(32, 32);
  for (uint32_t y = 0; y < frame->height; y++)
  {
    for (uint32_t x = 0; x < frame->width; x++)
    {
      // cout << "Setting pixel at " << x << ", " << y << endl;
      frame->at(x, y) = Pixel(0, 0, 0);
    }
  }
  return frame;
}

void Testlib::count() {
    #ifdef DEBUG
    cout << "Counting to " << n << endl;
    #endif
    for (int i = millis; i > 0; --i) {
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
        if(i % 1000 == 0) {
            cout << i/1000 << " Sekunde(n)" << endl;
        }
    }
}
