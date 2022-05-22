#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..


src=en
trg=it
direction=en-it
bpe_model_name=bpe2

bpe_models=$base/bpe_models
bpe_files=$base/bpe_files

model_path=$bpe_models/$bpe_model_name

mkdir -p $bpe_files

train=$base/tokenized/train.$direction.tokenized
dev=$base/tokenized/dev.$direction.tokenized
test=$base/tokenized/test.$direction.tokenized

BPE_train=$base/$bpe_files/train.$direction.$bpe_model_name
BPE_dev=$base/$bpe_files/dev.$direction.$bpe_model_name
BPE_test=$base/$bpe_files/test.$direction.$bpe_model_name

voc_output=$base/vocab/vocab.$bpe_model_name

# measure time

SECONDS=0

subword-nmt apply-bpe -c $model_path --vocabulary $voc_output.$src --vocabulary-threshold 10 < $train.$src > $BPE_train.$src
subword-nmt apply-bpe -c $model_path --vocabulary $voc_output.$src --vocabulary-threshold 10 < $dev.$src > $BPE_dev.$src
subword-nmt apply-bpe -c $model_path --vocabulary $voc_output.$src --vocabulary-threshold 10 < $test.$src > $BPE_test.$src

subword-nmt apply-bpe -c $model_path --vocabulary $voc_output.$trg --vocabulary-threshold 10 < $train.$trg > $BPE_train.$trg
subword-nmt apply-bpe -c $model_path --vocabulary $voc_output.$trg --vocabulary-threshold 10 < $dev.$trg > $BPE_dev.$trg
subword-nmt apply-bpe -c $model_path --vocabulary $voc_output.$trg --vocabulary-threshold 10 < $test.$trg > $BPE_test.$trg

echo "time taken:"
echo "$SECONDS seconds"
