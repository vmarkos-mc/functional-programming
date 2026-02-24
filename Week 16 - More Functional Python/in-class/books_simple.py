import json
import functools as ft

# We will be using type hinting to get used to it
def load_data(path: str) -> dict:
    with open(path, 'r') as file:
        return json.load(file)
    
def published_before_1960(books: list) -> list:
    return list(filter(lambda b: b['year'] < 1960, books))

def published_before(books: list, year: int) -> list:
    return list(filter(lambda b: b['year'] < year, books))

def in_genre(books: list, genre: str) -> list:
    # return list(filter(lambda b: b['genre'] == genre, books))
    return [book for book in books if book['genre'] == genre]

def rated_at_least(books: list, rating: float) -> list:
    return [book for book in books if book['rating'] >= rating]

def exercise_1_1(books: list):
    # Task 1.1.1
    bf_1960_01 = published_before_1960(books)
    bf_1960_02 = published_before(books, 1960)
    print(bf_1960_01 == bf_1960_02)
    # Task 1.1.2
    sci_fi = in_genre(books, "Science Fiction")
    print(sci_fi)
    # Task 1.1.3
    at_least_4_5 = rated_at_least(books, 4.5)
    print(at_least_4_5)

def get_book_titles(books: list) -> list[str]:
    # return list(map(lambda book: book['title'], books))
    return [book['title'] for book in books]

def get_book_authors(books: list) -> list[str]:
    return list(map(lambda book: book['author'], books))

def get_book_titleauthor(books: list) -> list[dict[str, str]]:
    # return list(map(lambda book: {'title': book['title'], 'author': book['author']}, books))
    # return [{'title': book['title'], 'author': book['author']} for book in books]
    KEYS = { 'title', 'author' }
    return [ { k: book[k] for k in KEYS } for book in books]

def exercise_1_2(books):
    # Task 1.2.1
    titles = get_book_titles(books)
    print(",\n".join(titles))
    # Task 1.2.2
    authors = get_book_authors(books)
    print(",\n".join(authors))
    # Task 1.2.3
    titleauthors = get_book_titleauthor(books)
    print(titleauthors)

def fantasy_1950(books: list) -> list[str]:
    return list(
        map(
            lambda book: book['title'],
            filter(
                lambda book: book['genre'] == 'Fantasy' and book['year'] > 1950,
                books
            )
        )
    )

def popular_authors(books: list) -> list[str]:
    return list(
        map(
            lambda book: book['author'],
            filter(
                lambda book: book['rating'] > 4.6,
                books
            )
        )
    )

def exercise_1_3(books):
    # Task 1.3.1
    fan_1950 = fantasy_1950(books)
    print(',\n'.join(fan_1950))
    pop_auth = popular_authors(books)
    print(',\n'.join(pop_auth))

def avg_rating(books: list) -> float:
    return ft.reduce(
        lambda x, y: x + y,
        map(
            lambda book: book['rating'],
            books
        )
    ) / len(books)

def oldest_book(books: list) -> str:
    return ft.reduce(
        lambda x, y: x if x['year'] < y['year'] else y,
        books
    )['title']

def exercise_1_4(books):
    # Task 1.4.1
    avg_r = avg_rating(books)
    print(f"Average rating: {avg_r}")
    # Task 1.4.2
    oldest_b = oldest_book(books)
    print(f"Oldest book: {oldest_b}")

if __name__ == "__main__":
    DATA_PATH = "../source/books.json"
    books = load_data(DATA_PATH)["books"]
    exercise_1_4(books)