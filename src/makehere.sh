#!/bin/zsh
# Create a Makefile in the current directory.

echo 'all:' > Makefile
echo '\tclang++ -std=c++17 main.cpp -o main' >> Makefile

exit 0
