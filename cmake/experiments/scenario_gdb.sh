#!/usr/bin/bash

readonly BUILD=build
readonly EXE=titi

# ------------------------------------------------------------------------------
[ -d ${BUILD} ] && rm -rf ${BUILD}
mkdir ${BUILD}

# ------------------------------------------------------------------------------
cd ${BUILD}

cmake -DCMAKE_BUILD_TYPE=Debug ..  # generate symbols usable with GDB
make

# ------------------------------------------------------------------------------
gdb ./${EXE}

# ------------------------------------------------------------------------------
# Then in GDB
#
# (gdb) b main
# (gdb) r # "Shortcut Ctrl^x + o (Terminal User Interface, semi-graphical mode)"
# (gdb) n
# (gdb) q
# (gdb) y
# ------------------------------------------------------------------------------
