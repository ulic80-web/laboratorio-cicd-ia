# Instrucciones para GitHub Copilot

Este proyecto es un laboratorio educativo de CI/CD con Python y Jenkins.

## Entorno

- Python 3.9
- pytest para tests
- ruff para análisis estático
- Jenkins para integración continua

## Revisión de código

Al revisar un Pull Request:

1. Busca errores lógicos.
2. Busca posibles excepciones no controladas.
3. Comprueba casos límite.
4. Comprueba que las nuevas funcionalidades tengan tests.
5. Comprueba compatibilidad con Python 3.9.
6. Evita cambios de estilo que no sean necesarios.
7. Prioriza problemas reales sobre recomendaciones cosméticas.

## Tests

Cuando se añada o modifique funcionalidad:

- Comprueba si existen tests apropiados.
- Sugiere tests para casos límite.
- No elimines tests existentes para hacer que el pipeline pase.

## Calidad

El código debe superar:

ruff check .
pytest

## Formato de revisión

Para cada problema importante:

- Explica qué problema has encontrado.
- Explica por qué puede producir un fallo.
- Propón una solución concreta.

No consideres que una sugerencia de Copilot sustituye a la ejecución de los tests.
