# MT Exercise 5: Byte Pair Encoding, Beam Search

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), download
data and train & evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps
## Preparations

Clone this repository in the desired place:

    git clone https://github.com/emmavdbold/mt-exercise-5

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

    source scripts/../venvs/torch3/bin/activate

Download and install required software:

    ./scripts/download_install_packages.sh

Download data:

    ./scripts/download_iwslt_2017_data.sh

## General Preprocessing

The data is only minimally preprocessed, so we tokenize it for all models.

Sub-sample parallel training data randomly to 100k sentence pairs using the following script in advance as shown in our example:

    ./scripts/subsample.sh

Tokenize the dev, test, and (subsampled) train data:

    ./scripts/tokenize.sh

## Word-level Model
Train the word-level model:

    ./scripts/train_wordlevel.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

## BPE-level Models
### BPE Preprocessing
Before training the BPE-level models, use the following scripts to learn byte pair encoding 
on the concatenation of the training text, and get resulting vocabulary for each:

    ./scripts/learn_joint_bpe1_and_vocab.sh
    ./scripts/learn_joint_bpe2_and_vocab.sh

Apply the BPE models to all files with the following scripts:

    ./scripts/apply_bpe1.sh
    ./scripts/apply_bpe2.sh

Build a single (= the same for both languages) vocabulary file before training, 
using a script that comes with JoeyNMT that extracts a vocabulary file from 
input text:

    ./scripts/build_vocab_bpe1.sh
    ./scripts/build_vocab_bpe2.sh


### BPE Training
Train the first BPE-level model (voc size 2000):

    ./scripts/train_bpe1.sh

Train the second BPE-level model (voc size 1000):

    ./scripts/train_bpe2.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.


## Evaluation
Evaluate the trained word-level model with

    ./scripts/evaluate_word.sh

Evaluate the first trained BPE-level model with

    ./scripts/evaluate_bpe1.sh

Evaluate the second trained BPE-level model with

    ./scripts/evaluate_bpe2.sh


The results of this evaluation are the following:

--- | use BPE | vocabulary size | BLEU |
 --- | --- | --- | --- | --- |
a) word-level | no | 2000 | ? |
 --- | --- | --- | --- | --- |
b) bpe-level1 | yes | 2000 | ? |
 --- | --- | --- | --- | --- |
c) bpe-level2 | yes | 1000 | ? |


