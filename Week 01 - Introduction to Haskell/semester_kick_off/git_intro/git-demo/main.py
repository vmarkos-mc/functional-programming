# main.py

from argparse import ArgumentParser

from utils import Point, Segment


def prepare_parser() -> ArgumentParser:
    parser = ArgumentParser()
    parser.add_argument(
        "a", nargs=2, type=float, help="First edge of the line segment."
    )
    parser.add_argument(
        "b",
        nargs=2,
        type=float,
        help="Second edge of the line segment",
    )
    parser.add_argument(
        "p",
        nargs=2,
        type=float,
        help="Point to check whether it belongs to the line segment.",
    )
    parser.add_argument(
        "-tol",
        "--tolerance",
        default=0.0,
        type=float,
        help="Float arithmetic tolerance. Default value: 0.0",
    )
    return parser


def main() -> None:
    parser = prepare_parser()
    args = vars(parser.parse_args())
    _a, _b, _p, _tol = args.values()
    print(_a, _b)
    a = Point(*_a)
    b = Point(*_b)
    p = Point(*_p)
    segment = Segment(a, b, tol=_tol)
    print(f"Is point {p} in {segment}? {p in segment}.")
    print(f"Segment length: {segment.length()}")


if __name__ == "__main__":
    main()
