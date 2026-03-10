# source/integers_001.py

import psutil
import os
import sys

def nums(n):
    return [x for x in range(n)]

if __name__ == "__main__":
    n = 20000000
    numbers = nums(n)
    print(f"Size of numbers list: {sys.getsizeof(numbers) / 1024 ** 2} MB.")
    triang = sum(numbers)
    print(f"The {n}th triangular number is {triang}.")
    process = psutil.Process(os.getpid())
    print(f"Memory consumption: {process.memory_info().rss / 1024 ** 2} MB")