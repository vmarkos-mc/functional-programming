# in-class/grouping_001.py

from sys import getsizeof

def group_by(items, m, truncate=True) -> list[tuple]:
    """Groups `items` in groups of size `m`."""
    groups = [] # An empty list to keep our groups
    current_group = [] # A temporary variable
    for item in items:
        if len(current_group) < m:
            current_group.append(item)
        if len(current_group) == m:
            groups.append(tuple(current_group))
            current_group = []
    if not truncate and len(current_group) > 0 and len(current_group) < m:
        groups.append(tuple(current_group))
    return groups


def g_groub_by(items, m, truncate=True):
    """As `group_by()`, returning a generator"""
    current_group = () # Empty Tuple
    for item in items:
        if len(current_group) < m:
            # We need the comma, since `(item)` is just redundant parenthesisation
            current_group += (item,)
        if len(current_group) == m:
            yield current_group
            current_group = ()
    if not truncate and 0 < len(current_group) < m:
        yield current_group

def naturals(start=1):
    i = start
    while True:
        yield i
        i += 1


def test():
    ns = list(range(12))
    # ns = "the quick brown"
    triples = group_by(ns, 3)
    quadruples = group_by(ns, 4)
    quintiples = group_by(ns, 5)
    print(
        f"numbers:     {ns}\n"
        f"triples:     {triples}\n"
        f"quadruples:  {quadruples}\n"
        f"quintiples:  {quintiples}\n"
    )
    ns = (1, 2, 3, 4)
    g_triples = g_groub_by(ns, 3, False)
    print(f"G triples:   {g_triples}")
    print(f"1st triple:  {next(g_triples)}")
    print(f"2nd triple:  {next(g_triples)}")
    # naturals_as_triples = g_groub_by(naturals(), 3)
    # while True:
    #     print(next(naturals_as_triples))


def mem_test(N=10000):
    ns = range(N)
    triples = group_by(ns, 3)
    g_triples = g_groub_by(ns, 3)
    print(
        f"No generators:    {getsizeof(triples)} bytes\n"
        f"Generators:       {getsizeof(g_triples)} bytes"
    )


def main():
    mem_test(N=int(1e8))

if __name__ == "__main__":
    main()