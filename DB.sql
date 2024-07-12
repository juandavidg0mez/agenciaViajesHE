CREATE DATABASE aiport;
USE aiport;
CREATE TABLE IF NOT EXISTS tipoDocumento(
    id_tipo_documento INT PRIMARY KEY AUTO_INCREMENT,
    nombreDoc VARCHAR(50);
);

CREATE Table IF NOT EXISTS cliente(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    documento INT NOT NULL,
    nombre1 VARCHAR(30) NOT NULL,
    nombre2 VARCHAR(30) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    Fnacimiento DATE
    
);

CREATE Table IF NOT EXISTS tarifasAerolinea(
    id_tarifasAerolinea INT PRIMARY KEY AUTO_INCREMENT,
    descrip VARCHAR(50),
    detalles TEXT,
    valorTarifaVuelo DOUBLE(15,2)
);

CREATE Table IF NOT EXISTS aerolinea(
    id_aerolineas INT PRIMARY KEY AUTO_INCREMENT,
    nombreAeroline VARCHAR(50) NOT NULL
);

CREATE Table IF NOT EXISTS tripulacion(
    id_tripulacion INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE Table IF NOT EXISTS talleRevision(
    id_talleRevision INT PRIMARY KEY AUTO_INCREMENT,
    descrip TEXT NOT NULL,
    id_empleado INT NOT NULL
);

CREATE Table IF NOT EXISTS pais(
    id_pais VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS ciudad(
    id_ciudad VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    id_pais VARCHAR(5) NOT NULL
);

CREATE TABLE IF NOT EXISTS aeropuerto(
    id_aeropuerto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    id_ciudad VARCHAR(5) NOT NULL    
);

CREATE TABLE IF NOT EXISTS puertaSalidaAbordaje