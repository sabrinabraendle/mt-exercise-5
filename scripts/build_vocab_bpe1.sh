#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..


src=en
trg=it
direction=en-it
bpe_model_name=bpe1

bpe_files=$base/bpe_files

BPE_train=$base/$bpe_files/train.$direction.$bpe_model_name

voc_output=$base/vocab/vocab.$bpe_model_name

# measure time

SECONDS=0

python tools/joeynmt/scripts/build_vocab.py $BPE_train.$src $BPE_train.$trg --output_path $voc_output.joint
# python tools/joeynmt/scripts/build_vocab.py $voc_output.$src $voc_output.$trg --output_path $voc_output.joint

echo "time taken:"
echo "$SECONDS seconds"
