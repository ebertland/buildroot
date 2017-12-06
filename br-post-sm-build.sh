#!/bin/bash -p

# │ These scripts are called with the images directory name as            │
# │ first argument. The script is executed from the main Buildroot        │
# │ source directory as the current directory.                            │

OUTPUT=$1
TOPDIR=$(pwd)

echo "Running Cerebras SM post build script..."
echo "----------------------------------------"

echo "Copying Cerebras SM skeleton files"
tar -C $TOPDIR/cerebras/sm-skel -cf - . | (cd $OUTPUT && tar xf -)
