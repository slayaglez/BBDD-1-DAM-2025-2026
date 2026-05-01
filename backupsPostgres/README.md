# Administración de PostgreSQL con Docker

Este proyecto levanta una instancia de PostgreSQL y proporciona herramientas para su gestión.

## 🚀 Despliegue
Para iniciar la base de datos, ejecuta:
```bash
docker-compose up -d
```

Para detenerla:
```bash
docker-compose down
```

---

## 💾 Backups y Restauración

### Crear un Backup (pg_dump)
Usamos `pg_dump` para generar un archivo `.sql` con la estructura y los datos:
```bash
docker exec -t containerCbas pg_dump -U cbas baseCbas > backups/backup_total.sql
```

### Restaurar un Backup
```bash
cat backups/backup_total.sql | docker exec -i cbas psql -U cbas -d baseCbas
```

---

## 🥵 Iniciar base de datos

### Import del .sql
No hay mucho que explicar aquí, sólo asegúrate de que el **init_db.sql** está en el mismo directorio
```bash
docker exec -i containerCbas psql -U cbas -d baseCbas < init_db.sql
```

---

## 📊 Importar y Exportar CSV

### Exportar una tabla a CSV
```bash
docker exec -it containerCbas psql -U cbas -d baseCbas -c "\copy (SELECT * FROM clientes) TO STDOUT DELIMITER '|' CSV HEADER" > datos_clientes.csv
```

### Importar desde CSV a una tabla temporal
```bash
cat clientes.csv | docker exec -i containerCbas psql -U cbas -d baseCbas -c "\copy tabla_temp FROM STDIN DELIMITER '|' CSV HEADER"
```

---

## ⚙️ Automatización mediante Funciones (PL/pgSQL)

Para automatizar la carga, validación e inserción en múltiples tablas hay que seguir este esquema lógico:

### Ejemplo de Función de Carga y Validación
Supongamos que importas datos de "ventas" a una tabla temporal y quieres repartirlos en `clientes` y `pedidos`.

```sql
CREATE OR REPLACE FUNCTION procesar_carga_csv()
RETURNS void AS $$
BEGIN
    -- 1. Programacion defensiva
    DELETE FROM tabla_temp WHERE email IS NULL OR monto <= 0;

    -- 2. Insertar en tabla clientes
    INSERT INTO clientes (nombre, email)
    SELECT DISTINCT nombre_cliente, email 
    FROM tabla_temp
    ON CONFLICT (email) DO NOTHING;

    -- 3. Insertar en tabla pedidos con la foreign key de clientes
    INSERT INTO pedidos (cliente_id, producto, total)
    SELECT c.id, t.producto, t.monto
    FROM tabla_temp t
    JOIN clientes c ON t.email = c.email;

    -- 4. Nos cargamos la tabla temporal
    TRUNCATE TABLE tabla_temp;
    
    RAISE NOTICE 'Proceso de carga completado con éxito';
END;
$$ LANGUAGE plpgsql;
```

**Para ejecutar la automatización:**
1. Copia tu CSV a la carpeta `/backups`.
2. Ejecuta el comando de **Importar CSV** hacia `tabla_temp`.
3. Ejecuta la función desde la terminal:
```bash
docker exec -it containerCbas psql -U cbas -d baseCbas -c "SELECT procesar_carga_csv();"
```

---

## 🤡 Juguetear con la BBDD

```bash
docker exec -it containerCbas psql -U cbas -d baseCbas
```

---

### Notas de Seguridad
*   **Permisos:** Asegúrate de que la carpeta `./backups` en tu host tenga permisos de escritura.