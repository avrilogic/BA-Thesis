#pragma once
#include <cstdint>
#include <vector>

// Ein einfacher RGB-Pixel
struct Pixel {
    uint8_t r; // Rot-Anteil
    uint8_t g; // Grün-Anteil
    uint8_t b; // Blau-Anteil
    Pixel(); // Konstruktor-Deklaration
    Pixel(uint8_t red, uint8_t green, uint8_t blue); // Überladener Konstruktor mit Parametern
};

struct Frame {
    std::vector<Pixel> pixels; // Die Pixel des Frames
    uint32_t width; // Die Breite des Frames
    uint32_t height; // Die Höhe des Frames

    Frame(uint32_t w, uint32_t h);
    Pixel& at(uint32_t x, uint32_t y);
    const Pixel& at(uint32_t x, uint32_t y) const;
};


extern int add(int x, int y);

struct  Version
{
  /* data */
  int major;
  int minor;
};

class Testlib
{
public:
  char get_char();
  Version get_version();
  void set_millis(long millis);
  long get_millis();  
  Frame* get_frame();
 private:
  long millis;
};
extern Testlib* createTestlib(); 