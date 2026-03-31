# in-class/xml_parser.py

from dataclasses import dataclass
from tokens import Token, TokenType
from copy import deepcopy


@dataclass(frozen=True)
class ScannerState:
    current_token_str: str
    current_char: str
    is_tag: bool
    is_closing_tag: bool
    tokens: tuple[Token]


    def __deepcopy__(self) -> "ScannerState":
        return ScannerState(
            current_token_str=self.current_token_str,
            current_char=self.current_char,
            is_tag=self.is_tag,
            is_closing_tag=self.is_closing_tag,
            tokens=tuple(t for t in self.tokens)
        )



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


def scan_file(filepath) -> tuple[Token]:
    """Computes a tuple of all valid XML tokens"""
    state = ScannerState('', '', False, False, ())
    for char in read_file(filepath):
        match char:
            case '>': # tag end
                scan_gt(state)
            case '<':
                scan_lt(state)
            case '/':
                scan_forward_slash(state)
    return state.tokens
                

def scan_gt(state: ScannerState):
    state.current_char = '>'
    if not state.is_tag:
        # In case we are not in a tag, just read this as any other character
        state.current_token_str += state.current_char,
        return 
    token = Token(
        TokenType.CLOSING_TAG if state.is_closing_tag else TokenType.OPENING_TAG,
        state.current_token_str
    )
    state = ScannerState(
        '',
        state.current_char,
        is_tag=False,
        is_closing_tag=False,
        tokens=state.tokens + (token, )
    )


def scan_lt(state: ScannerState):
    """Assuming that '<' always opens a new tag"""
    state.current_char = '<'
    state.is_tag = True


def scan_forward_slash(state: ScannerState):
    state.current_char = '/'
    if state.is_tag:
        state.is_closing_tag == True
        return
    state.current_token_str += state.current_char

def parse_tokens(tokens: tuple) -> XML:
    """Given a tuple of tokens, returns an XML object"""


def main():
    scan_file("cat.xml")


if __name__ == "__main__":
    main()