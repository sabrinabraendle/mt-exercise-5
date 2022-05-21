#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

file1=$data/train.en-it.en
file2=$data/train.en-it.it

# measure time

SECONDS=0

# https://stackoverflow.com/questions/49037494/randomly-sample-n-lines-from-two-text-filesparallel-corpus-consistently


echo "###############################################################################"
echo "subsampling 100k lines from files:"
echo $file1
echo $file2


echo "###############################################################################"
echo "time taken:"
echo "$SECONDS seconds"
