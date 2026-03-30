# in-class/xml_parser.py

from dataclasses import dataclass
from enum import Enum


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


# TODO: Implement dataclasses for tokens
# TODO: Implement the scanning and parsing functions below


@dataclass
class TokenType(Enum):
    OPENING_TAG = 0
    CLOSING_TAG = 1
    ALPHNUM = 2
    XML_TAG = 3
    VERSION_PARAM = 4
    STRING_LITERAL = 5


def scan_file(file) -> tuple:
    """Computes a tuple of all valid XML tokens"""


def parse_tokens(tokens: tuple) -> XML:
    """Given a tuple of tokens, returns an XML object"""


def main():
    ...


if __name__ == "__main__":
    main()