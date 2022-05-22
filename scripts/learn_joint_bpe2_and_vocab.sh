#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

src=en
trg=it
direction=en-it
vocab=$base/vocab
bpe_models=$base/bpe_models
bpe_model_name=bpe2
model_path=$bpe_models/$bpe_model_name
voc_size=1000

mkdir -p $vocab
mkdir -p $bpe_models

input_src=$base/tokenized/train.$direction.tokenized.$src
input_trg=$base/tokenized/train.$direction.tokenized.$trg
voc_output_src=$base/vocab/vocab.$bpe_model_name.$src
voc_output_trg=$base/vocab/vocab.$bpe_model_name.$trg

# measure time

SECONDS=0

subword-nmt learn-joint-bpe-and-vocab --input $input_src $input_trg --write-vocabulary $voc_output_src $voc_output_trg \
-s $voc_size --total-symbols -o $model_path

echo "time taken:"
echo "$SECONDS seconds"
