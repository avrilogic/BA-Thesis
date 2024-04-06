#!/bin/bash
echo "Compiling sample.cpp with gcc to object file sample.a"
gcc sample.cpp -c -o sample.a
echo "Listing function symbols in sample.a with readelf"
readelf -sW sample.a | awk '/Num:/ || (/GLOBAL DEFAULT/ && /mangle/)'
echo "Listing function symbols in sample.a with nm"
nm sample.a | awk '/T/ && /mangle/'