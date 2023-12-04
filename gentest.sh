#!/bin/zsh

# A script to generate test cases for Quera.
inputs=(15 20 25 39 44 55 67 80 82 85 92)

for ((i = 1; i <= ${#inputs[@]}; i++)); do
    echo ${inputs[i]} > in/input${i}.txt
    ./main < in/input${i}.txt > out/output${i}.txt
done

exit 0
