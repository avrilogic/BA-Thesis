# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /mnt/e/code/BA-Thesis/cmake/customlib

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/e/code/BA-Thesis/cmake/customlib/build/clang

# Include any dependencies generated for this target.
include CMakeFiles/customlib_shared.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/customlib_shared.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/customlib_shared.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/customlib_shared.dir/flags.make

# Object files for target customlib_shared
customlib_shared_OBJECTS =

# External object files for target customlib_shared
customlib_shared_EXTERNAL_OBJECTS = \
"/mnt/e/code/BA-Thesis/cmake/customlib/build/clang/CMakeFiles/customlib_static.dir/src/staticlib.cxx.o" \
"/mnt/e/code/BA-Thesis/cmake/customlib/build/clang/CMakeFiles/customlib_static.dir/src/frame.cpp.o"

libcustomlib_shared.so: CMakeFiles/customlib_static.dir/src/staticlib.cxx.o
libcustomlib_shared.so: CMakeFiles/customlib_static.dir/src/frame.cpp.o
libcustomlib_shared.so: CMakeFiles/customlib_shared.dir/build.make
libcustomlib_shared.so: CMakeFiles/customlib_shared.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/e/code/BA-Thesis/cmake/customlib/build/clang/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Linking CXX shared library libcustomlib_shared.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/customlib_shared.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/customlib_shared.dir/build: libcustomlib_shared.so
.PHONY : CMakeFiles/customlib_shared.dir/build

CMakeFiles/customlib_shared.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/customlib_shared.dir/cmake_clean.cmake
.PHONY : CMakeFiles/customlib_shared.dir/clean

CMakeFiles/customlib_shared.dir/depend:
	cd /mnt/e/code/BA-Thesis/cmake/customlib/build/clang && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/e/code/BA-Thesis/cmake/customlib /mnt/e/code/BA-Thesis/cmake/customlib /mnt/e/code/BA-Thesis/cmake/customlib/build/clang /mnt/e/code/BA-Thesis/cmake/customlib/build/clang /mnt/e/code/BA-Thesis/cmake/customlib/build/clang/CMakeFiles/customlib_shared.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/customlib_shared.dir/depend

