#!/bin/sh

LASTCOMMIT=/scratch/openbsd/update/last_commit_openbsd
OUTDIR=$1

if [ -z $OUTDIR ]; then
  echo "Need patch dir as argument"
  exit
fi

SINCE=`cat $LASTCOMMIT`

git format-patch -o "$OUTDIR" --relative $SINCE -- gnu/llvm/

