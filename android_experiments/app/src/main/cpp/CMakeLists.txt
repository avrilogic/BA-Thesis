cmake_minimum_required(VERSION 3.22.1)

project("androidjni")

add_library(${CMAKE_PROJECT_NAME} SHARED
        lib.cpp
        )


target_link_libraries(${CMAKE_PROJECT_NAME}
        # List libraries link to the target library
        android
        log)