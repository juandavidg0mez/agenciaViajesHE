CREATE DATABASE aiport;

USE aiport;

CREATE TABLE IF NOT EXISTS tipoDocumento(
    id_tipo_documento INT PRIMARY KEY AUTO_INCREMENT,
    nombreDoc VARCHAR(50);

);

CREATE Table IF NOT EXISTS cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    documento INT NOT NULL,
    nombre1 VARCHAR(30) NOT NULL,
    nombre2 VARCHAR(30) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    Fnacimiento DATE NOT NULL,
    id_tipo_documento INT NOT NULL,
    Foreign Key (id_tipo_documento) REFERENCES tipoDocumento (id_tipo_documento)
);

CREATE Table IF NOT EXISTS tarifasAerolinea (
    id_tarifasAerolinea INT PRIMARY KEY AUTO_INCREMENT,
    descrip VARCHAR(50),
    detalles TEXT,
    valorTarifaVuelo DOUBLE(15, 2)
);

CREATE Table IF NOT EXISTS aerolinea (
    id_aerolineas INT PRIMARY KEY AUTO_INCREMENT,
    nombreAeroline VARCHAR(50) NOT NULL
);

CREATE Table IF NOT EXISTS tripulacionRol (
    id_tripulacionRoles INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);



CREATE Table IF NOT EXISTS pais (
    id_pais VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS ciudad (
    id_ciudad VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    id_pais VARCHAR(5) NOT NULL,
    Foreign Key (id_pais) REFERENCES pais (id_pais)
);
CREATE TABLE IF NOT EXISTS aeropuerto (
    id_aeropuerto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    id_ciudad VARCHAR(5) NOT NULL,
    Foreign Key (id_ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE IF NOT EXISTS puertaSalidaAbordaje (
    id_puertaSalidaAbordaje INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) not NULL,
    id_aeropuerto INT NOT NULL,
    Foreign Key (id_aeropuerto) REFERENCES aeropuerto (id_aeropuerto)
);

CREATE TABLE IF NOT EXISTS empleado (
    id_empleado VARCHAR(20) PRIMARY KEY,
    nombre1 VARCHAR(40) NOT NULL,
    nombre2 VARCHAR(40) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_ingreso_empleado DATE NOT NULL,
    id_tripulacionRoles INT NULL NULL,
    id_aerolineas INT NOT NULL,
    id_aeropuerto INT NOT NULL,
    Foreign Key (id_tripulacionRoles) REFERENCES tripulacionRol (id_tripulacionRoles),
    Foreign Key (id_aerolineas) REFERENCES aerolinea (id_aerolineas),
    Foreign Key (id_aeropuerto) REFERENCES aeropuerto (id_aeropuerto)
);



CREATE TABLE IF NOT EXISTS manufactura (
    id_manufactura INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(50),
    email VARCHAR(100),
    sitio_web VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS modelo (
    id_modelo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    id_manufactura INT NOT NULL,
    Foreign Key (id_manufactura) REFERENCES manufactura (id_manufactura)
);

CREATE TABLE IF NOT EXISTS estado (
    id_estado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS avion (
    id_avion INT PRIMARY KEY AUTO_INCREMENT,
    placa_identificacion VARCHAR(30) NOT NULL,
    capacidad INT not NULL,
    fabricacion_fecha DATE NOT NULL,
    id_estado INT NOT NULL,
    id_modelo INT NULL,
    Foreign Key (id_estado) REFERENCES estado (id_estado),
    Foreign Key (id_modelo) REFERENCES modelo (id_modelo)
);


CREATE TABLE IF NOT EXISTS vuelo (
    id_vuelo INT AUTO_INCREMENT PRIMARY KEY,
    numero_vuelo VARCHAR(20) NOT NULL UNIQUE,
    aeropuerto_origen INT NOT NULL,
    aeropuerto_destino INT NOT NULL,
    hora_salida DATETIME NOT NULL,
    hora_llegada DATETIME NOT NULL,
    FOREIGN KEY (aeropuerto_origen) REFERENCES aeropuerto(id_aeropuerto),
    FOREIGN KEY (aeropuerto_destino) REFERENCES aeropuerto(id_aeropuerto)
);

/*
La tabla de escalas contiene información sobre las escalas que hace un vuelo. Incluye el ID del vuelo, el ID del aeropuerto donde se realiza la escala, y las horas de llegada y salida de la escala.
vuelo_id: Este campo es una clave foránea que referencia a la tabla de Vuelos, indicando a qué vuelo pertenece la escala.
aeropuerto_id: Este campo es una clave foránea que referencia a la tabla de Aeropuertos, indicando en qué aeropuerto se realiza la escala.
*/

CREATE TABLE escala (
    id_escala INT AUTO_INCREMENT PRIMARY KEY,
    id_vuelo INT NOT NULL,
    id_aeropuerto INT NOT NULL,
    hora_llegada DATETIME NOT NULL,
    hora_salida DATETIME NOT NULL,
    FOREIGN KEY (id_vuelo) REFERENCES vuelo(id_vuelo),
    FOREIGN KEY (id_aeropuerto) REFERENCES aeropuertos(id_aeropuerto)
);


CREATE TABLE IF NOT EXISTS detalle_vuelo(
    id_detalle_vuelo INT PRIMARY KEY AUTO_INCREMENT,
    id_vuelo INT NOT NULL,
    id_escala INT,
    id_avion INT NOT NULL,
    Foreign Key (id_vuelo) REFERENCES vuelo(id_vuelo),
    Foreign Key (id_escala) REFERENCES escala(id_escala),
    Foreign Key (id_avion) REFERENCES avion(id_avion)
);


CREATE TABLE IF NOT EXISTS tripulacionVuelo(
    id_empleado VARCHAR(20) NOT NULL,
    id_detalle_vuelo INT NOT NULL,
    Foreign Key (id_empleado) REFERENCES empleado(id_empleado),
    Foreign Key (id_detalle_vuelo) REFERENCES detalle_vuelo(id_detalle_vuelo)
);

CREATE Table IF NOT EXISTS detalleRevision (
    id_detalleRevision INT PRIMARY KEY AUTO_INCREMENT,
    descrip TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS revision(
    id_revision VARCHAR(5) PRIMARY KEY,
    fecha_revision DATE NOT NULL,
    id_avion INT NOT NULL,
    id_detalleRevision INT NOT NULL,
    Foreign Key (id_avion) REFERENCES avion(id_avion)
    Foreign Key (id_detalleRevision) REFERENCES detalleRevision(id_detalleRevision)
);

CREATE TABLE IF NOT EXISTS empleado_revision(
    id_revision VARCHAR(5) NOT NULL,
    id_empleado VARCHAR(20) NOT NULL,
    Foreign Key (id_revision) REFERENCES revision(id_revision),
    Foreign Key (id_empleado) REFERENCES empleado(id_empleado)
);

-- GESTION DE PAGOS Y METODOS DE PAGO
CREATE TABLE IF NOT EXISTS tipoClase(
    id_tipoClase INT PRIMARY KEY AUTO_INCREMENT,
    nombre_Clase VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS tarifasVuelo (
    id_tarifasVuelo INT AUTO_INCREMENT PRIMARY KEY,
    id_vuelo INT NOT NULL,
    id_tipoClase INT NOT NULL,  -- Económica, Business, Primera Clase
    precio_tarifa DECIMAL(10, 2) NOT NULL,
    descripcion TEXT,    -- Fecha de fin de la tarifa
    FOREIGN KEY (id_vuelo) REFERENCES vuelo(id_vuelo),
    Foreign Key (id_tipoClase) REFERENCES tipoClase(id_tipoClase)
);

-- GESTION DE RESERVAS Y CAPACIDAD
CREATE TABLE IF NOT EXISTS estadoReserva(
    id_estadoReserva INT PRIMARY KEY AUTO_INCREMENT,
    nombre_estado VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS reserva(
    id_reserva VARCHAR(5) PRIMARY KEY,
    fecha_reserva DATE NOT NULL,
    id_vuelo INT NOT NULL,
    id_estadoReserva INT NOT NULL,
    Foreign Key (id_vuelo) REFERENCES vuelo(id_vuelo),
    Foreign Key (id_estadoReserva) REFERENCES estadoReserva(id_estadoReserva)
);


CREATE TABLE IF NOT EXISTS metodosPago(
    id_metodosPago INT PRIMARY KEY AUTO_INCREMENT,
    nombre_metodo VARCHAR(60) NOT NULL
);

CREATE TABLE pago(
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_tarifasVuelo INT NOT NULL,
    fecha_pago DATETIME NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    id_metodosPago VARCHAR(50) NOT NULL,  
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_tarifasVuelo) REFERENCES tarifasVuelo(id_tarifasVuelo)
);
-- PODEMOS CREAR UNA VISTA QUE GENERE LA FACTURA
CREATE TABLE factura_vuelo_reserva (
    id_factura_vuelo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_emision DATETIME NOT NULL,
    id_pago INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    Foreign Key (id_pago) REFERENCES pago(id_pago)
);
