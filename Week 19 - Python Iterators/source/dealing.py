import itertools as it
import random

ranks = ['A', 'K', 'Q', 'J', '10', '9', '8', '7', '6', '5', '4', '3', '2']
suits = ['H', 'D', 'C', 'S']

cards = it.product(ranks, suits)

def shuffle(deck):
    deck = list(deck)
    random.shuffle(deck) # Well, to shuffle randomly you need to know what you have to shuffle...
    return iter(tuple(deck))

def cut(deck, n):
    first, second = it.tee(deck, 2)
    top = it.islice(first, n)
    bottom = it.islice(second, n, None)
    return it.chain(bottom, top)

def deal(deck, num_hands=1, hand_size=5):
    iters = [iter(deck)] * hand_size
    return tuple(zip(*(tuple(it.islice(itr, num_hands)) for itr in iters)))

hands = deal(cut(shuffle(cards), 30), num_hands=5)
print("\n".join((str(h) for h in hands)))

# Just for debugging, if needed
stringify_iter = lambda iter: ", ".join((str(i) for i in iter))