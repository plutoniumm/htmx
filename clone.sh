#!/bin/bash

# zip all repos with '-' in the name
dirs=$(ls -d */ | grep -E '.*-.*');
for dir in $dirs; do
  dir=${dir%/};
  echo "zipping $dir";
  zip -qr $dir.zip $dir;
done