#!/bin/sh

[ ! -d "./build" ] && mkdir build

echo Building $1.stl
time /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -D \$fn=72 -D build=true -D piece=\"$1\" -o build/$1.stl build.scad