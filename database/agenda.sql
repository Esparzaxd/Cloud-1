-- =====================================================
--  Agenda Telefónica - Script de instalación
--  Crea la base de datos, el usuario y la tabla
--  Uso:  mysql -u root -p < database/agenda.sql
-- =====================================================

-- 1. Crear la base de datos
CREATE DATABASE IF NOT EXISTS agenda
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- 2. Crear un usuario exclusivo para la aplicación
--    (cambie la contraseña y actualice config.php)
CREATE USER IF NOT EXISTS 'agenda_user'@'10.0.0.%' IDENTIFIED BY 'Agenda2026!';
GRANT SELECT, INSERT, UPDATE, DELETE ON agenda.* TO 'agenda_user'@'10.0.0.%';
FLUSH PRIVILEGES;

-- 3. Seleccionar la base de datos
USE agenda;

-- 4. Crear la tabla de contactos
CREATE TABLE IF NOT EXISTS contactos (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(50)  NOT NULL,
    apellidos       VARCHAR(80)  NOT NULL,
    telefono        VARCHAR(20)  NOT NULL,
    email           VARCHAR(100) DEFAULT NULL,
    direccion       VARCHAR(150) DEFAULT NULL,
    fecha_registro  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Datos de ejemplo
INSERT INTO contactos (nombre, apellidos, telefono, email, direccion) VALUES
('Ana',    'García López',     '555-123-4567', 'ana.garcia@correo.com',   'Av. Reforma 100'),
('Luis',   'Martínez Pérez',   '555-234-5678', 'luis.martinez@correo.com','Calle Juárez 25'),
('María',  'Hernández Ruiz',   '555-345-6789', 'maria.hdz@correo.com',    'Col. Centro 8'),
('Carlos', 'Sánchez Torres',   '555-456-7890', NULL,                      'Blvd. Norte 300'),
('Sofía',  'Ramírez Castillo', '555-567-8901', 'sofia.rc@correo.com',     NULL);
