"""Basic calculator operations."""

from __future__ import annotations

__all__ = [
    "add",
    "subtract",
    "multiply",
    "divide",
    "power",
    "modulo",
]


def add(a: float, b: float) -> float:
    """Return the sum of two numbers."""
    return a + b


def subtract(a: float, b: float) -> float:
    """Return the difference between two numbers."""
    return a - b


def multiply(a: float, b: float) -> float:
    """Return the multiplication of two numbers."""
    return a * b


def divide(a: float, b: float) -> float:
    """Return the division of two numbers.

    Raises:
        ValueError: If b is zero.
    """
    _ensure_nonzero_divisor(b)
    return a / b


def power(a: float, b: float) -> float:
    """Return *a* raised to the power of *b*."""
    return a**b


def modulo(a: float, b: float) -> float:
    """Return the remainder of *a* divided by *b*.

    Raises:
        ValueError: If b is zero.
    """
    _ensure_nonzero_divisor(b)
    return a % b


def _ensure_nonzero_divisor(divisor: float) -> None:
    """Raise ValueError when *divisor* is zero.

    The error message is part of the public contract consumed by tests.
    """
    if divisor == 0:
        raise ValueError("Division by zero")
