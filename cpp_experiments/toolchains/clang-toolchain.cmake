# clang-toolchain.cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

# Setzen Sie hier zusätzliche Flags, wenn nötig
set(CMAKE_C_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS "-Wall -Wextra")