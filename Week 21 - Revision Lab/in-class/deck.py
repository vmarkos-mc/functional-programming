# in-class/deck.py

from dataclasses import dataclass
from enum import Enum
import itertools as it
import random

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


def shuffle(deck):
    deck_list = list(deck) # We cannot shuffle a generator
    shuffled_deck = random.shuffle(deck_list)
    return iter(shuffled_deck) # make sure to return an iterator


def deal(deck, hand_size=5):
    return it.islice(deck, hand_size)


def cut(deck, deck_size=52):
    cutting_point = random.randint(0, deck_size - 1)
    top = it.islice(deck, cutting_point)
    cut_deck = it.chain(deck, top)
    return cut_deck


def main():
    for card in deck():
        print(card)


if __name__ == "__main__":
    main()