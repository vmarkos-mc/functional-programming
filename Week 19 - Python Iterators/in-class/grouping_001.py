# in-class/grouping_001.py

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


def naturals(start=1):
    i = start
    while True:
        yield i
        i += 1


def main():
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
    g_triples = g_groub_by(ns, 3)
    print(f"G triples:   {g_triples}")
    print(f"1st triple:  {next(g_triples)}")
    print(f"2nd triple:  {next(g_triples)}")
    naturals_as_triples = g_groub_by(naturals(), 3)
    while True:
        print(next(naturals_as_triples))


if __name__ == "__main__":
    main()