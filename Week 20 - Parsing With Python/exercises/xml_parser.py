# in-class/xml_parser.py

from dataclasses import dataclass
from tokens import Token, TokenType
from copy import deepcopy


@dataclass(frozen=True)
class ScannerState:
    current_token_str: str = ''
    current_char: str = ''
    is_tag: bool = False
    is_closing_tag: bool = False
    is_xml_tag: bool = False
    tokens: tuple[Token] = ()


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
    state = ScannerState()
    # TODO: Use functools.reduce() to implement this using no loops
    # Essentially, we fold all characters into a final Scanner state
    for char in read_file(filepath):
        state.current_char = char
        state = scan_char(state)
    return state.tokens


def scan_char(char: str, state: ScannerState) -> ScannerState:
    if char == '>':
        return scan_gt(state)
    if char == '<':
        return scan_lt(state)
    if char == '/':
        return scan_forward_slash(state)
    if char.isalnum():
        return scan_alnum(state)
    if char == '=':
        return scan_eq(state)
    if char == '?':
        return scan_qmark(state)
    return state


def scan_gt(state: ScannerState) -> ScannerState:
    if not state.is_tag:
        # In case we are not in a tag, just read this as any other character
        return ScannerState(
            state.current_token_str + state.current_char,
            state.current_char,
            state.is_tag,
            state.is_closing_tag,
            state.tokens,
        )
    token_type = TokenType.XML_TAG if state.is_xml_tag else \
                TokenType.CLOSING_TAG if state.is_closing_tag else \
                TokenType.OPENING_TAG
    token = Token(
        token_type,
        state.current_token_str
    )
    return ScannerState(tokens=state.tokens + (token, ))


def scan_lt(state: ScannerState) -> ScannerState:
    """Assuming that '<' always opens a new tag"""
    if state.current_token_str != '':
        token = Token(TokenType.ALPHNUM, state.current_token_str)
        tokens = state.tokens + (token, )
    return ScannerState(is_tag=True)


def scan_forward_slash(state: ScannerState) -> ScannerState:
    is_closing_tag = False
    if state.is_tag:
        is_closing_tag == True
    return ScannerState(
        state.current_token_str + state.current_char,
        state.current_char,
        state.is_tag,
        is_closing_tag,
        state.tokens
    )


def scan_alnum(state: ScannerState) -> ScannerState:
    if state.current_token_str.lower() == "version":
        token = Token(TokenType.VERSION_PARAM, "version")
        return ScannerState(tokens=(state.tokens) + (token,))
    return ScannerState(
        state.current_token_str + state.current_char,
        state.current_char,
        state.is_tag,
        state.is_closing_tag,
        state.tokens
    )


def scan_eq(state: ScannerState) -> ScannerState:
    token = Token(TokenType.EQ, '=')
    return ScannerState(tokens=state.tokens + (token, ))


def scan_qmark(state: ScannerState) -> ScannerState:
    is_xml_tag = False
    if state.is_tag and not state.is_xml_tag:
        is_xml_tag = True
    if state.is_xml_tag:
        token = Token(TokenType.STRING_LITERAL, state.current_token_str)
        tokens = state.tokens + (token, )
        return ScannerState(is_xml_tag=is_xml_tag, tokens=tokens)
    return ScannerState(is_xml_tag=is_xml_tag)


def parse_tokens(tokens: tuple) -> XML:
    """Given a tuple of tokens, returns an XML object"""


def main():
    scan_file("cat.xml")


if __name__ == "__main__":
    main()