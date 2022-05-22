# MT Exercise 5: Byte Pair Encoding, Beam Search

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), download
data and train & evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

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

The data is only minimally preprocessed, so you may want to tokenize it and apply any further preprocessing steps.

Preprocessing:
- Sub-sample parallel training data randomly to 100k sentence pairs
  - Either use the random_train_subset parameter in the data section of the configuration to load only a random subset of the training data
  - Or use the following script in advance:


    ./scripts/subsample.sh


- Tokenize the dev, test, and (subsampled) train data:


    ./scripts/tokenize.sh


Train the word-level model:

    ./scripts/train_wordlevel.sh

• For the BPE-level JoeyNMT model, we recommend to build a single (= the same for
both languages) vocabulary file before training, using a script that comes with JoeyNMT
that extracts a vocabulary file from input text:
python tools/joeynmt/scripts/build_vocab.py \
[input source text] [input target text] \
--output_path [path to save vocab file]
For the BPE-level NMT model, do not use src voc limit and trg voc limit in the
config. Use src vocab and trg vocab instead to point to the vocab file.


Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate a trained model with

    ./scripts/evaluate.sh
