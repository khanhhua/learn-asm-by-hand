#!/bin/bash
echo "Building $1 ..."
MAKE_DIR=$(dirname "$1")
PROG_NAME=$(basename "$1")
make --makefile=$(pwd)/makefile -C $MAKE_DIR $PROG_NAME
