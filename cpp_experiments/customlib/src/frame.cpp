#include "frame.h"


Pixel::Pixel() : r(0), g(0), b(0) {}

Pixel::Pixel(uint8_t red, uint8_t green, uint8_t blue) : r(red), g(green), b(blue) {}

char *Pixel::toString()
{
    char *str = new char[32];
    sprintf(str, "Pixel: %d, %d, %d", r, g, b);
    return str;
}


Frame::Frame(uint32_t width, uint32_t height) : width(width), height(height) {
    pixels.resize(width * height);
};

Pixel& Frame::at(uint32_t x, uint32_t y) {
    return pixels[y * width + x];
}

const Pixel& Frame::at(uint32_t x, uint32_t y) const {
    return pixels[y * width + x];
}


char *Frame::toString()
{
    char *str = new char[32];
    sprintf(str, "Frame: %d, %d \n", width, height);
    return str;
}
