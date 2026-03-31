# in-class/xml_parser.py

from dataclasses import dataclass


@dataclass(frozen=True)
class Tag:
    tag_name: str
    content: str | None # None, in case the tag is not a leaf

    def __post_init__(self) -> None:
        self.is_leaf: bool = self.content == None


@dataclass(frozen=True)
class TagTree:
    tag: Tag
    children: tuple["TagTree"] # To make everything immutable

    # Handy utility, in case we want to actually parse / evaluate our tree
    def __post_init__(self) -> None:
        self.is_leaf: bool = len(self.children) == 0
        # A sanity check is needed here.
        if self.tag.is_leaf != self.is_leaf:
            raise ValueError("Not a leaf node!")


@dataclass(frozen=True)
class XML:
    version: str # XML version used
    tag_tree: TagTree


# TODO: Implement the scanning and parsing functions below


def read_file(filepath) -> iter:
    """Generator that reads a file character by character"""
    with open(filepath, 'r') as file:
        for line in file:
            for char in line:
                yield char


def scan_file(filepath) -> tuple:
    """Computes a tuple of all valid XML tokens"""
    for char in read_file(filepath):
        ...
                


def parse_tokens(tokens: tuple) -> XML:
    """Given a tuple of tokens, returns an XML object"""


def main():
    scan_file("cat.xml")


if __name__ == "__main__":
    main()