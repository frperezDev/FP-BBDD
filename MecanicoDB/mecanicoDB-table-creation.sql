# DROP DATABASE mecanicoDB;

CREATE DATABASE mecanicoDB;

USE mecanicoDB;

# DROP TABLE mecanicosPorOrdenDeTrabajo;


# Creación de la tabla cliente

CREATE TABLE clientes (
   cliente_id INT AUTO_INCREMENT,
   nombre VARCHAR(50) NOT NULL,
   apellido_1 VARCHAR(50) NOT NULL,
   apellido_2 VARCHAR(50),
   fecha_nacimiento DATE NOT NULL,
   edad INT NOT NULL CHECK(edad >= 18),
   PRIMARY KEY (cliente_id)
);


CREATE TABLE telefonos (
   cliente INT NOT NULL,
   telefono INT NOT NULL,
   PRIMARY KEY (cliente, telefono),
   CONSTRAINT fk_tlf_cliente 
   FOREIGN KEY (cliente) 
   REFERENCES clientes(cliente_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);

CREATE TABLE vehiculos (
   matricula VARCHAR(20) NOT NULL,
   cliente INT NOT NULL,
   marca VARCHAR(50) NOT NULL,
   modelo VARCHAR(50) NOT NULL,
   fecha_matriculacion DATE NOT NULL,
   PRIMARY KEY (matricula),
   CONSTRAINT fk_veh_cliente 
   FOREIGN KEY (cliente) 
   REFERENCES clientes(cliente_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);

CREATE TABLE mecanicos (
   mecanico_id INT AUTO_INCREMENT,
   nombre VARCHAR(50) NOT NULL,
   apellido_1 VARCHAR(50) NOT NULL,
   apellido_2 VARCHAR(50),
   DNI VARCHAR(10) NOT NULL,
   fecha_nacimiento DATE NOT NULL,
   edad INT NOT NULL,
   telefono INT NOT NULL,
   especialidad VARCHAR(100) NOT NULL,
   salario DECIMAL (10,5) NOT NULL CHECK(salario >= 16576),
   años_experiencia INT NOT NULL CHECK(años_experiencia >= 0),
   PRIMARY KEY (mecanico_id)
);

CREATE TABLE servicios (
   servicio_id INT AUTO_INCREMENT,
   nombre VARCHAR(50) NOT NULL,
   coste INT NOT NULL CHECK(coste >= 0),
   PRIMARY KEY (servicio_id)
);

CREATE TABLE incidencias (
   incidencia_id INT AUTO_INCREMENT,
   matricula VARCHAR(20) NOT NULL,
   fecha_entrada DATE NOT NULL,
   fecha_entrega DATE,
   PRIMARY KEY (incidencia_id),
   CONSTRAINT fk_ord_matricula 
   FOREIGN KEY (matricula) 
   REFERENCES vehiculos(matricula)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);

CREATE TABLE serviciosIncidencias (
   incidencia_id INT NOT NULL,
   servicio_id INT NOT NULL,
   PRIMARY KEY (incidencia_id, servicio_id),
   CONSTRAINT fk_spo_orden 
   FOREIGN KEY (incidencia_id) 
   REFERENCES incidencias(incidencia_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
   CONSTRAINT fk_spo_servicio 
   FOREIGN KEY (servicio_id) 
   REFERENCES servicios(servicio_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);

CREATE TABLE mecanicosIncidencias (
   mecanico INT NOT NULL,
   incidencia INT NOT NULL,
   fecha DATE NOT NULL,
   horas INT NOT NULL,
   PRIMARY KEY (mecanico, incidencia, fecha),
   CONSTRAINT fk_mpo_mecanico 
   FOREIGN KEY (mecanico) 
   REFERENCES mecanicos(mecanico_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
   CONSTRAINT fk_mpo_orden 
   FOREIGN KEY (incidencia) 
   REFERENCES incidencias(incidencia_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);






