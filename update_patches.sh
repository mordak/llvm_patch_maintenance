#!/bin/sh

set -e

OPENBSD=/scratch/openbsd/git/src/
OPENBSD_BRANCH=master
LLVM=/scratch/llvm/llvm-project/
LLVM_BRANCH="openbsd-release/13.x openbsd-release/15.x openbsd-release/16.x openbsd-main"

PATCHDIR=/tmp/llvm-patches
BINDIR=/scratch/openbsd/update

mkdir "$PATCHDIR"

cd "$OPENBSD"
git checkout "$OPENBSD_BRANCH"
git pull
$BINDIR/extract-patches.sh "$PATCHDIR"

cd "$LLVM"
# Fetch upstream
git fetch origin
for BRANCH in $LLVM_BRANCH ; do
  git checkout "$BRANCH"
  UPSTREAM=`echo $BRANCH | sed 's/^openbsd-/origin\//'`
  # Merge in upstream changes
  if ! git merge $UPSTREAM; then
    read w?"Git merge failed. Fix, commit, and then press Enter to continue"
  fi

  read ans?"Apply patches to $BRANCH [y/N]? "
  if [ "$ans" == "y" -o "$ans" == "Y" ]; then
    $BINDIR/apply-patches.sh "$PATCHDIR"
  fi

  read ans?"Push $BRANCH [y/N]? "
  if [ "$ans" == "y" -o "$ans" == "Y" ]; then
    git push openbsd
    LOCAL=`echo $BRANCH | sed 's/^openbsd-//'`
    git checkout $LOCAL
    git pull
    git push openbsd
  fi
done

$BINDIR/update_last_commits.sh

read ans?"Delete patches in $PATCHDIR [y/N]? "
if [ "$ans" == "y" -o "$ans" == "Y" ]; then
  rm -rf "$PATCHDIR"
fi
