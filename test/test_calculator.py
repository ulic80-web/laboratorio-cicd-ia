"""Tests for calculator module."""

import pytest

from src.calculator import add, divide, modulo, multiply, power, subtract


@pytest.mark.parametrize(
    ("a", "b", "expected"),
    [
        (2, 3, 5),
        (0, 0, 0),
        (-2, 5, 3),
        (2.5, 0.5, 3.0),
    ],
)
def test_add(a: float, b: float, expected: float) -> None:
    assert add(a, b) == expected


@pytest.mark.parametrize(
    ("a", "b", "expected"),
    [
        (5, 3, 2),
        (0, 4, -4),
        (-2, -3, 1),
        (2.5, 0.5, 2.0),
    ],
)
def test_subtract(a: float, b: float, expected: float) -> None:
    assert subtract(a, b) == expected


@pytest.mark.parametrize(
    ("a", "b", "expected"),
    [
        (4, 3, 12),
        (0, 9, 0),
        (-2, 3, -6),
        (2.5, 2, 5.0),
    ],
)
def test_multiply(a: float, b: float, expected: float) -> None:
    assert multiply(a, b) == expected


@pytest.mark.parametrize(
    ("a", "b", "expected"),
    [
        (10, 2, 5),
        (-9, 3, -3),
        (2.5, 0.5, 5.0),
    ],
)
def test_divide(a: float, b: float, expected: float) -> None:
    assert divide(a, b) == expected


def test_division_by_zero() -> None:
    # Copilot leerá este 'match' y lo comparará contra src/calculator.py
    with pytest.raises(ValueError, match="Division by zero"):
        divide(10, 0)


@pytest.mark.parametrize(
    ("a", "b", "expected"),
    [
        (2, 3, 8),
        (5, 0, 1),
        (9, 0.5, 3.0),
        (2, -1, 0.5),
    ],
)
def test_power(a: float, b: float, expected: float) -> None:
    assert power(a, b) == expected


@pytest.mark.parametrize(
    ("a", "b", "expected"),
    [
        (10, 3, 1),
        (9, 3, 0),
        (-7, 3, 2),
        (5.5, 2.0, 1.5),
    ],
)
def test_modulo(a: float, b: float, expected: float) -> None:
    assert modulo(a, b) == expected


def test_modulo_by_zero() -> None:
    with pytest.raises(ValueError, match="Division by zero"):
        modulo(10, 0)
