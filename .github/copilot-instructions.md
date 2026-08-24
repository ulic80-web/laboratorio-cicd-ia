# Directrices de Revisión de Código (Code Review Rules)

Como asistente de revisión, debes verificar los siguientes puntos en cada Pull Request:

1. **Idioma de respuesta:** Realiza todas las explicaciones y comentarios estrictamente en **español**.
2. **Coincidencia Código vs. Tests:** Si se altera `src/calculator.py`, comprueba obligatoriamente que las excepciones lanzadas coincidan con el patrón esperado en `test/test_calculator.py`.
3. **Identificación del problema:** Señala la línea exacta del fallo y explica por qué fallará el pipeline de Jenkins/Pytest.
4. **Formato de corrección:** Proporciona un bloque con el código corrigiendo el error.
