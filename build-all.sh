#!/bin/sh

rm -rf build

for piece in fipple mouthpiece window
do
  ./build.sh $piece
done