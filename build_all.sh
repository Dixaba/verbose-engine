#!/bin/bash

for NAME in latest-buildx86 latest latest-buildx64 latest-x64 latest-both
do
  ./build.sh $NAME tag
done