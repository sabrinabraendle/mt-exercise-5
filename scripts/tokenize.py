# !/usr/bin/python
# -*- coding: utf-8 -*-

# Run this script with the following command:
# $ python3 tokenize.py INPUT_FILE LANG > OUTPUT_FILE
# e.g.: $ python3 tokenize.py data/dev.en-it.en en > tokenized/dev.en-it.tokenized.en


import argparse
from sacremoses import MosesTokenizer


def get_parser() -> argparse.ArgumentParser:
    """Returns the given command line arguments."""
    parser = argparse.ArgumentParser("Compute BLEU score of translated text")
    parser.add_argument("file", type=str, help="path to file to be tokenized")
    parser.add_argument("lang", type=str, help="language of input text")

    return parser


def read_sents(input_file, lang):
    """
    Function to open a text file and read all sentences into memory, as strings, and return all tokenized sentences.
    For tokenization, Sacremoses is used.
    :return: all tokenized sentences
    """
    sents = []
    tokenized_sents = []

    # Open a text file and read sentences as strings into memory
    with open(input_file, 'r', encoding='utf-8') as file:
        for line in file:
            sents.append(line.strip('\n'))

    # Tokenize all sentences
    mt = MosesTokenizer(lang=lang)

    for sent in sents:
        tokenized = mt.tokenize(sent.lower())
        tokenized_sents.append(tokenized)

    return tokenized_sents


def main():
    """
    Main function to read in two text files that are specified as arguments on the command line.
    The tokenized sentences are given to the function that computes BLEU.
    :return: the final BLEU score as a single number
    """
    # Get command line arguments
    parser = get_parser()
    args = parser.parse_args()

    # Store arguments
    text = args.file
    language = args.lang

    # Read in two text files (specified as arguments on command line)
    sents = read_sents(text, language)
    print(sents)


if __name__ == '__main__':
    main()