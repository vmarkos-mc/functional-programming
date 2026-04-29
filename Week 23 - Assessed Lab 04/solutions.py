# solutions.py

# Module: 5CM524: Functional Programming
# Indicative solutions for Assessed Lab 04
# Author: Vassilis Markos
#
# Purpose: All solutions enclosed in this file are indicative and by no way offer a unique
# way to approach the tasks assessed. Comments for each solution address most of the task 
# highlights and any questions that arose during lab oral examination. Where possible, type
# annotations are used to help you follow code logic.

import functools as ft

# Task 1

is_odd = lambda n: n % 2 == 1

## Comments
#
# Most of you solved this task correctly, however some failed to properly explain what 
# Python's `lambda` keyword is for. We use `lambda` to indicate an anonymous (or "lambda")
# function, i.e., a function we define using no name. Since functions are treated as first-class
# objects by Python, we can assign those to variables, pass them as arguments and so on.


# Task 2

def celsius_to_farenheit(temperatures: [float]) -> [float]:
    return list(
        filter(
            lambda: t: t < 32,
            map(
                lambda c: c * 9 / 5 + 32,
                temperatures
            )
        )
    )


## Comments
#
# Returning a list is not explicitly required by the task description, but, since most of you preferred
# it, I have included it here as well - you might as well drop it; the function will then return an iterator.
# The idea here is simple:
#   1. We first map all celsius temperatures to farenheit, by using map and a lambda function corresponding to our transform.
#   2. Then, we filter outputs, keeping only those below 32.
# Of course, we could have well kept the outpt of `map()` into a variable and then feed it into `filter()`. This is 
# just a matter of preference.
#
# Note that the same can be achieved with the following function, using no use of `map()` or `filter()` (just Python comprehensions),
# which, however, would not be an acceptable solution, given that you have to use both `map`() and `filter()`:

def celsius_to_farenheit_comp(temperatures: [float]) -> [float]:
    return [
        c * 9 / 5 + 32 for c in temperatures if c * 9 / 5 < 0
    ]


# Task 3

def filter_anomalies(readings: dict[str, [int]]) -> dict[str, [int]]:
    return dict(
        filter(
            lambda r: 10 <= r[1] <= 35,
            readings.items()
        )
    )


## Comments
# Just a simple use of filter. We iterate over all dictionary items, using `.items()` and then
# we filter out what we do not need. Finally, we cast back to a dictionary, since `filter()` will
# return just an iterable of tuples of the form `'animal', [int]`.


# Task 4

# Utility function for both next tasks
def average(ns: [int]) -> float:
    return ft.reduce(
        lambda x, y: x + y,
        ns
    )


def average_temperature(reading: dict[str, [int]]) -> dict[str, [int]]:
    return dict(
        map(
            lambda r: (r[0], average(r[1])),
            readings.items()
        )
    )


## Comments
# `reduce()` reduces an iterable to single value, based on a binary function. It implements folding,
# muck like `foldl` and `foldr` in Haskell, which we have studied thoroughly last semester.
# In this case, we need to compute an average, so we just add all values up, one by one.


# Task 5

def calculate_hourly_averages(data: [tuple[str, [int]]]]) -> [tuple[str, [int]]]:
    return list(
        map(
            lambda r: (r[0], average(r[1])),
            data
        )
    )


## Comments
# Just lik Task 4, just casting to a list instead of a dict.


# Task 6

# Utility functions
def compute_deltas(ts: [int]) -> [int]:
    return map(
        lambda x, y: abs(x - y),
        ts[:-1], ts[1:]
    )


def identify_temperature_spikes(data: [tuple[str, [int]]]) -> [tuple[str, [int]]]:
    deltas = map(
        lambda t: (t[0], compute_deltas(t[1])),
        data
    )
    return list(
        filter(
            lambda d: (d[0], ft.reduce(lambda x, y: x and y > 5, d[1], False))
        ),
        deltas
    )


## Comments
#
# First, we use map to convert all input temperatures to temperature differences, i.e., deltas.
# Then, we use reduce to implement a recursive or - we could have just used `any()` instead, I 
# am using it here just for the sake of it.


# Task 7

def find_hottest_enclosure(data: [tuple[str, [int]]]) -> tuple[str, float]:
    return ft.reduce(
        lambda x, y: x if x[1] > y[1] else y,
        calculate_hourly_averages(data)
    )


## Comments
#
# In this task, we have actually to just reduce the output of task 5 to its maximum element, based
# on a projection on its second components.
