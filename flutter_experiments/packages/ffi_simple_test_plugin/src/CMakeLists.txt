# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(ffi_simple_test_plugin_library VERSION 0.0.1 LANGUAGES CXX)

add_library(${PROJECT_NAME} SHARED
  "ffi_simple_test_plugin.cpp"
)



set_target_properties(${PROJECT_NAME} PROPERTIES
  PUBLIC_HEADER ffi_simple_test_plugin.h
  OUTPUT_NAME "ffi_simple_test_plugin"
  LINKER_LANGUAGE CXX
)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

target_compile_definitions(${PROJECT_NAME} PUBLIC DART_SHARED_LIB)
