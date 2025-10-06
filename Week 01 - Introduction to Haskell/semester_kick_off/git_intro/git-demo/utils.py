# utils.py

from dataclasses import dataclass
from math import sqrt


@dataclass(frozen=True)
class Point:
    """Dummy point (data)class"""

    x: float
    y: float


class Segment:
    """Class representing a simple line segment on the 2D plane"""

    def __init__(self, a: Point, b: Point, tol: float = 0.0) -> None:
        """'a', 'b' correspond to the two segment edges, '_tol' to float arithmetic tolerance"""

        self.a = a
        self.b = b
        self._tol = tol

    def __contains__(self, p: Point) -> bool:
        if not isinstance(p, Point):
            raise TypeError(
                f"Expected instance of class 'Point', not of type <{type(p)}>."
            )
        det = abs(
            (p.x - self.a.x) * (self.b.y - self.a.y)
            - (p.y - self.a.y) * (self.b.x - self.a.x)
        )
        return det <= self._tol

    def __str__(self) -> str:
        return f"[{self.a}, {self.b}]"

    def length_squared(self) -> float:
        return (self.b.x - self.a.x) ** 2 + (self.b.y - self.a.y) ** 2

    def length(self) -> float:
        return sqrt(self.length_squared())
