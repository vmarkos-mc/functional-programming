import re
import functools as ft
from dataclasses import dataclass
from matplotlib import pyplot as plt

# A frozen dataclass is like an immutable object
# An equally good alternative is a named tuple
@dataclass(frozen=True)
class CSV:
    header: list[str]
    rows: list[list[str]]

@dataclass(frozen=True)
class Distribution:
    # Absolute frequencies of keys as values
    d: dict[str, int]

def update_distribution(d_old: Distribution, k: str) -> Distribution:
    d = d_old.d
    d[k] = d[k] + 1 if k in d.keys() else 1
    return Distribution(d=d)

def join_distributions(d1: Distribution, d2: Distribution) -> Distribution:
    keys1 = set(d1.d.keys())
    keys2 = set(d2.d.keys())
    d = {
        k: d1.d[k] + d2.d[k]
            if k in keys1.intersection(keys2)
            else d1.d[k]
                if k in keys1
                else d2.d[k]
        for k in keys1.union(keys2)
    }
    return Distribution(d=d)

def read_csv(path: str, delimiter=r'(?<!\s),(?!\s)') -> CSV:
    """Loads csv data from text"""
    size = 0
    with open(path, 'r', encoding='utf8') as file:
        header = re.split(delimiter, next(file))
        rows = [re.split(delimiter, row) for row in file]
    return CSV(header=header, rows=rows)


def load_data(path: str) -> CSV:
    """Loads Book data from CSV"""
    return read_csv(path)

def mean_rating(data: CSV) -> float:
    header = data.header # The first row contains the dataset header
    ar_index = header.index('average_rating')
    ratings_sum = ft.reduce(
        lambda x, y: x + y,
        map(lambda row: float(row[ar_index]), data.rows)
    )
    return ratings_sum / len(data.rows)


def author_distribution(data: CSV) -> Distribution:
    header = data.header
    auth_index = header.index('authors')
    return ft.reduce(
        join_distributions,
        map(lambda row: Distribution({row[auth_index]: 1}), data.rows)
    )

def productive_authors(data: CSV, threshold: int) -> Distribution:
    """Computes the most productive authors as indicated by publications."""
    ad = author_distribution(data)
    return Distribution({
        author: publications
            for author, publications in ad.d.items()
                if publications >= threshold
    })

def page_distribution(data: CSV, width: int) -> Distribution:
    """Computes the distribution of pages across the dataset"""
    header = data.header
    pages_index = header.index('num_pages')
    return ft.reduce(
        join_distributions,
        map(
            lambda row: Distribution({
                ((int(row[pages_index]) // width) * width,
                 (int(row[pages_index]) // width + 1) * width): 1
            }),
            data.rows
        )
    )

# For example, for a book with 684 pages and bin width 50.
#   1. Divide 684 by 50, so we get: 13 and 34 as a remainder
#   2. So, we compute: 13 * 50 = 650 and 14 * 50 = 700.
#   3. So, our target bin is 650, 700

def plot_histogram(distribution: Distribution) -> None:
    fig, ax = plt.subplots()
    labels, frequencies = zip(*(
        ("-".join(map(str, k)), v)
        for k, v in sorted(distribution.d.items(), key=lambda item: item[0][0])
    ))
    plt.barh(labels, frequencies)
    plt.show()

def main():
    PATH = "books.csv"
    data = load_data(PATH)
    mr = mean_rating(data)
    print(f"Mean rating: {mr}")
    # ad = author_distribution(data)
    # print(f"Author Distribution: {ad}")
    # prod_auth = productive_authors(data, 6)
    # print(f"Productive authors: {prod_auth}")
    page_dist = page_distribution(data, 100)
    print(f"Page_distribution: {page_dist}")
    plot_histogram(page_dist)

if __name__ == "__main__":
    main()