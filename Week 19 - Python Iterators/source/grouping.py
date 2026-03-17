# source/grouping.py

from psutil import Process # Maybe `pip install psutil` as this is not part of stdlib
import os # To access our own pid (Process ID)
import time # To time things
import itertools # The coolest Python library ever!

def group_by(numbers, m):
    """ Gets a list / generator of numbers and returns a list of tuples of groups of those numbers of size m. """
    n = len(numbers)
    n_groups = n // m # Assuming n % m == 0
    return [tuple(*[numbers[i * m:(i + 1) * m]]) for i in range(n_groups)]

# Reminder: `*ls`, where `ls` is a list, spreads the list into its elements.

def igroup_by(numbers, m):
    inumbers = iter(numbers) # Create an iterator over those numbers
    iters = [inumbers] * m # Create a list of `m` copies of the same iteraror (?)
    return zip(iters) # Functional sorcery takes place here...

def test(fn, N = 10 ** 7, n = 2):
    NUMS = range(N) # Adjust this to run in a reasonable amount of time.
    start = time.process_time()
    groups = fn(NUMS, n)
    # print(groups)
    end = time.process_time()
    execution_time = end - start # On Windows, for really small ranges of numbers, this is crap (always 0)*
    mem_consumption = Process(os.getpid()).memory_info().rss / 1024 ** 2 # Memory in MB
    print(f"Memory required: {mem_consumption} MB.")
    print(f"Execution time : {execution_time} seconds.")

if __name__ == "__main__":
    test(igroup_by)


# *You are all aware of my aversion of Windows and MS Products, in general, but you will most probably
# agree with me that the inability to actually access and utilise the system's clock is an actual problem...