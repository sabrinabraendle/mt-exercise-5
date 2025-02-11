#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

file1=$data/train.en-it.en
file2=$data/train.en-it.it
sample=data/sampled_train.both
sample1=data/sampled_train.en
sample2=data/sampled_train.it

# measure time

SECONDS=0

# https://stackoverflow.com/questions/49037494/randomly-sample-n-lines-from-two-text-filesparallel-corpus-consistently


echo "###############################################################################"
echo "subsampling 100k lines from parallel files:"
echo $file1
echo $file2

paste -d'|' $file1 $file2 | cat -n | shuf -n 100000 | sort -n | cut -f2 > $sample
cut -d'|' -f1 $sample > $sample1
cut -d'|' -f2 $sample > $sample2

echo "###############################################################################"
echo "time taken:"
echo "$SECONDS seconds"
