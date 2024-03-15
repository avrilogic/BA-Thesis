cmake_minimum_required(VERSION 3.19)
project(customlib VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(MINGW_STD_THREADS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../dependencies/extern/mingw-std-threads)
include_directories(${MINGW_STD_THREADS_DIR})

# Erstelle eine statische Bibliothek
add_library(${CMAKE_PROJECT_NAME}_static STATIC src/staticlib.cxx src/frame.cpp)

# Das Setzen von POSITION_INDEPENDENT_CODE auf ON stellt sicher, 
# dass die -fPIC-Flag während der Kompilierung verwendet wird.
# Shared Libraries müssen mit der Position Independent Code (PIC) Option kompiliert  werden.
set_target_properties(${CMAKE_PROJECT_NAME}_static PROPERTIES POSITION_INDEPENDENT_CODE ON)

# Konfiguriere eine Header-Datei
configure_file(src/version.h.in version.h)

# Setze Include-Verzeichnisse für die statische Bibliothek
target_include_directories(${CMAKE_PROJECT_NAME}_static PUBLIC "${PROJECT_BINARY_DIR}")

# Erstelle eine Shared Library aus der static Library
add_library(${CMAKE_PROJECT_NAME}_shared SHARED $<TARGET_OBJECTS:${CMAKE_PROJECT_NAME}_static>)
