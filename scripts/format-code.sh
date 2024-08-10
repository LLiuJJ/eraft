#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
SRCPATH=$(cd $SCRIPTPATH/..; pwd -P)

clang-format -style=file --sort-includes -i ${SRCPATH}/raftcore/src/*.cc
clang-format -style=file --sort-includes -i ${SRCPATH}/raftcore/include/eraft/*.h
clang-format -style=file --sort-includes -i ${SRCPATH}/example/src/*.cc
clang-format -style=file --sort-includes -i ${SRCPATH}/example/include/*.h
