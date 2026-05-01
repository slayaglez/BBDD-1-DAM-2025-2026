-- 1. Los CREATE
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tabla_temp (
    nombre_cliente VARCHAR(100),
    email VARCHAR(100),
    producto VARCHAR(100),
    monto NUMERIC(10, 2)
);

CREATE TABLE IF NOT EXISTS pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id),
    producto VARCHAR(100),
    total NUMERIC(10, 2),
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. INSERTS (hecho por IA)
INSERT INTO clientes (nombre, email) VALUES 
('Juan Perez', 'juan@example.com'),
('Maria Garcia', 'maria@example.com'),
('Carlos Ruiz', 'carlos.r@mail.com'),
('Laura Beltrán', 'lbeltran@servicios.es'),
('Roberto Gómez', 'rgomez88@gmail.com'),
('Ana Martínez', 'ana.mtz@empresa.org'),
('Sofía Vega', 'svega@estudios.com'),
('Diego Torres', 'dtorres@web.net'),
('Elena Nito', 'elena@correo.com'),
('Lucía Méndez', 'lumendez@tienda.io')
ON CONFLICT (email) DO NOTHING;

-- Inserciones en tabla_temp
INSERT INTO tabla_temp (nombre_cliente, email, producto, monto) VALUES 
('Pedro Picapiedra', 'pedro@roca.com', 'Taladro Neumático', 150.25),
('Juan Perez', 'juan@example.com', 'Teclado Mecánico', 85.50),
('Marta Sánchez', 'marta.s@clima.es', 'Ventilador Torre', 45.00),
('Error Humano', 'error@test.com', 'Producto Fantasma', -10.00), -- se debería borrar
('Sin Email', NULL, 'Laptop Pro', 1200.00),                    -- lo mismo
('Luis Alfaro', 'lalfaro@proyectos.com', 'Silla Ergonómica', 210.00),
('Carmen Soler', 'csoler@marketing.biz', 'Licencia Software', 99.99),
('Andrés Kuz', 'akuz@musica.com', 'Interfaz Audio', 180.00),
('Beatriz Luna', 'bluna@viajes.com', 'Maleta Viaje', 120.00),
('Javier Franco', 'jfranco@obras.es', 'Casco Seguridad', 25.50),
('Sofía Vega', 'svega@estudios.com', 'Libro SQL Avanzado', 40.00),
('Ricardo Darín', 'rdarin@cine.ar', 'Cámara Reflex', 850.00);

-- 3. Funcion para procesar csv
CREATE OR REPLACE FUNCTION procesar_carga_csv()
RETURNS void AS $$
BEGIN
    -- Programacion defensiva
    DELETE FROM tabla_temp WHERE email IS NULL OR monto <= 0;

    -- Inserts multiples
    INSERT INTO clientes (nombre, email)
    SELECT DISTINCT nombre_cliente, email 
    FROM tabla_temp
    WHERE email NOT IN (SELECT email FROM clientes);

    -- Inserts multiples
    INSERT INTO pedidos (cliente_id, producto, total)
    SELECT c.id, t.producto, t.monto
    FROM tabla_temp t
    JOIN clientes c ON t.email = c.email;

    -- Me lo cargo
    TRUNCATE TABLE tabla_temp;
    
    RAISE NOTICE '¡Kuchau! Hecho: Clientes actualizados y pedidos registrados.';
END;
$$ LANGUAGE plpgsql;