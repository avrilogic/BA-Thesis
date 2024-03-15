# arm64-toolchain.cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(CROSS_COMPILE_PREFIX aarch64-linux-gnu)

set(CMAKE_C_COMPILER ${CROSS_COMPILE_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER ${CROSS_COMPILE_PREFIX}-g++)

# Hier können Sie weitere spezifische Flags und Einstellungen hinzufügen
