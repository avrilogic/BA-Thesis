cmake_minimum_required(VERSION 3.22)
project(cppjnilib VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(${CMAKE_PROJECT_NAME} SHARED  
  src/jni/JavaJniExperiment.cpp)
find_package(JNI REQUIRED)
include_directories(${JNI_INCLUDE_DIRS} src/libs/)
link_libraries(${JNI_LIBRARIES})
