from dataclasses import dataclass
from enum import Enum

# Enum is not just a Python class, since you can do many things with it.
# Also, dataclasses are roughly like Haskell's ADTs, so, no actual member methods etc.

@dataclass
class TokenType(Enum):
    LEFT_PAREN = "LEFT_PAREN"
    RIGHT_PAREN = "RIGHT_PAREN"
    CLASS = "CLASS"
    PROPERTY_NAME = "PROPERTY_NAME"
    # Add more CSS token types here...