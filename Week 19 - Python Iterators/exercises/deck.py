# in-class/deck.py

from dataclasses import dataclass
from enum import Enum
import itertools as it

class Suite(Enum):
    # More on enums: https://docs.python.org/3/library/enum.html
    Diamonds = 0
    Clubs = 1
    Hearts = 2
    Spades = 3


@dataclass(frozen=True)
class Card:
    suite: Suite
    number: int


def deck():
    suites = (Suite.Diamonds, Suite.Clubs, Suite.Hearts, Suite.Spades)
    numbers = range(1, 14)
    # Cartesian product
    return map(lambda t: Card(*t), it.product(suites, numbers))


# Fill in the rest...


def main():
    for card in deck():
        print(card)


if __name__ == "__main__":
    main()