#!/bin/bash
echo "Installiere Cross-Compiler"
sudo apt update
sudo apt install -y build-essential gcc-multilib g++-multilib cmake
# ARM64-v8a (AArch64)
sudo apt install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
# armeabi-v7a (ARMv7)
sudo apt install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
# x86 (i686)
sudo apt install -y gcc-11-i686-linux-gnu gcc-i686-linux-gnu g++-i686-linux-gnu
# x86_64
sudo apt install -y gcc-x86-64-linux-gnu g++-x86-64-linux-gnu
echo "Installation der Cross-Compiler abgeschlossen."
