#!/usr/bin/env bash

set -e

PROJECT_DIR="$HOME/laboratorio-cicd-ia"

echo "=============================================="
echo " Creación del laboratorio CI/CD con Python"
echo "=============================================="
echo
echo "Directorio: $PROJECT_DIR"
echo

# ------------------------------------------------
# 1. Crear directorios
# ------------------------------------------------

mkdir -p "$PROJECT_DIR/src"
mkdir -p "$PROJECT_DIR/test"

cd "$PROJECT_DIR"

# ------------------------------------------------
# 2. Eliminar restos del proyecto Node.js
# ------------------------------------------------

rm -f package.json
rm -f package-lock.json
rm -rf node_modules

# ------------------------------------------------
# 3. Crear archivos Python
# ------------------------------------------------

cat > src/__init__.py <<'EOF'
EOF

cat > src/calculator.py <<'EOF'
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


def divide(a: float, b: float) -> float:
    """Return the division of two numbers.

    Raises:
        ValueError: If b is zero.
    """
    if b == 0:
        raise ValueError("Division by zero")

    return a / b
EOF

cat > test/__init__.py <<'EOF'
EOF

# ------------------------------------------------
# 4. Crear tests
# ------------------------------------------------

cat > test/test_calculator.py <<'EOF'
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
EOF

# ------------------------------------------------
# 5. Requirements
# ------------------------------------------------

cat > requirements.txt <<'EOF'
pytest
ruff
EOF

# ------------------------------------------------
# 6. Gitignore
# ------------------------------------------------

cat > .gitignore <<'EOF'
# Python
__pycache__/
*.py[cod]

# Virtual environments
.venv/
venv/
env/

# Testing
.pytest_cache/
.coverage
htmlcov/

# Ruff
.ruff_cache/

# Environment variables
.env
.env.*

# Logs
*.log

# IDE
.vscode/
.idea/
EOF

# ------------------------------------------------
# 7. README
# ------------------------------------------------

cat > README.md <<'EOF'
# Laboratorio CI/CD con IA

Laboratorio práctico de integración continua y entrega continua
utilizando Python, GitHub, Jenkins y herramientas de automatización.

## Tecnologías

- Python
- pytest
- Ruff
- Git
- GitHub
- Jenkins
- Podman
- Trivy
- Asistentes de IA

## Estructura

```text
laboratorio-cicd-ia/
├── .gitignore
├── README.md
├── requirements.txt
├── src/
│   ├── __init__.py
│   └── calculator.py
└── test/
    ├── __init__.py
    └── test_calculator.py
