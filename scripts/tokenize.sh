#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
tokenized=$base/tokenized

mkdir -p $tokenized

src=en
trg=it
direction=en-it

# cloned from https://github.com/bricksdont/moses-scripts
MOSES=$base/tools/moses-scripts/scripts

# measure time

SECONDS=0

echo "###############################################################################"
echo "tokenizing..."

# tokenize dev files

cat $data/dev.$direction.$src | $MOSES/tokenizer/tokenizer.perl -l $src > $tokenized/dev.$direction.tokenized.$src
cat $data/dev.$direction.$trg | $MOSES/tokenizer/tokenizer.perl -l $trg > $tokenized/dev.$direction.tokenized.$trg

# tokenize train files

cat $data/sampled_train.$src | $MOSES/tokenizer/tokenizer.perl -l $src > $tokenized/train.$direction.tokenized.$src
cat $data/sampled_train.$trg | $MOSES/tokenizer/tokenizer.perl -l $trg > $tokenized/train.$direction.tokenized.$trg

# tokenize test files

cat $data/test.$direction.$src | $MOSES/tokenizer/tokenizer.perl -l $src > $tokenized/test.$direction.tokenized.$src
cat $data/test.$direction.$trg | $MOSES/tokenizer/tokenizer.perl -l $trg > $tokenized/test.$direction.tokenized.$trg


echo "time taken:"
echo "$SECONDS seconds"
