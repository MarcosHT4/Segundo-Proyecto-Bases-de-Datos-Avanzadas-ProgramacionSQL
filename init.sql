CREATE DATABASE vivero;
USE vivero;
CREATE TABLE sector (
  idSector INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  superficieDisponible DECIMAL(10, 2)
);

CREATE TABLE estadosembrado (
  idEstadoSembrado INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  estado VARCHAR(255)
);
CREATE TABLE sembrado (
  idSembrado INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  fechaInicial DATE,
  superficie DECIMAL(10, 2),
  idEstadoSembrado INT,
  idSector INT,
  FOREIGN KEY (idEstadoSembrado) REFERENCES estadosembrado(idEstadoSembrado),
  FOREIGN KEY (idSector) REFERENCES sector(idSector)
);

CREATE TABLE marcaabono (
  idMarcaAbono INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  marca VARCHAR(255)
);

CREATE TABLE tipoabono (
  idTipoAbono INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  tipo VARCHAR(255)
);

CREATE TABLE abono (
  idAbono INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  cantidadEnStock INT,
  idMarcaAbono INT,
  idTipoAbono INT,
  FOREIGN KEY (idMarcaAbono) REFERENCES marcaabono(idMarcaAbono),
  FOREIGN KEY (idTipoAbono) REFERENCES tipoabono(idTipoAbono)
);

CREATE TABLE metododepago (
  idMetodoDePago INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  metodoDePago VARCHAR(255)
);

CREATE TABLE estadoventa (
  idEstadoVenta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  estado VARCHAR(255)
);

CREATE TABLE usuario (
  idUsuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombreUsuario VARCHAR(255),
  contrasena VARCHAR(255)
);

CREATE TABLE zona (
  idZona INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  calle VARCHAR(255)
);

CREATE TABLE empleado (
  ciEmpleado INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  apellidoPaterno VARCHAR(255),
  apellidoMaterno VARCHAR(255),
  correo VARCHAR(255),
  nroCasa INT,
  telefono VARCHAR(255),
  idUsuario INT,
  idZona INT,
  FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
  FOREIGN KEY (idZona) REFERENCES zona(idZona)
);

CREATE TABLE cliente (
  ciCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  apellidoPaterno VARCHAR(255),
  apellidoMaterno VARCHAR(255),
  correo VARCHAR(255),
  nroCasa INT,
  telefono VARCHAR(255),
  idUsuario INT,
  idZona INT,
  FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
  FOREIGN KEY (idZona) REFERENCES zona(idZona)
);


CREATE TABLE venta (
  idVenta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  fechaVenta DATE,
  precioTotal DECIMAL(10,2),
  idMetodoDePago INT,
  idEstadoVenta INT,
  ciCliente INT,
  ciEmpleado INT,
  FOREIGN KEY (idMetodoDePago) REFERENCES metododepago(idMetodoDePago),
  FOREIGN KEY (idEstadoVenta) REFERENCES estadoventa(idEstadoVenta),
  FOREIGN KEY (ciCliente) REFERENCES cliente(ciCliente),
  FOREIGN KEY (ciEmpleado) REFERENCES empleado(ciEmpleado)
);



CREATE TABLE proveedor (
  idProveedor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  correo VARCHAR(255),
  nroCasa INT,
  telefono VARCHAR(255),
  idZona INT,
  FOREIGN KEY (idZona) REFERENCES zona(idZona)
);

CREATE TABLE tiporeporte (
  idTipoReporte INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  tipo VARCHAR(255)
);

CREATE TABLE reporte (
  idReporte INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(255),
  contenido VARCHAR(255),
  fechaReporte DATE,
  idTipoReporte INT,
  ciEmpleado INT,
  FOREIGN KEY (idTipoReporte) REFERENCES tiporeporte(idTipoReporte),
  FOREIGN KEY (ciEmpleado) REFERENCES empleado(ciEmpleado)
);

CREATE TABLE nombrecientificoplanta (
  idNombreCientifico INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombreCientifico VARCHAR(255),
  nombreComun VARCHAR(255)
);

CREATE TABLE planta (
  idPlanta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  descripcion VARCHAR(255),
  precio DECIMAL(10, 2),
  idNombreCientifico INT,
  FOREIGN KEY (idNombreCientifico) REFERENCES nombrecientificoplanta(idNombreCientifico)
);

CREATE TABLE marcapesticida (
  idMarcaPesticida INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  marca VARCHAR(255)
);

CREATE TABLE tipopesticida (
  idTipoPesticida INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  tipo VARCHAR(255)
);

CREATE TABLE pesticida (
  idPesticida INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  cantidadEnStock INT,
  idMarcaPesticida INT,
  idTipoPesticida INT,
  FOREIGN KEY (idMarcaPesticida) REFERENCES marcapesticida(idMarcaPesticida),
  FOREIGN KEY (idTipoPesticida) REFERENCES tipopesticida(idTipoPesticida)
);


CREATE TABLE sembradoabono (
  idSembrado INT,
  idAbono INT,
  PRIMARY KEY (idSembrado, idAbono),
  FOREIGN KEY (idSembrado) REFERENCES sembrado(idSembrado),
  FOREIGN KEY (idAbono) REFERENCES abono(idAbono)
);

CREATE TABLE sembradoplanta (
  idSembrado INT,
  idPlanta INT,
  cantidad INT,
  PRIMARY KEY (idSembrado, idPlanta),
  FOREIGN KEY (idSembrado) REFERENCES sembrado(idSembrado),
  FOREIGN KEY (idPlanta) REFERENCES planta(idPlanta)
);

CREATE TABLE ventaplanta (
  idVenta INT,
  idPlanta INT,
  cantidad INT,
  PRIMARY KEY (idVenta, idPlanta),
  FOREIGN KEY (idVenta) REFERENCES venta(idVenta),
  FOREIGN KEY (idPlanta) REFERENCES planta(idPlanta)
);

CREATE TABLE proveedorabono (
  idProveedor INT,
  idAbono INT,
  cantidadHistorica INT,
  PRIMARY KEY (idProveedor, idAbono),
  FOREIGN KEY (idProveedor) REFERENCES proveedor(idProveedor),
  FOREIGN KEY (idAbono) REFERENCES abono(idAbono)
);

CREATE TABLE proveedorpesticida (
  idProveedor INT,
  idPesticida INT,
  cantidadHistorica INT,
  PRIMARY KEY (idProveedor, idPesticida),
  FOREIGN KEY (idProveedor) REFERENCES proveedor(idProveedor),
  FOREIGN KEY (idPesticida) REFERENCES pesticida(idPesticida)
);

CREATE TABLE sembradopesticida (
  idSembrado INT,
  idPesticida INT,
  PRIMARY KEY (idSembrado, idPesticida),
  FOREIGN KEY (idSembrado) REFERENCES sembrado(idSembrado),
  FOREIGN KEY (idPesticida) REFERENCES pesticida(idPesticida)
);

CREATE TABLE sembradosombra (
  idSembrado INT NOT NULL,
  fechaInicial DATE,
  superficie DECIMAL(10, 2),
  idEstadoSembrado INT,
  idSector INT,
  mod_usuario VARCHAR(100),
  mod_fecha DATETIME,
  accion VARCHAR(1)
);

CREATE TABLE ventasombra (
  idVenta INT NOT NULL ,
  fechaVenta DATE,
  precioTotal DECIMAL(10,2),
  idMetodoDePago INT,
  idEstadoVenta INT,
  ciCliente INT,
  ciEmpleado INT,
  mod_usuario VARCHAR(100),
  mod_fecha DATETIME,
  accion VARCHAR(1)
);

CREATE TABLE reportesombra (
  idReporte INT NOT NULL,
  titulo VARCHAR(255),
  contenido VARCHAR(255),
  fechaReporte DATE,
  idTipoReporte INT,
  ciEmpleado INT,
  mod_usuario VARCHAR(100),
  mod_fecha DATETIME,
  accion VARCHAR(1)
);

CREATE TABLE clientesombra (
  ciCliente INT NOT NULL,
  nombre VARCHAR(255),
  apellidoPaterno VARCHAR(255),
  apellidoMaterno VARCHAR(255),
  correo VARCHAR(255),
  nroCasa INT,
  telefono VARCHAR(255),
  idUsuario INT,
  idZona INT,
  mod_usuario VARCHAR(100),
  mod_fecha DATETIME,
  accion VARCHAR(1)
);

CREATE TABLE empleadosombra (
  ciEmpleado INT NOT NULL,
  nombre VARCHAR(255),
  apellidoPaterno VARCHAR(255),
  apellidoMaterno VARCHAR(255),
  correo VARCHAR(255),
  nroCasa INT,
  telefono VARCHAR(255),
  idUsuario INT,
  idZona INT,
  mod_usuario VARCHAR(100),
  mod_fecha DATETIME,
  accion VARCHAR(1)
);


CREATE TABLE proveedorsombra (
  idProveedor INT NOT NULL ,
  nombre VARCHAR(255),
  correo VARCHAR(255),
  nroCasa INT,
  telefono VARCHAR(255),
  idZona INT,
  mod_usuario VARCHAR(100),
  mod_fecha DATETIME,
  accion VARCHAR(1)
);

DELIMITER //

CREATE PROCEDURE CrearSembrado (
  IN p_fechaInicial DATE,
  IN p_superficie INT,
  IN p_idEstadoSembrado INT,
  IN p_idSector INT,
  IN p_plantas JSON
)
BEGIN

  DECLARE i INT DEFAULT 0;
  DECLARE plantas_count INT;
  DECLARE planta_id INT;
  DECLARE planta_cantidad INT;

  INSERT INTO sembrado (fechaInicial,superficie,idEstadoSembrado, idSector)
  VALUES (p_fechaInicial,p_superficie,p_idEstadoSembrado, p_idSector);

  SET @sembrado_id = LAST_INSERT_ID();

  SET plantas_count = JSON_LENGTH(p_plantas);

  WHILE i < plantas_count DO

    SET planta_id = JSON_EXTRACT(p_plantas, CONCAT('$[', i, '].idPlanta'));
    SET planta_cantidad = JSON_EXTRACT(p_plantas, CONCAT('$[', i, '].cantidad'));

    INSERT INTO sembradoplanta (idSembrado, idPlanta, cantidad)
    VALUES (@sembrado_id, planta_id, planta_cantidad);

    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ActualizarSembradoPlanta (
  IN p_idSembrado INT,
  IN p_plantas JSON,
  IN p_plantas_eliminar JSON
)
BEGIN

  DECLARE i INT DEFAULT 0;
  DECLARE plantas_count INT;
  DECLARE planta_id INT;
  DECLARE planta_cantidad INT;

  IF p_plantas IS NOT NULL THEN

  SET plantas_count = JSON_LENGTH(p_plantas);

  WHILE i < plantas_count DO

    SET planta_id = JSON_EXTRACT(p_plantas, CONCAT('$[', i, '].idPlanta'));
    SET planta_cantidad = JSON_EXTRACT(p_plantas, CONCAT('$[', i, '].cantidad'));

    IF EXISTS (
      SELECT * FROM sembradoplanta WHERE idSembrado = p_idSembrado AND idPlanta = planta_id
    ) THEN
      UPDATE sembradoplanta SET cantidad = cantidad + planta_cantidad WHERE idSembrado = p_idSembrado AND idPlanta = planta_id;
    ELSE
      INSERT INTO sembradoplanta (idSembrado, idPlanta, cantidad) VALUES (p_idSembrado, planta_id, planta_cantidad);
    END IF;

    SET i = i + 1;
  END WHILE;
  END IF;

  IF p_plantas_eliminar IS NOT NULL THEN

  SET plantas_count = JSON_LENGTH(p_plantas_eliminar);
  SET i = 0;

  WHILE i < plantas_count DO

    SET planta_id = JSON_EXTRACT(p_plantas_eliminar, CONCAT('$[', i, '].idPlanta'));

    DELETE FROM sembradoplanta WHERE idSembrado = p_idSembrado AND idPlanta = planta_id;
    SET i = i + 1;
  END WHILE;

  END IF;




END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE EliminarSembrado (
  IN p_idSembrado INT
)
BEGIN

  DELETE FROM sembradoplanta WHERE idSembrado = p_idSembrado;

  DELETE FROM sembradopesticida WHERE idSembrado = p_idSembrado;

  DELETE FROM sembradoabono WHERE idSembrado = p_idSembrado;

  DELETE FROM sembrado WHERE idSembrado = p_idSembrado;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE CrearVenta (
  IN p_fechaVenta DATE,
  IN p_idMetodoDePago INT,
  IN p_idEstadoVenta INT,
  IN p_ciCliente INT,
  IN p_ciEmpleado INT,
  IN p_plantas JSON
)
BEGIN

  DECLARE i INT DEFAULT 0;
  DECLARE plantas_count INT;
  DECLARE planta_id INT;
  DECLARE planta_cantidad INT;

  INSERT INTO venta (fechaVenta,precioTotal ,idMetodoDePago, idEstadoVenta, ciCliente, ciEmpleado)
  VALUES (p_fechaVenta,0.0,p_idMetodoDePago, p_idEstadoVenta, p_ciCliente, p_ciEmpleado);

  SET @venta_id = LAST_INSERT_ID();


  SET plantas_count = JSON_LENGTH(p_plantas);


  WHILE i < plantas_count DO

    SET planta_id = JSON_EXTRACT(p_plantas, CONCAT('$[', i, '].idPlanta'));
    SET planta_cantidad = JSON_EXTRACT(p_plantas, CONCAT('$[', i, '].cantidad'));


    INSERT INTO ventaplanta (idVenta, idPlanta, cantidad)
    VALUES (@venta_id, planta_id, planta_cantidad);

    SET i = i + 1;
  END WHILE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ActualizarVentaPlanta (
  IN p_idVenta INT,
  IN p_plantas JSON,
  IN p_plantas_eliminar JSON
)
BEGIN
  DECLARE plantas_count INT;
  DECLARE i INT DEFAULT 0;
  DECLARE planta_id INT;
  DECLARE planta_cantidad INT;

  IF p_plantas IS NOT NULL THEN

  SET plantas_count = JSON_LENGTH(p_plantas);

  WHILE i < plantas_count DO


    SET planta_id = JSON_EXTRACT(p_plantas, CONCAT('$[', i, '].idPlanta'));
    SET planta_cantidad = JSON_EXTRACT(p_plantas, CONCAT('$[', i, '].cantidad'));

    IF EXISTS (
      SELECT * FROM ventaplanta WHERE idVenta = p_idVenta AND idPlanta = planta_id
    ) THEN
      UPDATE ventaplanta SET cantidad = cantidad + planta_cantidad WHERE idVenta = p_idVenta AND idPlanta = planta_id;
    ELSE

    INSERT INTO ventaplanta (idVenta, idPlanta, cantidad)
    VALUES (p_idVenta, planta_id, planta_cantidad);
    END IF;
    SET i = i + 1;

  END WHILE;
  END IF;

  IF p_plantas_eliminar IS NOT NULL THEN
      SET plantas_count = JSON_LENGTH(p_plantas_eliminar);
      SET i = 0;

  WHILE i < plantas_count DO

    SET planta_id = JSON_EXTRACT(p_plantas_eliminar, CONCAT('$[', i, '].idPlanta'));
    DELETE FROM ventaplanta WHERE idVenta = p_idVenta AND idPlanta = planta_id;
    SET i = i + 1;
  END WHILE;
  END IF;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE EliminarVenta(
  IN p_idVenta INT
)
BEGIN

  DELETE FROM ventaplanta WHERE idVenta = p_idVenta;

  DELETE FROM venta WHERE idVenta = p_idVenta;


END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE CrearProveedor (
  IN p_nombre VARCHAR(100),
  IN p_correo VARCHAR(100),
  IN p_nroCasa INT,
  IN p_telefono VARCHAR(20),
  IN p_idZona INT,
  IN p_abonos JSON,
  IN p_pesticidas JSON
)
BEGIN
  DECLARE proveedor_id INT;
  DECLARE i INT DEFAULT 0;
  DECLARE abonos_count INT;
  DECLARE abono_nombre VARCHAR(200);
  DECLARE abono_cantidad INT;
  DECLARE abono_marca VARCHAR(200);
  DECLARE abono_tipo INT;
  DECLARE abono_id INT;
  DECLARE marca_id INT;
  DECLARE pesticidas_count INT;
  DECLARE pesticida_nombre VARCHAR(200);
  DECLARE pesticida_cantidad INT;
  DECLARE pesticida_marca VARCHAR(200);
  DECLARE pesticida_tipo INT;
  DECLARE pesticida_id INT;

  INSERT INTO proveedor (nombre, correo,nroCasa ,telefono,idZona )
  VALUES (p_nombre,p_correo,p_nroCasa, p_telefono, p_idZona);

  SET proveedor_id = LAST_INSERT_ID();

  IF p_abonos IS NOT NULL THEN

      SET abonos_count = JSON_LENGTH(p_abonos);

  WHILE i < abonos_count DO
    SET abono_nombre = JSON_UNQUOTE(JSON_EXTRACT(p_abonos, CONCAT('$[', i, '].nombre')));
    SET abono_cantidad = JSON_EXTRACT(p_abonos, CONCAT('$[', i, '].cantidad'));
    SET abono_marca = JSON_UNQUOTE(JSON_EXTRACT(p_abonos, CONCAT('$[', i, '].marca')));
    SET abono_tipo = JSON_EXTRACT(p_abonos, CONCAT('$[', i, '].idTipo'));

    IF NOT EXISTS(
        SELECT * FROM marcaabono WHERE LOWER(marca) = LOWER(abono_marca)
    ) THEN
        INSERT INTO marcaabono(marca) VALUES (abono_marca);
        SET marca_id = LAST_INSERT_ID();
    ELSE
        SET marca_id = (SELECT idMarcaAbono FROM marcaabono WHERE LOWER(marca) = LOWER(abono_marca));
    END IF ;

    IF EXISTS(
        SELECT * FROM abono WHERE LOWER(nombre) = LOWER(abono_nombre) AND idMarcaAbono = marca_id
    ) THEN
        UPDATE abono SET cantidadEnStock = cantidadEnStock + abono_cantidad WHERE nombre = abono_nombre AND idMarcaAbono = marca_id;
        SET abono_id = (SELECT idAbono FROM abono WHERE nombre = abono_nombre AND idMarcaAbono = marca_id);
    ELSE
        INSERT INTO abono(nombre, cantidadEnStock, idMarcaAbono, idTipoAbono) VALUES (abono_nombre, abono_cantidad, marca_id, abono_tipo);
        SET abono_id = LAST_INSERT_ID();
    END IF ;

    IF NOT EXISTS(
        SELECT * FROM proveedorabono WHERE idProveedor = proveedor_id AND idAbono = abono_id
    ) THEN
        INSERT INTO proveedorabono(idProveedor, idAbono, cantidadHistorica) VALUES (proveedor_id, abono_id, abono_cantidad);
    ELSE
        UPDATE proveedorabono SET cantidadHistorica = cantidadHistorica + abono_cantidad WHERE idProveedor = proveedor_id AND idAbono = abono_id;
    END IF ;
    SET i = i + 1;
    END WHILE ;
  END IF ;

  IF p_pesticidas IS NOT NULL THEN

      SET pesticidas_count = JSON_LENGTH(p_pesticidas);
      SET i = 0;

  WHILE i < pesticidas_count DO
    SET pesticida_nombre = JSON_UNQUOTE(JSON_EXTRACT(p_pesticidas, CONCAT('$[', i, '].nombre')));
    SET pesticida_cantidad = JSON_EXTRACT(p_pesticidas, CONCAT('$[', i, '].cantidad'));
    SET pesticida_marca = JSON_UNQUOTE(JSON_EXTRACT(p_pesticidas, CONCAT('$[', i, '].marca')));
    SET pesticida_tipo = JSON_EXTRACT(p_pesticidas, CONCAT('$[', i, '].idTipo'));

    IF NOT EXISTS(
        SELECT * FROM marcapesticida WHERE LOWER(marca) = LOWER(pesticida_marca)
    ) THEN
        INSERT INTO marcapesticida(marca) VALUES (pesticida_marca);
        SET marca_id = LAST_INSERT_ID();
    ELSE
        SET marca_id = (SELECT idMarcaPesticida FROM marcapesticida WHERE LOWER(marca) = LOWER(pesticida_marca));
    END IF ;

    IF EXISTS(
        SELECT * FROM pesticida WHERE LOWER(nombre) = LOWER(pesticida_nombre) AND idMarcaPesticida = marca_id
    ) THEN
        UPDATE pesticida SET cantidadEnStock = cantidadEnStock + pesticida_cantidad WHERE nombre = pesticida_nombre AND idMarcaPesticida = marca_id;
        SET pesticida_id = (SELECT idPesticida FROM pesticida WHERE nombre = pesticida_nombre AND idMarcaPesticida = marca_id);
    ELSE
        INSERT INTO pesticida(nombre, cantidadEnStock, idMarcaPesticida, idTipoPesticida) VALUES (pesticida_nombre, pesticida_cantidad, marca_id, pesticida_tipo);
        SET pesticida_id = LAST_INSERT_ID();
    END IF ;

    IF NOT EXISTS(
        SELECT * FROM proveedorpesticida WHERE idProveedor = proveedor_id AND idPesticida = pesticida_id
    ) THEN
        INSERT INTO proveedorpesticida(idProveedor, idPesticida, cantidadHistorica) VALUES (proveedor_id, pesticida_id, pesticida_cantidad);
    ELSE
        UPDATE proveedorpesticida SET cantidadHistorica = cantidadHistorica + pesticida_cantidad WHERE idProveedor = proveedor_id AND idPesticida = pesticida_id;
    END IF ;
    SET i = i + 1;
    END WHILE ;
  END IF ;

END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE AgregarInsumos(
  IN p_idProveedor INT,
  IN p_abonos JSON,
  IN p_pesticidas JSON
)
BEGIN
    DECLARE abonos_count INT;
    DECLARE i INT DEFAULT 0;
    DECLARE abono_nombre VARCHAR(200);
    DECLARE abono_cantidad INT;
    DECLARE abono_marca VARCHAR(200);
    DECLARE abono_tipo INT;
    DECLARE abono_id INT;
    DECLARE marca_id INT;
    DECLARE pesticidas_count INT;
    DECLARE pesticida_nombre VARCHAR(200);
    DECLARE pesticida_cantidad INT;
    DECLARE pesticida_marca VARCHAR(200);
    DECLARE pesticida_tipo INT;
    DECLARE pesticida_id INT;

    IF p_abonos IS NOT NULL THEN

      SET abonos_count = JSON_LENGTH(p_abonos);

  WHILE i < abonos_count DO
    SET abono_nombre = JSON_UNQUOTE(JSON_EXTRACT(p_abonos, CONCAT('$[', i, '].nombre')));
    SET abono_cantidad = JSON_EXTRACT(p_abonos, CONCAT('$[', i, '].cantidad'));
    SET abono_marca = JSON_UNQUOTE(JSON_EXTRACT(p_abonos, CONCAT('$[', i, '].marca')));
    SET abono_tipo = JSON_EXTRACT(p_abonos, CONCAT('$[', i, '].idTipo'));

    IF NOT EXISTS(
        SELECT * FROM marcaabono WHERE LOWER(marca) = LOWER(abono_marca)
    ) THEN
        INSERT INTO marcaabono(marca) VALUES (abono_marca);
        SET marca_id = LAST_INSERT_ID();
    ELSE
        SET marca_id = (SELECT idMarcaAbono FROM marcaabono WHERE LOWER(marca) = LOWER(abono_marca));
    END IF ;

    IF EXISTS(
        SELECT * FROM abono WHERE LOWER(nombre) = LOWER(abono_nombre) AND idMarcaAbono = marca_id
    ) THEN
        UPDATE abono SET cantidadEnStock = cantidadEnStock + abono_cantidad WHERE nombre = abono_nombre AND idMarcaAbono = marca_id;
        SET abono_id = (SELECT idAbono FROM abono WHERE nombre = abono_nombre AND idMarcaAbono = marca_id);
    ELSE
        INSERT INTO abono(nombre, cantidadEnStock, idMarcaAbono, idTipoAbono) VALUES (abono_nombre, abono_cantidad, marca_id, abono_tipo);
        SET abono_id = LAST_INSERT_ID();
    END IF ;

    IF NOT EXISTS(
        SELECT * FROM proveedorabono WHERE idProveedor = p_idProveedor AND idAbono = abono_id
    ) THEN
        INSERT INTO proveedorabono(idProveedor, idAbono, cantidadHistorica) VALUES (p_idProveedor, abono_id, abono_cantidad);
    ELSE
        UPDATE proveedorabono SET cantidadHistorica = cantidadHistorica + abono_cantidad WHERE idProveedor = p_idProveedor AND idAbono = abono_id;
    END IF ;
    SET i = i + 1;
    END WHILE ;
  END IF ;

  IF p_pesticidas IS NOT NULL THEN

      SET pesticidas_count = JSON_LENGTH(p_pesticidas);
      SET i = 0;

  WHILE i < pesticidas_count DO
    SET pesticida_nombre = JSON_UNQUOTE(JSON_EXTRACT(p_pesticidas, CONCAT('$[', i, '].nombre')));
    SET pesticida_cantidad = JSON_EXTRACT(p_pesticidas, CONCAT('$[', i, '].cantidad'));
    SET pesticida_marca = JSON_UNQUOTE(JSON_EXTRACT(p_pesticidas, CONCAT('$[', i, '].marca')));
    SET pesticida_tipo = JSON_EXTRACT(p_pesticidas, CONCAT('$[', i, '].idTipo'));

    IF NOT EXISTS(
        SELECT * FROM marcapesticida WHERE LOWER(marca) = LOWER(pesticida_marca)
    ) THEN
        INSERT INTO marcapesticida(marca) VALUES (pesticida_marca);
        SET marca_id = LAST_INSERT_ID();
    ELSE
        SET marca_id = (SELECT idMarcaPesticida FROM marcapesticida WHERE LOWER(marca) = LOWER(pesticida_marca));
    END IF ;

    IF EXISTS(
        SELECT * FROM pesticida WHERE LOWER(nombre) = LOWER(pesticida_nombre) AND idMarcaPesticida = marca_id
    ) THEN
        UPDATE pesticida SET cantidadEnStock = cantidadEnStock + pesticida_cantidad WHERE nombre = pesticida_nombre AND idMarcaPesticida = marca_id;
        SET pesticida_id = (SELECT idPesticida FROM pesticida WHERE nombre = pesticida_nombre AND idMarcaPesticida = marca_id);
    ELSE
        INSERT INTO pesticida(nombre, cantidadEnStock, idMarcaPesticida, idTipoPesticida) VALUES (pesticida_nombre, pesticida_cantidad, marca_id, pesticida_tipo);
        SET pesticida_id = LAST_INSERT_ID();
    END IF ;

    IF NOT EXISTS(
        SELECT * FROM proveedorpesticida WHERE idProveedor = p_idProveedor AND idPesticida = pesticida_id
    ) THEN
        INSERT INTO proveedorpesticida(idProveedor, idPesticida, cantidadHistorica) VALUES (p_idProveedor, pesticida_id, pesticida_cantidad);
    ELSE
        UPDATE proveedorpesticida SET cantidadHistorica = cantidadHistorica + pesticida_cantidad WHERE idProveedor = p_idProveedor AND idPesticida = pesticida_id;
    END IF ;
    SET i = i + 1;
    END WHILE ;
  END IF ;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE EliminarProveedor (
  IN p_proveedor_id INT
)
BEGIN

  DELETE FROM proveedorabono WHERE idProveedor = p_proveedor_id;


  DELETE FROM proveedorpesticida WHERE idProveedor = p_proveedor_id;


  DELETE FROM proveedor WHERE idProveedor = p_proveedor_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE RegistrarCliente(
    IN p_nombreDeUsuario VARCHAR(200),
    IN p_contrasena VARCHAR(200),
    IN p_ci INT,
    IN p_nombre VARCHAR(200),
    IN p_apellidoPaterno VARCHAR(200),
    IN p_apellidoMaterno VARCHAR(200),
    IN p_correo VARCHAR(200),
    IN p_nroCasa INT,
    IN p_telefono VARCHAR(200),
    IN p_idZona INT
)
BEGIN

    DECLARE id_usuario INT;

    IF NOT EXISTS(SELECT * FROM usuario WHERE nombreUsuario=p_nombreDeUsuario) THEN
        INSERT INTO usuario(nombreUsuario, contrasena) VALUES (p_nombreDeUsuario, p_contrasena);
        SET id_usuario = LAST_INSERT_ID();
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT  = 'El usuario proporcionado ya existe';
    END IF ;

    IF NOT EXISTS(SELECT * FROM cliente WHERE correo=p_correo) THEN
        INSERT INTO cliente(ciCliente,nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona) VALUES
        (p_ci, p_nombre, p_apellidoPaterno, p_apellidoMaterno, p_correo, p_nroCasa, p_telefono, id_usuario, p_idZona);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo proporcionado ya existe';
    END IF;

END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE EliminarCliente (
  IN p_cliente_id INT
)
BEGIN
  DECLARE usuario_id INT;


  SELECT idUsuario INTO usuario_id FROM cliente WHERE ciCliente = p_cliente_id;

  DELETE vp
  FROM ventaplanta vp
  INNER JOIN venta v ON vp.idVenta = v.idVenta
  WHERE v.ciCliente = p_cliente_id;

  DELETE FROM venta WHERE ciCliente = p_cliente_id;

  DELETE FROM cliente WHERE ciCliente = p_cliente_id;

  DELETE FROM usuario WHERE idUsuario = usuario_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE RegistrarEmpleado(
    IN p_nombreDeUsuario VARCHAR(200),
    IN p_contrasena VARCHAR(200),
    IN p_ci INT,
    IN p_nombre VARCHAR(200),
    IN p_apellidoPaterno VARCHAR(200),
    IN p_apellidoMaterno VARCHAR(200),
    IN p_correo VARCHAR(200),
    IN p_nroCasa INT,
    IN p_telefono VARCHAR(200),
    IN p_idZona INT
)
BEGIN

    DECLARE id_usuario INT;

    IF NOT EXISTS(SELECT * FROM usuario WHERE nombreUsuario=p_nombreDeUsuario) THEN
        INSERT INTO usuario(nombreUsuario, contrasena) VALUES (p_nombreDeUsuario, p_contrasena);
        SET id_usuario = LAST_INSERT_ID();
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT  = 'El usuario proporcionado ya existe';
    END IF ;

    IF NOT EXISTS(SELECT * FROM empleado WHERE correo=p_correo) THEN
        INSERT INTO empleado(ciEmpleado,nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona) VALUES
        (p_ci, p_nombre, p_apellidoPaterno, p_apellidoMaterno, p_correo, p_nroCasa, p_telefono, id_usuario, p_idZona);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo proporcionado ya existe';
    END IF;

END //
DELIMITER ;

DELIMITER //

CREATE TRIGGER check_ventaplanta_cantidad_insert
BEFORE INSERT ON ventaplanta
FOR EACH ROW
BEGIN
    DECLARE cantidad_total INT;
    DECLARE cantidad_restante INT DEFAULT NEW.cantidad;
    DECLARE cantidad_actual INT;
    DECLARE idSembradoP INT;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE cur CURSOR FOR
        SELECT idSembrado, cantidad
        FROM sembradoplanta
        WHERE idPlanta = NEW.idPlanta AND cantidad > 0
        ORDER BY idSembrado;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    SELECT SUM(cantidad) INTO cantidad_total
    FROM sembradoplanta
    WHERE idPlanta = NEW.idPlanta;


    IF (NEW.cantidad > cantidad_total) THEN
        SET @error_message = CONCAT('La cantidad sembrada de la planta con identificador ', NEW.idPlanta, ' es insuficiente para la venta' );
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = @error_message;
    ELSE

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO idSembradoP, cantidad_actual;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF cantidad_actual >= cantidad_restante THEN
            UPDATE sembradoplanta
            SET cantidad = cantidad - cantidad_restante
            WHERE idSembrado = idSembradoP AND idPlanta = NEW.idPlanta;

            SET cantidad_restante = 0;
            LEAVE read_loop;
        ELSE
            UPDATE sembradoplanta
            SET cantidad = 0
            WHERE idSembrado = idSembradoP AND idPlanta = NEW.idPlanta;

            SET cantidad_restante = cantidad_restante - cantidad_actual;
        END IF;
    END LOOP;

    CLOSE cur;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER check_ventaplanta_cantidad_update
BEFORE UPDATE ON ventaplanta
FOR EACH ROW
BEGIN
    DECLARE cantidad_total INT;
    DECLARE cantidad_restante INT DEFAULT NEW.cantidad;
    DECLARE cantidad_actual INT;
    DECLARE idSembradoP INT;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE cur CURSOR FOR
        SELECT idSembrado, cantidad
        FROM sembradoplanta
        WHERE idPlanta = NEW.idPlanta AND cantidad > 0
        ORDER BY idSembrado;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    SELECT SUM(cantidad) INTO cantidad_total
    FROM sembradoplanta
    WHERE idPlanta = NEW.idPlanta;

    IF (NEW.cantidad IS NOT NULL) AND NEW.cantidad > OLD.cantidad THEN


    IF (NEW.cantidad - OLD.cantidad > cantidad_total) THEN
        SET @error_message = CONCAT('La cantidad sembrada de la planta con identificador ', NEW.idPlanta, ' es insuficiente para la venta' );
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = @error_message;
    ELSE
    SET cantidad_restante = NEW.cantidad - OLD.cantidad;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO idSembradoP, cantidad_actual;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF cantidad_actual >= cantidad_restante THEN
            UPDATE sembradoplanta
            SET cantidad = cantidad - cantidad_restante
            WHERE idSembrado = idSembradoP AND idPlanta = NEW.idPlanta;

            SET cantidad_restante = 0;
            LEAVE read_loop;
        ELSE
            UPDATE sembradoplanta
            SET cantidad = 0
            WHERE idSembrado = idSembradoP AND idPlanta = NEW.idPlanta;

            SET cantidad_restante = cantidad_restante - cantidad_actual;
        END IF;
    END LOOP;

    CLOSE cur;
    END IF;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_preciototal_venta_insert
AFTER INSERT ON ventaplanta
FOR EACH ROW
BEGIN
  DECLARE precio_planta DECIMAL(10, 2);

  SELECT precio INTO precio_planta
  FROM planta
  WHERE idPlanta = NEW.idPlanta;


  UPDATE venta
  SET precioTotal = precioTotal + (NEW.cantidad * precio_planta)
  WHERE idVenta = NEW.idVenta;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER actualizar_preciototal_venta_update
AFTER UPDATE ON ventaplanta
FOR EACH ROW
BEGIN
  DECLARE precio_planta DECIMAL(10, 2);

  SELECT precio INTO precio_planta
  FROM planta
  WHERE idPlanta = NEW.idPlanta;


  UPDATE venta
  SET precioTotal = (precioTotal - (OLD.cantidad*precio_planta)) + (NEW.cantidad * precio_planta)
  WHERE idVenta = NEW.idVenta;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_preciototal_venta_delete
AFTER DELETE ON ventaplanta
FOR EACH ROW
BEGIN
  DECLARE precio_planta DECIMAL(10, 2);

  SELECT precio INTO precio_planta
  FROM planta
  WHERE idPlanta = OLD.idPlanta;


  UPDATE venta
  SET precioTotal = (precioTotal - (OLD.cantidad*precio_planta))
  WHERE idVenta = OLD.idVenta;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER verificar_superficie_sembrado_insert
BEFORE INSERT ON sembrado
FOR EACH ROW
BEGIN
  DECLARE sector_superficie DECIMAL(10, 2);

  SELECT superficieDisponible INTO sector_superficie
  FROM sector
  WHERE idSector = NEW.idSector;

  IF (NEW.superficie > sector_superficie) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: Superficie del sembrado excede la superficie del sector.';
  ELSE
    UPDATE sector
    SET superficieDisponible = superficieDisponible - NEW.superficie
    WHERE idSector = NEW.idSector;
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER verificar_superficie_sembrado_update
BEFORE UPDATE ON sembrado
FOR EACH ROW
BEGIN
  DECLARE sector_superficie DECIMAL(10, 2);

  SELECT superficieDisponible INTO sector_superficie
  FROM sector
  WHERE idSector = NEW.idSector;

  IF (NEW.superficie > sector_superficie + OLD.superficie) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: Superficie del sembrado excede la superficie del sector.';
  ELSE
    UPDATE sector
    SET superficieDisponible = (superficieDisponible + OLD.superficie) - NEW.superficie
    WHERE idSector = NEW.idSector;
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER reestablecer_superficie_sembrado_delete
AFTER DELETE ON sembrado
FOR EACH ROW
BEGIN
    UPDATE sector
    SET superficieDisponible = superficieDisponible + OLD.superficie
    WHERE idSector = OLD.idSector;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER verificar_estado_ventaplanta_update
BEFORE UPDATE ON ventaplanta
FOR EACH ROW
BEGIN
  DECLARE estado_venta INT;

  SELECT idEstadoVenta INTO estado_venta
  FROM venta
  WHERE idVenta = NEW.idVenta;

  IF (estado_venta = 2 OR estado_venta = 3) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: No se puede actualizar la ventaplanta. La venta asociada está en estado CANCELADO o COMPLETADO.';
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER verificar_estado_ventaplanta_delete
BEFORE DELETE ON ventaplanta
FOR EACH ROW
BEGIN
  DECLARE estado_venta INT;

  SELECT idEstadoVenta INTO estado_venta
  FROM venta
  WHERE idVenta = OLD.idVenta;

  IF (estado_venta = 2) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: No se puede eliminar la ventaplanta. La venta asociada está en estado COMPLETADO.';
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER prohibir_update_venta
BEFORE UPDATE ON venta
FOR EACH ROW
BEGIN
    IF (OLD.idEstadoVenta = 2 OR OLD.idEstadoVenta = 3) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: No se puede actualizar la venta. La venta está en estado CANCELADO o COMPLETADO.';
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER prohibir_delete_venta
BEFORE DELETE ON venta
FOR EACH ROW
BEGIN
    IF (OLD.idEstadoVenta = 2 ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: No se puede actualizar la venta. La venta está en estado COMPLETADO.';
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER prevenir_insert_sembradoplanta
BEFORE INSERT ON sembradoplanta
FOR EACH ROW
BEGIN
  DECLARE estado_sembrado INT;

  SELECT idEstadoSembrado INTO estado_sembrado
  FROM sembrado
  WHERE idSembrado = NEW.idSembrado;

  IF estado_sembrado = 4 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: No se puede insertar en la tabla sembradoplanta. El sembrado asociado está en estado "Muerto".';
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_abono_stock
AFTER INSERT ON sembradoabono
FOR EACH ROW
BEGIN
  UPDATE abono
  SET cantidadEnStock = cantidadEnStock - 1
  WHERE idAbono = NEW.idAbono;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER restaurar_abono_stock
AFTER DELETE ON sembradoabono
FOR EACH ROW
BEGIN
  UPDATE abono
  SET cantidadEnStock = cantidadEnStock + 1
  WHERE idAbono = OLD.idAbono;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_pesticida_stock
AFTER INSERT ON sembradopesticida
FOR EACH ROW
BEGIN
  UPDATE pesticida
  SET cantidadEnStock = cantidadEnStock - 1
  WHERE idPesticida = NEW.idPesticida;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER restaurar_pesticida_stock
AFTER DELETE ON sembradopesticida
FOR EACH ROW
BEGIN
  UPDATE pesticida
  SET cantidadEnStock = cantidadEnStock + 1
  WHERE idPesticida = OLD.idPesticida;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER empleadosombra_insert_trigger
AFTER INSERT ON empleado
FOR EACH ROW
BEGIN
    INSERT INTO empleadosombra(ciEmpleado, nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona, mod_usuario, mod_fecha, accion) VALUES
    (NEW.ciEmpleado, NEW.nombre, NEW.apellidoPaterno, NEW.apellidoMaterno, NEW.correo, NEW.nroCasa, NEW.telefono, NEW.idUsuario, NEW.idZona, USER(), CURRENT_TIMESTAMP(), 'I');

END //
DELIMITER ;

DELIMITER //

CREATE TRIGGER empleadosombra_update_trigger
AFTER UPDATE ON empleado
FOR EACH ROW
BEGIN
    INSERT INTO empleadosombra(ciEmpleado, nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona, mod_usuario, mod_fecha, accion) VALUES
    (NEW.ciEmpleado, NEW.nombre, NEW.apellidoPaterno, NEW.apellidoMaterno, NEW.correo, NEW.nroCasa, NEW.telefono, NEW.idUsuario, NEW.idZona, USER(), CURRENT_TIMESTAMP(), 'U');
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER empleadosombra_delete_trigger
AFTER DELETE ON empleado
FOR EACH ROW
BEGIN
    INSERT INTO empleadosombra(ciEmpleado, nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona, mod_usuario, mod_fecha, accion) VALUES
    (OLD.ciEmpleado, OLD.nombre, OLD.apellidoPaterno, OLD.apellidoMaterno, OLD.correo, OLD.nroCasa, OLD.telefono, OLD.idUsuario, OLD.idZona, USER(), CURRENT_TIMESTAMP(), 'D');
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER clientesombra_insert_trigger
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO clientesombra(ciCliente, nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona, mod_usuario, mod_fecha, accion) VALUES
    (NEW.ciCliente, NEW.nombre, NEW.apellidoPaterno, NEW.apellidoMaterno, NEW.correo, NEW.nroCasa, NEW.telefono, NEW.idUsuario, NEW.idZona, USER(), CURRENT_TIMESTAMP(), 'I');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER clientesombra_update_trigger
AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO clientesombra(ciCliente, nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona, mod_usuario, mod_fecha, accion) VALUES
    (NEW.ciCliente, NEW.nombre, NEW.apellidoPaterno, NEW.apellidoMaterno, NEW.correo, NEW.nroCasa, NEW.telefono, NEW.idUsuario, NEW.idZona, USER(), CURRENT_TIMESTAMP(), 'U');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER clientesombra_delete_trigger
AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO clientesombra(ciCliente, nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona, mod_usuario, mod_fecha, accion) VALUES
    (OLD.ciCliente, OLD.nombre, OLD.apellidoPaterno, OLD.apellidoMaterno, OLD.correo, OLD.nroCasa, OLD.telefono, OLD.idUsuario, OLD.idZona, USER(), CURRENT_TIMESTAMP(), 'D');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER sembradosombra_insert_trigger
AFTER INSERT ON sembrado
FOR EACH ROW
BEGIN
    INSERT INTO sembradosombra(idSembrado, fechaInicial, superficie, idEstadoSembrado, idSector, mod_usuario, mod_fecha, accion) VALUES
     (NEW.idSembrado, NEW.fechaInicial, NEW.superficie, NEW.idEstadoSembrado, NEW.idSector, USER(), CURRENT_TIMESTAMP(), 'I');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER sembradosombra_update_trigger
AFTER UPDATE ON sembrado
FOR EACH ROW
BEGIN
    INSERT INTO sembradosombra(idSembrado, fechaInicial, superficie, idEstadoSembrado, idSector, mod_usuario, mod_fecha, accion) VALUES
     (NEW.idSembrado, NEW.fechaInicial, NEW.superficie, NEW.idEstadoSembrado, NEW.idSector, USER(), CURRENT_TIMESTAMP(), 'U');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER sembradosombra_delete_trigger
AFTER DELETE ON sembrado
FOR EACH ROW
BEGIN
    INSERT INTO sembradosombra(idSembrado, fechaInicial, superficie, idEstadoSembrado, idSector, mod_usuario, mod_fecha, accion) VALUES
     (OLD.idSembrado, OLD.fechaInicial, OLD.superficie, OLD.idEstadoSembrado, OLD.idSector, USER(), CURRENT_TIMESTAMP(), 'D');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER ventasombra_insert_trigger
AFTER INSERT ON venta
FOR EACH ROW
BEGIN
    INSERT INTO ventasombra(idVenta, fechaVenta, precioTotal, idMetodoDePago, idEstadoVenta, ciCliente, ciEmpleado, mod_usuario, mod_fecha, accion) VALUES
     (NEW.idVenta, NEW.fechaVenta, NEW.precioTotal, NEW.idMetodoDePago, NEW.idEstadoVenta, NEW.ciCliente, NEW.ciEmpleado, USER(), CURRENT_TIMESTAMP(), 'I');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER ventasombra_update_trigger
AFTER UPDATE ON venta
FOR EACH ROW
BEGIN
    INSERT INTO ventasombra(idVenta, fechaVenta, precioTotal, idMetodoDePago, idEstadoVenta, ciCliente, ciEmpleado, mod_usuario, mod_fecha, accion) VALUES
     (NEW.idVenta, NEW.fechaVenta, NEW.precioTotal, NEW.idMetodoDePago, NEW.idEstadoVenta, NEW.ciCliente, NEW.ciEmpleado, USER(), CURRENT_TIMESTAMP(), 'U');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER ventasombra_delete_trigger
AFTER DELETE ON venta
FOR EACH ROW
BEGIN
    INSERT INTO ventasombra(idVenta, fechaVenta, precioTotal, idMetodoDePago, idEstadoVenta, ciCliente, ciEmpleado, mod_usuario, mod_fecha, accion) VALUES
     (OLD.idVenta, OLD.fechaVenta, OLD.precioTotal, OLD.idMetodoDePago, OLD.idEstadoVenta, OLD.ciCliente, OLD.ciEmpleado, USER(), CURRENT_TIMESTAMP(), 'D');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER reportesombra_insert_trigger
AFTER INSERT ON reporte
FOR EACH ROW
BEGIN
    INSERT INTO reportesombra(idReporte, titulo, contenido, fechaReporte, idTipoReporte, ciEmpleado, mod_usuario, mod_fecha, accion) VALUES
    (NEW.idReporte, NEW.titulo, NEW.contenido, NEW.fechaReporte, NEW.idTipoReporte, NEW.ciEmpleado, USER(), CURRENT_TIMESTAMP(), 'I');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER reportesombra_update_trigger
AFTER UPDATE ON reporte
FOR EACH ROW
BEGIN
    INSERT INTO reportesombra(idReporte, titulo, contenido, fechaReporte, idTipoReporte, ciEmpleado, mod_usuario, mod_fecha, accion) VALUES
    (NEW.idReporte, NEW.titulo, NEW.contenido, NEW.fechaReporte, NEW.idTipoReporte, NEW.ciEmpleado, USER(), CURRENT_TIMESTAMP(), 'U');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER reportesombra_delete_trigger
AFTER DELETE ON reporte
FOR EACH ROW
BEGIN
    INSERT INTO reportesombra(idReporte, titulo, contenido, fechaReporte, idTipoReporte, ciEmpleado, mod_usuario, mod_fecha, accion) VALUES
    (OLD.idReporte, OLD.titulo, OLD.contenido, OLD.fechaReporte, OLD.idTipoReporte, OLD.ciEmpleado, USER(), CURRENT_TIMESTAMP(), 'D');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER proveedorsombra_insert_trigger
AFTER INSERT ON proveedor
FOR EACH ROW
BEGIN
    INSERT INTO proveedorsombra(idProveedor, nombre, correo, nroCasa, telefono, idZona, mod_usuario, mod_fecha, accion) VALUES
     (NEW.idProveedor, NEW.nombre, NEW.correo, NEW.nroCasa, NEW.telefono, NEW.idZona, USER(), CURRENT_TIMESTAMP(), 'I');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER proveedorsombra_update_trigger
AFTER UPDATE ON proveedor
FOR EACH ROW
BEGIN
    INSERT INTO proveedorsombra(idProveedor, nombre, correo, nroCasa, telefono, idZona, mod_usuario, mod_fecha, accion) VALUES
     (NEW.idProveedor, NEW.nombre, NEW.correo, NEW.nroCasa, NEW.telefono, NEW.idZona, USER(), CURRENT_TIMESTAMP(), 'U');

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER proveedorsombra_delete_trigger
AFTER DELETE ON proveedor
FOR EACH ROW
BEGIN
    INSERT INTO proveedorsombra(idProveedor, nombre, correo, nroCasa, telefono, idZona, mod_usuario, mod_fecha, accion) VALUES
     (OLD.idProveedor, OLD.nombre, OLD.correo, OLD.nroCasa, OLD.telefono, OLD.idZona, USER(), CURRENT_TIMESTAMP(), 'D');

END //
DELIMITER ;

CREATE INDEX idx_sector_nombre ON sector(nombre);
CREATE INDEX idx_cliente_apellido ON cliente(apellidoPaterno, apellidoMaterno);
CREATE INDEX idx_proveedor_nombre ON proveedor(nombre);
CREATE INDEX idx_tipo_reporte ON tiporeporte(tipo);
CREATE INDEX idx_reporte_fecha ON reporte(fechaReporte);
CREATE INDEX idx_planta_nombre ON nombrecientificoplanta(nombreComun);
CREATE INDEX idx_sembrado_fecha_estado ON sembrado(fechaInicial);








INSERT INTO estadosembrado (idEstadoSembrado, estado)
VALUES
  (1, 'Saludable'),
  (2, 'Creciendo'),
  (3, 'Enfermo'),
  (4,'Muerto');


INSERT INTO marcaabono (idMarcaAbono, marca)
VALUES
  (1, 'Siaver'),
  (2, 'Biobizz'),
  (3, 'Bioptimal'),
  (4, 'Hesi'),
  (5, 'BioNova'),
  (6, 'Plagron'),
  (7,'Grotek'),
  (8,'Atami'),
  (9,'Biogreen Planet'),
  (10,'Aptus Plant Tech');


INSERT INTO tipoabono (idTipoAbono, tipo)
VALUES
  (1, 'Abono verde'),
  (2, 'Compost'),
  (3, 'Estiercol'),
  (4, 'Guano'),
  (5, 'Turba'),
  (6, 'Convencional'),
  (7, 'Liberación lenta'),
  (8, 'Específico'),
  (9, 'Organomineral'),
  (10, 'Foliar');


INSERT INTO metododepago (idMetodoDePago, metodoDePago)
VALUES
  (1, 'Efectivo'),
  (2, 'Tarjeta de crédito'),
  (3, 'PayPal'),
  (4, 'QR'),
  (5, 'Transferencia bancaria');


INSERT INTO estadoventa (idEstadoVenta, estado)
VALUES
  (1, 'Pendiente'),
  (2, 'Completada'),
  (3, 'Cancelada');


INSERT INTO tiporeporte (idTipoReporte, tipo)
VALUES
  (1, 'Producción'),
  (2, 'Ventas'),
  (3, 'Clientes'),
  (4, 'Productos'),
  (5, 'Categorías'),
  (6, 'Inventarios'),
  (7, 'Kardex Pro Productos');


INSERT INTO zona (idZona, nombre, calle)
VALUES
  (1, 'Achumani', 'Calle 25'),
  (2, 'Calacoto', 'Calle 17'),
  (3, 'Sopocachi', 'Calle 3'),
  (4, 'Miraflores', 'Calle 9'),
  (5, 'Cota Cota', 'Calle 21'),
  (6, 'Los Pinos', 'Calle 33'),
  (7, 'Obrajes', 'Calle 4'),
  (8, 'Chasquipampa', 'Calle 34'),
  (9, 'Irpavi', 'Calle 7'),
  (10, 'Ovejuyo', 'Calle 53'),
  (11, 'San Miguel', 'Calle 22'),
  (12, 'Pura pura', 'Calle 32'),
  (13, 'Següencoma', 'Calle 9'),
  (14, 'Villa Pabón', 'Calle 21'),
  (15, 'San Alberto', 'Calle 72');


INSERT INTO usuario (idUsuario, nombreUsuario, contrasena)
VALUES
  (1, 'juanperez', '123'),
  (2, 'marialopez', '321'),
  (3, 'pedrogonzales', '12345'),
  (4,'pablomotos', 'pwd234'),
  (5,'dalasazahar', 'argos23'),
  (6,'robertohernandez','holaBuenas321'),
  (7,'mauricioparedes','3672163'),
  (8,'mirandaflores','reto3332'),
  (9, 'sofiatorres', 'pwd545'),
  (10,'luisgil', 'adios8473');


INSERT INTO empleado (ciEmpleado, nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona)
VALUES
  (8657442, 'Juan', 'Pérez', 'Gómez', 'juan.perez@gmail.com', 45, '75845525', 1, 1),
  (3358445, 'María', 'López', 'García', 'maria.lopez@gmail.com', 28, '69845524', 2, 2),
  (5489554, 'Pedro', 'González', 'Rodríguez', 'pedro.gonzalez@gmail.com', 511, '75412258', 3, 3),
  (7855434, 'Pablo', 'Motos', 'Duran', 'pablo.motos@gmail.com',33, '71654332', 4, 4),
  (8322122, 'Dalas', 'Azahar', 'Blanco', 'dalas.azahar@gmail.com',133, '78965545', 5, 5);



INSERT INTO nombrecientificoplanta (idNombreCientifico, nombreCientifico, nombreComun)
VALUES
  (1, 'Chenopodium quinoa', 'Quinua'),
  (2, 'Allium cepa', 'Cebolla'),
  (3, 'Oryza sativa', 'Arroz'),
  (4, 'Solanum lycopersicum', 'Tomate'),
  (5, 'Lavandula', 'Lavanda'),
  (6, 'Orchidaceae', 'Orquídea'),
  (7, 'Papaver rhoeas','Amapola'),
  (8,'Sinapis alba','Mostazza blanca'),
  (9,'Coriandrum satiuum','Cilantro'),
  (10, 'Vitis vinifera','Parra');


INSERT INTO planta (idPlanta, descripcion, precio, idNombreCientifico)
VALUES
  (1, 'Especie de cereal resistente que produce granos pequeños y redondos en una variedad de colores', 10.99, 1),
  (2, 'Herbácea que crece en forma de bulbo subterráneo y produce hojas largas y huecas, siendo ampliamente utilizada como condimento en la cocina.', 19.99, 2),
  (3, 'Gramínea anual que crece en condiciones de humedad, produciendo espigas de granos comestibles que son un alimento básico en muchas culturas.', 5.99, 3),
  (4, 'Especie de cultivo anual que produce frutos jugosos y carnosos, conocidos por su amplia variedad de colores, formas y sabores, y utilizados en diversas preparaciones culinarias.', 39.99, 4),
  (5, 'Arbusto aromático perenne con tallos ramificados y hojas estrechas y grisáceas, conocida por sus hermosas flores moradas y su distintivo aroma relajante.', 29.99, 5),
  (6, 'Exótica y delicada flor que se caracteriza por sus llamativas y variadas formas, colores y fragancias, siendo considerada una de las joyas de la naturaleza.', 9.99, 6),
  (7, 'Flor silvestre de pétalos sedosos y vibrantes en tonos rojos, rosados o blancos, cuyas semillas son utilizadas en la cocina y la producción de aceites esenciales.', 19.99, 7),
  (8, 'Especie herbácea que produce hojas de forma ovalada y pequeñas flores blancas, cuyas semillas se utilizan en la preparación de condimentos y aderezos.', 5.99, 8),
  (9, 'Hierba aromática de hojas verdes y delicadas, con un sabor distintivo y fresco, ampliamente utilizada en la cocina para dar un toque de frescura y aroma a los platos.', 49.99, 9),
  (10, 'Vid trepadora de tallos leñosos y hojas grandes, que produce racimos de uvas jugosas y dulces, siendo cultivada tanto para la producción de vino como para el consumo de frutas frescas.', 39.99, 10);



INSERT INTO cliente (ciCliente, nombre, apellidoPaterno, apellidoMaterno, correo, nroCasa, telefono, idUsuario, idZona)
VALUES
  (842212, 'Roberto', 'Hernandez', 'Mamani', 'roberto.hernandez@gmail.com', 432, '78745514', 6, 6),
  (763344, 'Mauricio', 'Paredes', 'López', 'mauricio.paredes@gmail.com', 456, '74525498', 7, 7),
  (889965, 'Miranda', 'Flores', 'García', 'miranda.flores@gmail.com', 11, '74556631', 8, 8),
  (8332112, 'Sofia', 'Torres', 'Perez', 'sofia.torres@gmail.com', 433, '758825545', 9, 9),
  (3374588, 'Luis', 'Gil', 'Villanueva', 'luis.gil@gmail.com', 69, '76785525', 10, 10);


INSERT INTO proveedor (idProveedor, nombre, correo, nroCasa, telefono, idZona)
VALUES
  (1, 'Banferbol', 'banferbolsrl@hotmail.com', 115, '71585562', 11),
  (2, 'Arados del Oriente', 'aradosdeloriente@gmail.com', 665, '65485558', 12),
  (3, 'Fertibol', 'fertibolsrl@hotmail.com', 332, '69874415', 13),
  (4, 'Biofuel', 'biofuelbolivia@gmail.com', 12, '70578744', 14),
  (5, 'Calliope Bolivia', 'calliopebolivia@gmail.com', 46, '79514458', 15);


INSERT INTO marcapesticida (idMarcaPesticida, marca)
VALUES
  (1, 'Syngenta'),
  (2, 'Bayer'),
  (3, 'Corteva Agriscience'),
  (4, 'ADAMA'),
  (5, 'FMC Corporation'),
  (6, 'Monsanto'),
  (7, 'Nufarm'),
  (8, 'UPL Limited'),
  (9, 'Scotts Miracle-Gro'),
  (10, 'Sumitomo Chemical');


INSERT INTO tipopesticida (idTipoPesticida, tipo)
VALUES
  (1, 'Herbicida'),
  (2, 'Insecticida'),
  (3, 'Fungicida'),
  (4, 'Rodenticida'),
  (5, 'Algicida'),
  (6, 'Organofosforado'),
  (7, 'Acaricida'),
  (8, 'Glifosato'),
  (9, 'Antimicrobiano'),
  (10, 'Piretroide');



INSERT INTO pesticida (idPesticida, nombre, cantidadEnStock, idMarcaPesticida, idTipoPesticida)
VALUES
  (1, 'Ampligo', 100, 1, 2),
  (2, 'Endeavor', 50, 1, 2),
  (3, 'Buonos', 200, 2, 3),
  (4, 'Regent', 300, 2, 2),
  (5, 'Tracer', 500, 3, 2),
  (6, 'DuraCor', 100, 3, 1),
  (7, 'Agil', 200, 4, 1),
  (8, 'Agas', 200, 4, 1),
  (9, 'Takaf', 300, 5, 3),
  (10, 'Corprima', 200, 5, 3);



INSERT INTO sector (idSector, nombre, superficieDisponible)
VALUES
  (1, 'Sector A', 5000.00),
  (2, 'Sector B', 5000.00),
  (3, 'Sector C', 5000.00),
  (4, 'Sector D', 5000.00),
  (5, 'Sector E', 5000.00);



INSERT INTO sembrado (idSembrado, fechaInicial, superficie,idEstadoSembrado, idSector)
VALUES
  (1, '2023-01-17', 25.00,2, 1),
  (2, '2022-05-25', 150.00,1, 2),
  (3, '2022-11-21', 300.00,1, 3),
  (4, '2022-06-14', 250.00,3, 1),
  (5, '2022-03-05', 50.00,3, 4),
  (6, '2022-01-03', 75.00,3, 5),
  (7, '2021-05-26', 50.00,1, 1),
  (8, '2021-02-25', 60.00,1, 2),
  (9, '2019-03-18', 30.00,3, 4),
  (10, '2017-05-10', 120.00,3, 3);


  INSERT INTO venta (idVenta, fechaVenta, precioTotal, idMetodoDePago, idEstadoVenta, ciCliente, ciEmpleado)
VALUES
  (1, '2023-03-22', 0,1, 1, 842212, 8657442),
  (2, '2023-02-21', 0,2, 1, 842212, 8657442),
  (3, '2023-01-13', 0,3, 1, 842212, 3358445),
  (4, '2022-12-26', 0,4, 1, 763344, 3358445),
  (5, '2022-09-02', 0,2, 1, 763344, 3358445),
  (6, '2022-02-12', 0,3, 1, 889965, 3358445),
  (7, '2021-11-18', 0,5, 1, 889965, 5489554),
  (8, '2021-06-29', 0,1, 1, 8332112,5489554),
  (9, '2021-02-11', 0,3, 1, 8332112,7855434),
  (10, '2019-05-01', 0,4, 1, 3374588,8322122);


INSERT INTO reporte (idReporte, titulo, contenido, fechaReporte, idTipoReporte, ciEmpleado)
VALUES
  (1, 'Venta de tomates', 'Venta de tomates de la ultima decada', '2022-05-16', 2, 8657442),
  (2, 'Producción de flores', 'Análisis de la producción de flores del mes pasado', '2022-06-10', 1, 8657442),
  (3, 'Análisis de ventas mensuales', 'Informe detallado de las ventas del último mes', '2022-06-30', 2, 3358445),
  (4, 'Análisis de clientes frecuentes', 'Identificación de los clientes más frecuentes del trimestre', '2022-05-16', 3, 5489554),
  (5, 'Inventario de productos', 'Informe completo del inventario de productos actualizado', '2022-06-10', 6, 8322122);



INSERT INTO abono (idAbono, nombre, cantidadEnStock, idMarcaAbono, idTipoAbono)
VALUES
  (1, 'Premium Azul', 100, 1, 1),
  (2, 'Fertiver', 50, 1, 9),
  (3, 'BioBizz', 200, 2, 2),
  (4, 'Pre-Mix', 100, 2, 1),
  (5, 'Bio Bloom', 50, 4, 1),
  (6, 'Bio Grow', 200, 4, 3),
  (7, 'Microlife', 100, 5, 6),
  (8, 'Micromix', 300, 5, 8),
  (9, 'BcuzzSoil', 30, 7, 2),
  (10, 'Ata Terra Leaves', 100, 7, 4);


INSERT INTO sembradoabono (idSembrado, idAbono)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 5),
  (2, 2),
  (2, 7),
  (2, 8),
  (2, 9),
  (3, 5),
  (3, 6),
  (3, 7),
  (4, 1),
  (4, 9),
  (5, 2),
  (5, 7),
  (5, 8),
  (6, 4),
  (6, 7),
  (6, 8),
  (6, 5),
  (7, 3),
  (8, 4),
  (8, 2),
  (9, 9),
  (9, 10),
  (10, 1),
  (10, 4),
  (10, 5);



INSERT INTO sembradoplanta (idSembrado, idPlanta, cantidad)
VALUES
  (1, 1,300),
  (1, 3,350),
  (1, 6,400),
  (1, 9,500),
  (2, 2,600),
  (2, 3,200),
  (2, 4,200),
  (2, 8,150),
  (3, 1,300),
  (3, 2,350),
  (3, 6,450),
  (4, 5,550),
  (4, 7,400),
  (5, 9,600),
  (5, 10,200),
  (6, 3,150),
  (6, 6,100),
  (6, 7,500),
  (6, 8,600),
  (6, 10,400),
  (7, 1,300),
  (8, 3,200),
  (8, 6,200),
  (9, 7,300),
  (9, 10,300),
  (10, 1,300),
  (10, 4,105),
  (10, 9,200);


INSERT INTO ventaplanta (idVenta, idPlanta, cantidad)
VALUES
  (1, 5,1),
  (1, 7,1),
  (1, 8,1),
  (1, 10,1),
  (2, 1,2),
  (2, 3,5),
  (2, 4,5),
  (2, 7,5),
  (3, 3,10),
  (3, 6,2),
  (3, 8,2),
  (4, 2,2),
  (4, 3,2),
  (5, 4,1),
  (5, 7,1),
  (6, 3,1),
  (6, 4,1),
  (6, 7,5),
  (6, 9,5),
  (6, 10,10),
  (7, 9,15),
  (8, 3,15),
  (8, 9,15),
  (9, 2,1),
  (9, 10,1),
  (10, 1,2),
  (10, 4,3),
  (10, 9,3);


INSERT INTO proveedorabono (idProveedor, idAbono, cantidadHistorica)
VALUES
  (1, 1,400),
  (1, 4,400),
  (1, 8,400),
  (1, 10,150),
  (2, 2,600),
  (2, 7,600),
  (2, 8,600),
  (2, 9,600),
  (3, 3,600),
  (3, 6,600),
  (3, 8,350),
  (4, 4,350),
  (4, 5,350),
  (5, 6,350),
  (5, 7,350);


INSERT INTO proveedorpesticida (idProveedor, idPesticida, cantidadHistorica)
VALUES
  (1, 1,250),
  (1, 2,250),
  (1, 5,250),
  (1, 6,250),
  (2, 3,250),
  (2, 7,250),
  (2, 8,700),
  (2, 10,700),
  (3, 1,100),
  (3, 4,100),
  (3, 6,100),
  (4, 2,100),
  (4, 7,450),
  (5, 8,450),
  (5, 9,450);


INSERT INTO sembradopesticida (idSembrado, idPesticida)
VALUES
  (1, 1),
  (1, 4),
  (1, 9),
  (1, 10),
  (2, 2),
  (2, 7),
  (2, 8),
  (2, 9),
  (3, 6),
  (3, 7),
  (3, 8),
  (4, 1),
  (4, 2),
  (5, 3),
  (5, 10),
  (6, 4),
  (6, 6),
  (6, 2),
  (6, 3),
  (6, 9),
  (7, 10),
  (8, 1),
  (8, 8),
  (9, 2),
  (9, 10),
  (10, 1),
  (10, 4),
  (10, 9);



