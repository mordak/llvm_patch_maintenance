#!/bin/sh

FILE=$1

if [ -z $FILE ]; then
  echo "Need argument file"
  exit
fi

sed -i.orig -E -e 's/([ab])\/gnu\/llvm\/clang/\1\/clang/g' $FILE
sed -i.orig -E -e 's/([ab])\/gnu\/llvm\/compiler-rt/\1\/compiler-rt/g' $FILE
sed -i.orig -E -e 's/([ab])\/gnu\/llvm\/libcxx/\1\/libcxx/g' $FILE
sed -i.orig -E -e 's/([ab])\/gnu\/llvm\/libcxxabi/\1\/libcxxabi/g' $FILE
sed -i.orig -E -e 's/([ab])\/gnu\/llvm\/libunwind/\1\/libunwind/g' $FILE
sed -i.orig -E -e 's/([ab])\/gnu\/llvm\/lld/\1\/lld/g' $FILE
sed -i.orig -E -e 's/([ab])\/gnu\/llvm\/lldb/\1\/lldb/g' $FILE
sed -i.orig -E -e 's/([ab])\/gnu\/llvm\/llvm/\1\/llvm/g' $FILE
