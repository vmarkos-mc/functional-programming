from dataclasses import dataclass
from enum import Enum


@dataclass
class TokenType(Enum):
    OPENING_TAG = 0
    CLOSING_TAG = 1
    ALPHNUM = 2
    XML_TAG = 3
    VERSION_PARAM = 4
    STRING_LITERAL = 5
    EQ = 6


@dataclass(frozen=True)
class Token:
    type: TokenType
    identifier: str