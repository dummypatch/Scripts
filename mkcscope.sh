#!/bin/sh

rm -rf cscope.out cscope.files


find $PWD \( -name '*.cu' -o -name '*.c' -o -name '*.C' -o -name '*.cpp' -o -name '*.cc' -o -name '*.h' -o -name '*.s' -o -name '*.S' \) -print > cscope.files

cscope -i cscope.files
