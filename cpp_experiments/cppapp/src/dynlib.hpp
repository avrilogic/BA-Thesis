// Interface for the dynamic library

#include <iostream>
#include <cstdint>
#include <vector>
#ifdef _WIN32
#include <windows.h>
#else
#include <dlfcn.h>
#endif

struct Pixel
{
  uint8_t r;                                       // Rot-Anteil
  uint8_t g;                                       // Grün-Anteil
  uint8_t b;                                       // Blau-Anteil
  virtual char *toString();                        // Methode zur Ausgabe der Werte
  virtual ~Pixel();                                // Destruktor
};

struct Frame
{
  std::vector<Pixel> pixels; // Die Pixel des Frames
  uint32_t width;            // Die Breite des Frames
  uint32_t height;           // Die Höhe des Frames

  Frame(uint32_t w, uint32_t h) : width(w), height(h)
  {
    pixels.resize(width * height);
  };
  virtual ~Frame(){}
  virtual Pixel &at(uint32_t x, uint32_t y);
  virtual const Pixel &at(uint32_t x, uint32_t y) const;
  virtual char *toString();
};

extern int add(int x, int y);

struct Version
{
  /* data */
  int major;
  int minor;
};

// Path: app/src/dynlib.h
class Testlib
{
public:
  virtual char get_char();
  virtual Version get_version();
  virtual void set_millis(long millis);
  virtual long get_millis();
  virtual Frame *get_frame();
  virtual void count();
  virtual ~Testlib() {}

private:
  long millis;
};

// Typedef für die Funktionen
typedef int (*add_t)(int, int);
typedef Testlib *(*createTestlib_t)();
typedef void (*destroyTestlib_t)(Testlib *);

class DllLoader
{
public:
  bool load(const char *path)
  {
#ifdef _WIN32
    lib_handle = LoadLibraryA(path);
#else
    lib_handle = dlopen(path, RTLD_LAZY);
#endif
    if (!lib_handle)
    {
      std::cerr << "Fehler beim Laden der Bibliothek: " << path << std::endl;
    }
    return lib_handle != nullptr ? true : false;
  }
  void unload()
  {
#ifdef DEBUG
    std::cout << "Unloading library" << std::endl;
#endif
#ifdef _WIN32
    FreeLibrary((HMODULE)lib_handle);
#else
    dlclose(lib_handle);
#endif
  }
  void *getFunction(const char *name)
  {
    void *func = nullptr;
#ifdef _WIN32
    func = reinterpret_cast<void *>(GetProcAddress(static_cast<HMODULE>(lib_handle), name));
    if (!func)
    {
      std::cerr << "Fehler beim Laden der Funktion" << std::endl;
      unload();
      exit(1);
    }
#else
    func = dlsym(lib_handle, name);
    const char *error = dlerror();
    if (error != NULL)
    {
      std::cerr << "Fehler beim Laden der Funktion: " << error << std::endl;
      unload();
      exit(1);
    }
#endif
    return func;
  }
  ~DllLoader()
  {
    if (lib_handle)
    {
      unload();
    }
  }

  add_t getAddFunction()
  {
    return (add_t)getFunction("add");
  }

  createTestlib_t getCreateTestlibFunction()
  {
#ifdef DEBUG
    std::cout << "Getting createTestlib function" << std::endl;
#endif
    return (createTestlib_t)getFunction("createTestlib");
  }

  destroyTestlib_t getDestroyTestlibFunction()
  {
#ifdef DEBUG
    std::cout << "Getting destroyTestlib function" << std::endl;
#endif
    return (destroyTestlib_t)getFunction("destroyTestlib");
  }

private:
  void *lib_handle;
};
