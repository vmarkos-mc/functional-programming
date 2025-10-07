# in-class/immutability_02.py

from timeit import timeit

def mutable(x):
    """ Assuming that x > 0 """

    while x > 0:
        x -= 1
        # print(x)

def immutable(x):
    """ Assuming that x > 0 """

    if x == 0:
        return
    # print(x - 1)
    immutable(x - 1)

if __name__ == "__main__":
    m = timeit(lambda: mutable(900), number=10000)
    im = timeit(lambda: immutable(900), number=10000)
    print(m, im)