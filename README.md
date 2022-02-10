# openE57-sample-project

Demo showing how to integrate OpenE57 in your existing project.

This is in **alpha** state and requires a refinement.

## How to run the example

1. Build the `openE57` conan package following the instructions at https://github.com/openE57/openE57

2. Proceed with the following instructions:
```sh
mkdir build
conan install .. --build=missing
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .
cmake --install . 
```