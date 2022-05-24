# !/usr/bin/python
# -*- coding: utf-8 -*-

# Run this script with the following command:
# $ python3 create_graph.py INPUT_FOLDER
# i.e.: $ python3 create_graph.py ./translations/results


import argparse
import os


def get_parser() -> argparse.ArgumentParser:
    """Returns the given command line arguments."""
    parser = argparse.ArgumentParser("Compute BLEU score of translated text")
    parser.add_argument("files", type=str, help="path to evaluation result files to read in")

    return parser


def read_results(input_files):
    """
    Function to open a text file and read all sentences into memory, as strings, and return all tokenized sentences.
    For tokenization, Sacremoses is used.
    :return: all tokenized sentences
    """
    beams = []
    BLEUs = []

    # Loop over all input files and store the beam size and BLEU score
    for filename in os.listdir(input_files):
        file = os.path.join(input_files, filename)
        beams.append(filename)
        with open(file, 'r', encoding='utf-8') as file:
            for line in file:
                if 'score' in line:
                    BLEUs.append(line.split()[-1])

    return beams, BLEUs


def main():
    """
    Main function to read in the evaluation result files that are specified as arguments on the command line.
    The beam sizes and BLEU scores are returned.
    """
    # Get command line arguments
    parser = get_parser()
    args = parser.parse_args()

    # Store arguments
    result_files = args.files

    # Read in two text files (specified as arguments on command line)
    BLEU, beam = read_results(result_files)
    print(BLEU)
    print(beam)


if __name__ == '__main__':
    main()