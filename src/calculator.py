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

# src/calculator.py
def divide(a: float, b: float) -> float:
    """Calcula la división de dos números."""
    if b == 0:
        # ERROR DOCENTE: Este mensaje no coincide con el test unitario
        raise ValueError("Error al dividir") 
    return a / b
