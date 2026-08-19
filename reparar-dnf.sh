#!/usr/bin/env bash

set -u

BACKUP_DIR="/root/dnf-backup-$(date +%Y%m%d-%H%M%S)"
DB="/var/lib/dnf/history.sqlite"

echo "========================================="
echo " Reparación del historial de DNF"
echo "========================================="
echo

# -----------------------------------------
# 1. Comprobar root
# -----------------------------------------

if [[ $EUID -ne 0 ]]; then
    echo "ERROR: ejecuta este script con sudo:"
    echo
    echo "  sudo $0"
    exit 1
fi

# -----------------------------------------
# 2. Comprobar SQLite
# -----------------------------------------

if ! command -v sqlite3 >/dev/null 2>&1; then
    echo "ERROR: sqlite3 no está instalado."
    exit 1
fi

echo "[OK] sqlite3 encontrado:"
sqlite3 --version
echo

# -----------------------------------------
# 3. Comprobar procesos DNF/RPM
# -----------------------------------------

if pgrep -x dnf >/dev/null 2>&1; then
    echo "ERROR: hay un proceso DNF ejecutándose."
    echo
    pgrep -a dnf
    exit 1
fi

if pgrep -x rpm >/dev/null 2>&1; then
    echo "ERROR: hay un proceso RPM ejecutándose."
    echo
    pgrep -a rpm
    exit 1
fi

echo "[OK] No hay procesos DNF/RPM activos."
echo

# -----------------------------------------
# 4. Comprobar base de datos
# -----------------------------------------

if [[ ! -f "$DB" ]]; then
    echo "ERROR: no existe:"
    echo "$DB"
    exit 1
fi

echo "[INFO] Estado actual de la base de datos:"
ls -lh "${DB}"*
echo

echo "[INFO] Comprobando integridad..."

INTEGRITY=$(sqlite3 "$DB" "PRAGMA integrity_check;" 2>&1)

echo "$INTEGRITY"
echo

if [[ "$INTEGRITY" != "ok" ]]; then
    echo "ERROR: la base de datos no supera integrity_check."
    echo "NO se realizará ninguna modificación."
    exit 1
fi

echo "[OK] La base de datos es íntegra."
echo

# -----------------------------------------
# 5. Crear backup
# -----------------------------------------

echo "[INFO] Creando copia de seguridad:"
echo "$BACKUP_DIR"
echo

mkdir -p "$BACKUP_DIR"

cp -a "${DB}"* "$BACKUP_DIR/" 2>/dev/null || true

echo "[OK] Backup realizado."
echo

# -----------------------------------------
# 6. Mostrar estado del WAL
# -----------------------------------------

echo "[INFO] Estado del WAL antes del checkpoint:"
ls -lh "${DB}"* 2>/dev/null
echo

# -----------------------------------------
# 7. Checkpoint SQLite
# -----------------------------------------

echo "[INFO] Ejecutando checkpoint SQLite..."
echo

sqlite3 "$DB" "PRAGMA wal_checkpoint(TRUNCATE);"

CHECKPOINT_RESULT=$?

echo

if [[ $CHECKPOINT_RESULT -ne 0 ]]; then
    echo "ERROR: el checkpoint SQLite ha fallado."
    echo "La copia original está disponible en:"
    echo "$BACKUP_DIR"
    exit 1
fi

echo "[OK] Checkpoint realizado."
echo

# -----------------------------------------
# 8. Comprobar integridad después
# -----------------------------------------

echo "[INFO] Comprobando integridad después del checkpoint..."

INTEGRITY=$(sqlite3 "$DB" "PRAGMA integrity_check;" 2>&1)

echo "$INTEGRITY"
echo

if [[ "$INTEGRITY" != "ok" ]]; then
    echo "ERROR: la base de datos no supera la comprobación posterior."
    echo
    echo "Backup disponible en:"
    echo "$BACKUP_DIR"
    exit 1
fi

echo "[OK] Integridad confirmada."
echo

# -----------------------------------------
# 9. Estado final del WAL
# -----------------------------------------

echo "[INFO] Estado de los archivos después del checkpoint:"
ls -lh "${DB}"* 2>/dev/null
echo

# -----------------------------------------
# 10. Limpiar caché temporal de DNF
# -----------------------------------------

echo "[INFO] Limpiando caché temporal de DNF..."

dnf clean metadata >/dev/null 2>&1 || true

echo "[OK] Caché limpiada."
echo

# -----------------------------------------
# 11. Prueba de DNF
# -----------------------------------------

echo "========================================="
echo " Prueba de DNF"
echo "========================================="
echo

echo "[INFO] Ejecutando:"
echo "dnf install tree"
echo

if dnf --disablerepo='*' \
       --enablerepo=baseos \
       install tree; then

    echo
    echo "========================================="
    echo " DNF FUNCIONA CORRECTAMENTE"
    echo "========================================="
    echo
    echo "Backup:"
    echo "$BACKUP_DIR"
    echo

else

    echo
    echo "========================================="
    echo " DNF SIGUE FALLANDO"
    echo "========================================="
    echo
    echo "La base de datos de historial está íntegra,"
    echo "pero el problema no se ha solucionado con"
    echo "el checkpoint del WAL."
    echo
    echo "Backup disponible en:"
    echo "$BACKUP_DIR"
    echo

    exit 2

fi

exit 0
