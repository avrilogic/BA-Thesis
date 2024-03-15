# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(ffigen_test_plugin_library VERSION 0.0.1 LANGUAGES CXX)

add_library(ffigen_test_plugin SHARED
  "ffigen_test_plugin.cpp"
)

set_target_properties(ffigen_test_plugin PROPERTIES
  PUBLIC_HEADER ffigen_test_plugin.h
  OUTPUT_NAME "ffigen_test_plugin"
)

target_compile_definitions(ffigen_test_plugin PUBLIC DART_SHARED_LIB)
