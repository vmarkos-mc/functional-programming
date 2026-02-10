# source/gen_001.py

from sys import getsizeof
import os

def load_file_list(path):
    with open(path, "r") as file:
        return file.readlines()
    
def load_file_gen(path):
    with open(path, "r") as file:
        return (line for line in file.readlines())
    
if __name__ == "__main__":
    CWD = os.path.abspath(os.path.dirname(__file__))
    PATH = os.path.join(CWD, "error.log")
    line_list = load_file_list(PATH)
    line_gen = load_file_gen(PATH)
    print(f"List buffer size:      {getsizeof(line_list)}\n"
          f"Generator buffer size: {getsizeof(line_gen)}")