"""Basic calculator operations."""


def add(a: float, b: float) -> float:
    """Return the sum of two numbers."""
    return a + b


def subtract(a: float, b: float) -> float:
    """Return the difference between two numbers."""
    return a - b


def multiply(a: float, b: float) -> float:
    """Return the multiplication of two numbers."""
    return a * b

def divide(a, b):
    if b == 0:
        return 0
