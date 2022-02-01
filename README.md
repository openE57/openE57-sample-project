# openE57-sample-project

Demo showing how to integrate OpenE57 in your existing project.

This is in **alpha** state and requires a refinement.

## How to run the example

1. compile the `openE57` project following the instructions at https://github.com/openE57/openE57
2. copy the resulting folder `build/redist-openE57-v1.x.x` to a new folder in this project and rename it to `openE57`: 

```sh
mkdir build
cp -r ../open57/build/redist-openE57-v1.x.x build/openE57
```

3. Run the command `conan install .. --build=missing`
4. Run the command `cmake ..`
5. Run the command `make`
