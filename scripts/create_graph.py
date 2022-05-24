# !/usr/bin/python
# -*- coding: utf-8 -*-

# Run this script with the following command:
# $ python3 create_graph.py INPUT_FOLDER
# i.e.: $ python3 ./scripts/create_graph.py ./translations/results


import argparse
import os
import matplotlib.pyplot as plt


def get_parser() -> argparse.ArgumentParser:
    """Returns the given command line arguments."""
    parser = argparse.ArgumentParser("Compute BLEU score of translated text")
    parser.add_argument("files", type=str, help="path to evaluation result files to read in")

    return parser


def read_results(input_files):
    """
    Function to open all files in a directory and read all beam sizes and BLEU scores into memory.
    """
    beams = []
    BLEUs = []

    # Loop over all input files and store the beam size and BLEU score
    for filename in os.listdir(input_files):
        file = os.path.join(input_files, filename)
        beams.append(int(filename.split('_')[1].strip('k')))
        with open(file, 'r', encoding='utf-8') as file:
            for line in file:
                if '"score"' in line:
                    BLEUs.append(float(line.split()[-1].strip(',')))

    return beams, BLEUs


def create_graph(beam_sizes, BLEU_scores):
    """
    Function to create graph with beam sizes on the x-axis and BLEU scores on the y-axis.
    """
    plt.plot(beam_sizes, BLEU_scores)


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
    beam, BLEU = read_results(result_files)

    graph = create_graph(beam, BLEU)
    print(graph)


if __name__ == '__main__':
    main()