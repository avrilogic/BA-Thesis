#pragma once
#include "frame.h"
#include "version.h"
#include <chrono>
#include <iostream>
#ifdef _WIN32
#include "mingw.thread.h"
#include "mingw.mutex.h"
#include "mingw.condition_variable.h"
#else
#include <thread>
#include <mutex>
#include <condition_variable>
#endif

struct  Version
{
  /* data */
  int major;
  int minor;
};

class Testlib
{
public:
  virtual char get_char();
  virtual Version get_version();
  virtual void set_millis(long millis);
  virtual long get_millis();  
  virtual Frame* get_frame();
  virtual void count();
  virtual ~Testlib() {}
 private:
  long millis;

};

