#!/bin/sh

FIXPATCH=/scratch/openbsd/update/fix-paths.sh

DIR=$1

if [ -z $DIR ]; then
  echo "Need directory file"
  exit
fi

for x in `find $DIR -type f -name '*.patch'`; do
  $FIXPATCH $x
  git apply --check $x
  if [ $? = 0 ]; then
    git am --3way $x
  else
    echo "Patch did not apply: $x"
    echo "Initiating manual merge. This will probably fail."
    echo "When done use git am --continue to commit and then return here and press Enter"
    git am --3way $x
    read w?"Press Enter to continue"
  fi
done

echo "All done!"
