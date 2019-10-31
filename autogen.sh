#!/bin/bash

set -ex

if [[ $1 = --help ]]; then
    cat <<EOF
Usage:

  $ ./autogen.sh [--clean]

Remove and rebuild Autotools files (./configure and friends).

  --clean  remove only; do not rebuild

EOF
    exit 0
fi

# Remove existing Autotools stuff, if present. Coordinate with .gitignore.
rm -rf Makefile \
       Makefile.in \
       aclocal.m4 \
       autom4te.cache \
       bin/config.h.in \
       build-aux \
       configure

# Create configure and friends.
if [[ $1 != --clean ]]; then
    aclocal
    autoheader
    autoreconf --install -Wall -Werror
fi
