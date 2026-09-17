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

## Módulo de calculadora

El paquete `src` expone operaciones aritméticas:

| Función | Descripción |
| --- | --- |
| `add(a, b)` | Suma |
| `subtract(a, b)` | Resta |
| `multiply(a, b)` | Multiplicación |
| `divide(a, b)` | División (`ValueError` si `b` es 0) |
| `power(a, b)` | Potencia |
| `modulo(a, b)` | Resto (`ValueError` si `b` es 0) |

## Estructura

```text
laboratorio-cicd-ia/
├── .gitignore
├── Jenkinsfile
├── README.md
├── pyproject.toml
├── requirements.txt
├── src/
│   ├── __init__.py
│   └── calculator.py
└── test/
    ├── __init__.py
    └── test_calculator.py
```

## Cómo ejecutar

```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
.venv/bin/ruff check .
.venv/bin/pytest
```
