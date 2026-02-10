# source/gen_002.py

import os

def open_file(path):
    for line in open(path, "r"):
        yield line
    
if __name__ == "__main__":
    CWD = os.path.abspath(os.path.dirname(__file__))
    PATH = os.path.join(CWD, "error.log")
    line_lengths = []
    for line in open_file(PATH):
        line_lengths.append(len(line))
    avg_line_len = sum(line_lengths) / len(line_lengths)
    print(f"Average line length: {avg_line_len}")