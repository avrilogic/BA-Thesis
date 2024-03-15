cmake_minimum_required(VERSION 3.19)
project(sideloadlib VERSION 1.0 LANGUAGES CXX)

# Gebe zusätzliche Hinweise auf Fehler und Warnungen
set(CMAKE_C_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS "-Wall -Wextra")

set(CMAKE_CXX_STANDARD 11)
add_library(${CMAKE_PROJECT_NAME} SHARED src/customlib.cpp)
set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES POSITION_INDEPENDENT_CODE ON)
