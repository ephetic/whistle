#!/bin/sh

rm -rf build

for piece in fipple mouthpiece window pipe last
do
  ./build.sh $piece
done



  # if (piece == "mouthpiece") mouth();
  # if (piece == "window") win();
  # if (piece == "fipple") fip();
  # if (piece == "pipe") non_last();
  # if (piece == "last") last();
