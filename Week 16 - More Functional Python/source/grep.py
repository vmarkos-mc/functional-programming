# source/grep.py

import time

def grep(pattern,lines):
    for line in lines:
        if pattern in line:
            yield line

def load_file(file):
    file.seek(0,0) # Go to the file start
    while True:
        line = file.readline()
        if not line:
            time.sleep(0.1) # Sleep briefly
            continue
        yield line

if __name__ == "__main__":
    with open("error.log", "r") as logfile:
        loglines = load_file(logfile)
        info_lines = grep("I", loglines)
        for line in info_lines:
            print(line)