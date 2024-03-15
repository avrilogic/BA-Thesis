#!/bin/bash

# Build app & create Headerfile
echo "Build app & create Headerfile"
(cd app && ./build.sh)

# Build lib
echo "Build lib"
(cd jnilib && ./build.sh clean clang)

# Copy lib to app
echo "Copy lib to app"
mkdir -p app/build
(cd jnilib/build/clang && cp -f *.so ../../../app/build/)

# Run app
echo "Run app"
(cd app && ./run.sh)