USE master;
GO
-- *************************************************************************************************************************
-- * BORRANDO BASE DE DATOS SI EXISTE
-- *************************************************************************************************************************

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'db_supermercado')
BEGIN
    ALTER DATABASE db_supermercado SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE db_supermercado;
END
GO

-- *************************************************************************************************************************
-- * CREANDO BASE DE DATOS
-- *************************************************************************************************************************

CREATE DATABASE db_supermercado;
GO


USE db_supermercado;
GO

-- *************************************************************************************************************************
-- * CREANDO TABLAS DE LA BASE DE DATOS
-- *************************************************************************************************************************


CREATE TABLE forma_pago(
	id INT IDENTITY(1,1) PRIMARY KEY,
	forma VARCHAR (50) NOT NULL
);

CREATE TABLE motivo_contrato(
	id INT IDENTITY(1,1) PRIMARY KEY,
	motivo VARCHAR (100) NOT NULL
);

CREATE TABLE contrato(
	id INT IDENTITY(1,1) PRIMARY KEY,
	fecha_inicio DATE NOT NULL,
	fecha_finalizacion DATE NOT NULL,
	descripcion VARCHAR(255) NOT NULL,
	sueldo_hora DECIMAL(10,2) NOT NULL,
	id_motivo_contrato INT NOT NULL,
	FOREIGN KEY (id_motivo_contrato) REFERENCES motivo_contrato(id)
);

CREATE TABLE tipo_empleado(
	id INT IDENTITY(1,1) PRIMARY KEY,
	tipo NVARCHAR(100) NOT NULL
);

CREATE TABLE empleado(
	id INT IDENTITY(1,1) PRIMARY KEY,
	dni NVARCHAR(8) UNIQUE NOT NULL,
	codigo VARCHAR(50) UNIQUE NOT NULL,
	nombre NVARCHAR(100) NOT NULL,
	apellido_paterno NVARCHAR(100) NOT NULL,
	apellido_materno NVARCHAR(100) NOT NULL,
	horas_trabajo DECIMAL(10, 2) NOT NULL,
	id_tipo_empleado INT NOT NULL,
	id_contrato INT UNIQUE NOT NULL,
	FOREIGN KEY (id_tipo_empleado) REFERENCES tipo_empleado(id),
	FOREIGN KEY (id_contrato) REFERENCES contrato(id)
);

CREATE TABLE unidad_medida(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre NVARCHAR(100) NOT NULL,
	estado BIT DEFAULT 1 NOT NULL
);

CREATE TABLE tipo_producto(
	id INT IDENTITY(1,1) PRIMARY KEY,
	tipo NVARCHAR(100) NOT NULL,
	estado BIT DEFAULT 1 NOT NULL
);

CREATE TABLE marca_producto(
	id INT IDENTITY(1,1) PRIMARY KEY,
	marca NVARCHAR(100) NOT NULL,
	estado BIT DEFAULT 1 NOT NULL
);

CREATE TABLE producto(
	id INT IDENTITY(1,1) PRIMARY KEY,
	codigo NVARCHAR(100) UNIQUE NOT NULL,
	nombre NVARCHAR(100) NOT NULL,
	descripcion NVARCHAR(250) NOT NULL,
	precio DECIMAL(10,2) NOT NULL,
	contenido_neto DECIMAL(10, 2) NOT NULL,
	descuento DECIMAL(10,2),
	cantidad INT NOT NULL,
	estado BIT DEFAULT 1 NOT NULL,
	id_unidad_medida INT NOT NULL,
	id_tipo_producto INT NOT NULL,
	id_marca INT NOT NULL,
	FOREIGN KEY (id_unidad_medida) REFERENCES unidad_medida(id),
	FOREIGN KEY (id_tipo_producto) REFERENCES tipo_producto(id),
	FOREIGN KEY (id_marca) REFERENCES marca_producto(id)
);

CREATE TABLE tipo_cliente(
	id INT IDENTITY(1,1) PRIMARY KEY,
	tipo NVARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE cliente(
	id INT IDENTITY(1,1) PRIMARY KEY,
	codigo NVARCHAR(100) UNIQUE NOT NULL,
	dni NVARCHAR(8) UNIQUE NOT NULL,
	nombre NVARCHAR(100) NOT NULL,
	apellido_paterno NVARCHAR(100) NOT NULL,
	apellido_materno NVARCHAR(100) NOT NULL,
	id_tipo_cliente INT,
	FOREIGN KEY (id_tipo_cliente) REFERENCES tipo_cliente(id)
);

CREATE TABLE envio_venta(
	id INT IDENTITY(1,1) PRIMARY KEY,
	direccion NVARCHAR(250) NOT NULL,
	id_empleado INT NOT NULL,
	FOREIGN KEY(id_empleado) REFERENCES empleado(id)
);

CREATE TABLE venta(
	id INT IDENTITY(1,1) PRIMARY KEY,
	cantidad INT NOT NULL,
	fecha DATE DEFAULT GETDATE() NOT NULL,
	id_producto INT NOT NULL,
	id_cliente INT NOT NULL,
	id_forma_pago INT NOT NULL,
	id_envio_venta INT,
	FOREIGN KEY (id_producto) REFERENCES producto(id),
	FOREIGN KEY (id_cliente) REFERENCES cliente(id),
	FOREIGN KEY (id_forma_pago) REFERENCES forma_pago(id),
	FOREIGN KEY (id_envio_venta) REFERENCES envio_venta(id)
);


CREATE TABLE detalle_producto(
	id INT IDENTITY(1,1) PRIMARY KEY,
	detalle NVARCHAR(250) NOT NULL,
	estado BIT DEFAULT 1 NOT NULL,
	id_producto INT NOT NULL,
	FOREIGN KEY (id_producto) REFERENCES producto(id)
);

CREATE TABLE rol(
	id INT IDENTITY(1,1) PRIMARY KEY,
	rol NVARCHAR(100) NOT NULL,
	estado BIT DEFAULT 1 NOT NULL
);

CREATE TABLE usuario(
	id INT IDENTITY(1,1) PRIMARY KEY,
	dni VARCHAR(8) UNIQUE NOT NULL,
	codigo NVARCHAR(50) UNIQUE NOT NULL,
	nombre NVARCHAR(100) NOT NULL,
	apellido_paterno NVARCHAR(100) NOT NULL,
	apellido_materno NVARCHAR(100) NOT NULL,
	correo NVARCHAR(200) UNIQUE NOT NULL,
	contrasena NVARCHAR(100) NOT NULL,
	estado BIT DEFAULT 1 NOT NULL,
	id_rol INT,
	FOREIGN KEY (id_rol) REFERENCES rol(id)
);

CREATE TABLE log_procesos (
	id INT IDENTITY(1,1) PRIMARY KEY,
	motivo NVARCHAR(100) NOT NULL,
	descripcion NVARCHAR(255) NOT NULL,
	fecha DATETIME NOT NULL,
	id_usuario INT NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);
