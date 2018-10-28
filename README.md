# IntegerDeterminant
Description is in progress but it will be 100% pure


## Overview
Initial goal of this project was to create program/unit for calculation
of determinant of integers.

Obviously, such a determinant will be an integer so this program
shouldn't use floating numbers and still be efficient enough.

Current version makes use of Gauss' method adjusted for integers
which implies the algorithm is expected to run in polynomial time


## Project structure
Project is split in two folders:
1. `C++/` which corresponds to the draft version:
    * `det.cpp` contains source code
    * `det.h` should be included in client code files
    * `gen.cpp` simple random matrix generator
    * `test.cpp` simple test program 
      (also can be considered an example of usage)
2. `Haskell` which contains version above rewritten in Haskell


## License
You can do what the fuck you want with this project
