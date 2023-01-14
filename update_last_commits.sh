#!/bin/sh

set -e

OPENBSD=/scratch/openbsd/git/src/
LLVM=/scratch/llvm/llvm-project/

BINDIR=/scratch/openbsd/update

cd "$OPENBSD"
git rev-parse HEAD > $BINDIR/last_commit_openbsd
#cd "$LLVM"
#git rev-parse HEAD > $BINDIR/last_commit_llvm
