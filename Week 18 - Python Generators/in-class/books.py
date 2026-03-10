import re
import functools as ft
from dataclasses import dataclass

# A frozen dataclass is like an immutable object
@dataclass(frozen=True)
class CSV:
    header: list[str]
    rows: list[list[str]]

@dataclass(frozen=True)
class Distribution:
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

def main():
    PATH = "books.csv"
    data = load_data(PATH)
    mr = mean_rating(data)
    print(f"Mean rating: {mr}")
    ad = author_distribution(data)
    print(f"Author Distribution: {ad}")

if __name__ == "__main__":
    main()