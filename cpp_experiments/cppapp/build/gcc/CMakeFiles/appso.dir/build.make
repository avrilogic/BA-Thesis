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
CMAKE_SOURCE_DIR = /mnt/e/code/BA-Thesis/cmake/cppapp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/e/code/BA-Thesis/cmake/cppapp/build/gcc

# Include any dependencies generated for this target.
include CMakeFiles/appso.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/appso.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/appso.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/appso.dir/flags.make

CMakeFiles/appso.dir/src/appso.cpp.o: CMakeFiles/appso.dir/flags.make
CMakeFiles/appso.dir/src/appso.cpp.o: ../../src/appso.cpp
CMakeFiles/appso.dir/src/appso.cpp.o: CMakeFiles/appso.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/e/code/BA-Thesis/cmake/cppapp/build/gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/appso.dir/src/appso.cpp.o"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/appso.dir/src/appso.cpp.o -MF CMakeFiles/appso.dir/src/appso.cpp.o.d -o CMakeFiles/appso.dir/src/appso.cpp.o -c /mnt/e/code/BA-Thesis/cmake/cppapp/src/appso.cpp

CMakeFiles/appso.dir/src/appso.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/appso.dir/src/appso.cpp.i"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /mnt/e/code/BA-Thesis/cmake/cppapp/src/appso.cpp > CMakeFiles/appso.dir/src/appso.cpp.i

CMakeFiles/appso.dir/src/appso.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/appso.dir/src/appso.cpp.s"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /mnt/e/code/BA-Thesis/cmake/cppapp/src/appso.cpp -o CMakeFiles/appso.dir/src/appso.cpp.s

# Object files for target appso
appso_OBJECTS = \
"CMakeFiles/appso.dir/src/appso.cpp.o"

# External object files for target appso
appso_EXTERNAL_OBJECTS =

appso: CMakeFiles/appso.dir/src/appso.cpp.o
appso: CMakeFiles/appso.dir/build.make
appso: CMakeFiles/appso.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/e/code/BA-Thesis/cmake/cppapp/build/gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable appso"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/appso.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/appso.dir/build: appso
.PHONY : CMakeFiles/appso.dir/build

CMakeFiles/appso.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/appso.dir/cmake_clean.cmake
.PHONY : CMakeFiles/appso.dir/clean

CMakeFiles/appso.dir/depend:
	cd /mnt/e/code/BA-Thesis/cmake/cppapp/build/gcc && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/e/code/BA-Thesis/cmake/cppapp /mnt/e/code/BA-Thesis/cmake/cppapp /mnt/e/code/BA-Thesis/cmake/cppapp/build/gcc /mnt/e/code/BA-Thesis/cmake/cppapp/build/gcc /mnt/e/code/BA-Thesis/cmake/cppapp/build/gcc/CMakeFiles/appso.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/appso.dir/depend

