cmake_minimum_required(VERSION 3.5)

project(app LANGUAGES CXX)

add_library(mylib src/lib/lib.cpp)

add_executable(app src/app.cpp)
add_executable(appso src/appso.cpp)

target_link_libraries(app mylib)
file(GLOB MY_LIBRARIES "${LIBRARY_PATH}/libcustomlib_static.*")
target_link_libraries(app ${MY_LIBRARIES})

# Setze Variablen abhängig von der Plattform
if(WIN32)
    set(MY_LIBRARY_NAME "libcustomlib_shared.dll")
else()
    set(MY_LIBRARY_NAME "./libcustomlib_shared.so")
endif()

# Konfiguriere eine Header-Datei, um die Bibliotheksnamen zu übergeben
configure_file(src/config.h.in config.h)
target_include_directories(appso PRIVATE ${CMAKE_BINARY_DIR})