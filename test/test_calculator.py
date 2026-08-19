"""Tests for calculator module."""

import pytest

from src.calculator import add, divide, multiply, subtract


def test_add_two_numbers():
    assert add(2, 3) == 5


def test_subtract_two_numbers():
    assert subtract(5, 3) == 2


def test_multiply_two_numbers():
    assert multiply(4, 3) == 12


def test_divide_two_numbers():
    assert divide(10, 2) == 5


def test_division_by_zero():
    with pytest.raises(ValueError, match="Division by zero"):
        divide(10, 0)
