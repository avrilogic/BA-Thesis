#pragma once
#include <vector>
#include <cstdint> // Für uint8_t, uint32_t etc.
#include <cstdio>

// Ein einfacher RGB-Pixel
struct Pixel {
    uint8_t r; // Rot-Anteil
    uint8_t g; // Grün-Anteil
    uint8_t b; // Blau-Anteil
    Pixel(); // Konstruktor-Deklaration
    Pixel(uint8_t red, uint8_t green, uint8_t blue); // Überladener Konstruktor mit Parametern
    virtual char *toString();   
    virtual ~Pixel() {}
};

struct Frame {
    std::vector<Pixel> pixels; // Die Pixel des Frames
    uint32_t width; // Die Breite des Frames
    uint32_t height; // Die Höhe des Frames

    Frame(uint32_t w, uint32_t h) ;
    virtual ~Frame() { }
    virtual Pixel& at(uint32_t x, uint32_t y);
    virtual const Pixel& at(uint32_t x, uint32_t y) const;
    virtual char *toString();
};
