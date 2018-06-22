DELIMITER //
CREATE PROCEDURE PROC_insereHistoria (IN tit VARCHAR(50), IN clas ENUM('L', '14', '16', '18'), IN sinp TINYTEXT, IN aut BIGINT)
BEGIN
	INSERT INTO historia (titulo, class_ind, sinopse, autor)
	VALUES (tit, clas, sinp, aut);
END//
DELIMITER ;	

CALL PROC_insereHistoria ('A Pedra que fazia Plim', 'L', 'Plim é um estilo de vida', 3);

DELIMITER //
CREATE PROCEDURE PROC_insereCategoriaHistoria (IN id_h BIGINT, IN id_c INT)
	BEGIN
	INSERT INTO HISTORIA_CATEGORIA (id_historia, id_categoria)
	VALUES (id_h, id_c);
	END//
DELIMITER ;

CALL PROC_insereCategoriaHistoria (4, 7);
CALL PROC_insereCategoriaHistoria (4, 3);

DELIMITER //
CREATE PROCEDURE PROC_insereCapitulo (IN id_h BIGINT, IN tit_c VARCHAR(70))
BEGIN
	INSERT INTO capitulo (id_historia, titulo_cap)
	VALUES (id_h, tit_c);
END//
DELIMITER ;

CALL PROC_insereCapitulo (4, 'A volta dos que nÃ£o foram');

DELIMITER //
CREATE PROCEDURE PROC_removeCapitulo (id_cap BIGINT)
BEGIN
	DELETE FROM capitulo
	WHERE id = id_cap;
END//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE PROC_removeTodosCapitulos (id_h BIGINT)
BEGIN
	DELETE FROM capitulo
	WHERE id_historia = id_h;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PROC_removeHistoria (id_h BIGINT)
BEGIN
	CALL PROC_removeTodosCapitulos (id_h);
	DELETE FROM HISTORIA_CATEGORIA
	WHERE id_historia = id_h;
	DELETE FROM historia
	WHERE id = id_h;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PROC_loginUsuario (cpf_u BIGINT, sen_u VARCHAR(20))
BEGIN
	SELECT id, cpf, senha FROM usuario
	WHERE cpf = cpf_u AND senha = sen_u;
END//
DELIMITER;

SELECT * FROM usuario;

SHOW CREATE TABLE usuario;

CALL PROC_loginUsuario (44252753813, 'Latido123');

DELIMITER //
CREATE PROCEDURE PROC_alterarEmailUsuario (id_u BIGINT, IN mail VARCHAR(100))
BEGIN
	UPDATE usuario
	SET email = mail
	WHERE id = id_u;
END//
DELIMITER ;

CALL PROC_alterarEmailUsuario (1, 'sacportalvendas@gmail.com');

DELIMITER //
CREATE PROCEDURE PROC_alterarSenhaUsuario (id_u BIGINT, IN sen VARCHAR(20))
BEGIN
	UPDATE usuario
	SET senha = sen
	WHERE id = id_u;
END//
DELIMITER ;

CALL PROC_alterarSenhaUsuario (3, '123arrozdoce');

DELIMITER //
CREATE PROCEDURE PROC_removeUsuario (id_u BIGINT)
BEGIN
	DELETE FROM capitulo
	WHERE id_historia in (SELECT id FROM historia WHERE autor = id_u);
	DELETE FROM historia_categoria
	WHERE id_historia in (SELECT id FROM historia WHERE autor = id_u);
	DELETE FROM historia
	WHERE autor = id_u;
	DELETE FROM usuario WHERE id = id_u;
END //
DELIMITER;

SELECT * FROM usuario;

DELIMITER //
CREATE PROCEDURE PROC_baneUsuario (IN id_u BIGINT, IN nome_u VARCHAR(70), IN cpf_u BIGINT)
BEGIN
	INSERT INTO ban (id, nome_usuario, cpf_usuario)
	VALUES (id_u, nome_u, cpf_u);
END//
DELIMITER ;

-- SUPER USUÁRIO: BANIMENTO
-- PROCEDURE PARA BUSCAR USUÁRIO POR CPF
-- PROCEDURE PARA INSERÇÃO NA TABELA DE BAN

DELIMITER //
CREATE PROCEDURE PROC_buscaUsuario (cpf_i BIGINT)
BEGIN
	SELECT * FROM usuario
	WHERE cpf = cpf_i;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PROC_exibirHistoria (id_h INT)
BEGIN
	SELECT * FROM historia
	WHERE id = id_h;
END//
DELIMITER ;

CALL PROC_exibirHistoria (2);

DELIMITER //
CREATE PROCEDURE PROC_listarHistoriaNome (HIS VARCHAR(50))
BEGIN
	SELECT H.id AS 'ID_Historia', H.titulo AS 'Titulo_historia' FROM historia AS H
	WHERE H.titulo LIKE HIS
	ORDER BY H.titulo;
END//
DELIMITER ;

CALL PROC_listarHistoriaNome ('%a lenda%');

DELIMITER //
CREATE PROCEDURE PROC_listarHistoriaCategoria (CAT BIGINT)
BEGIN
	SELECT H.id AS 'ID_historia', H.titulo AS 'Titulo_historia' FROM historia AS H
	INNER JOIN HISTORIA_CATEGORIA AS HC ON H.id = HC.id_historia
	WHERE HC.id_categoria = CAT
	ORDER BY H.titulo;
END//
DELIMITER ;

CALL PROC_listarHistoriaCategoria (3);

DELIMITER //
CREATE PROCEDURE PROC_removerCategoriaHistoria (id_h BIGINT, id_c INT)
BEGIN
 	DELETE FROM HISTORIA_CATEGORIA
	WHERE id_historia = id_h
	AND id_categoria = id_c;
END//
DELIMITER ;

CALL PROC_removerCategoriaHistoria (4, 7);

DELIMITER //
CREATE PROCEDURE PROC_listarCategorias ()
BEGIN
	SELECT * FROM categoria AS C
	ORDER BY C.categoria;
END //
DELIMITER ;

CALL PROC_listarCategorias;

CREATE PROCEDURE PROC_alteraCategoria (id_cat INT, IN cat VARCHAR(50))
BEGIN
	UPDATE categoria
	SET categoria = cat
	WHERE id = id_cat;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PROC_listarCapitulos (HIS BIGINT)
	BEGIN
		SELECT C.id AS 'ID_Capitulo', C.titulo_cap AS 'Titulo_Capitulo' FROM capitulo AS C
		INNER JOIN historia AS H ON C.id_historia = H.ID
		WHERE H.id = HIS
		ORDER BY C.id;
	END//
DELIMITER ;

CALL PROC_listarCapitulos (1);

SELECT * FROM CAPITULO;

INSERT INTO capitulo (id_historia, titulo_cap, contador)
VALUES
(1, 'O prÃ­ncipe perdido', 2),
(1, 'A caÃ§adora', 3),
(1, 'FiÃ©is mercenÃ¡rios', 5),
(1, 'Em busca da verdade', 4);

DELIMITER //
CREATE PROCEDURE PROC_listarCapitulos (HIS BIGINT)
	BEGIN
		SELECT C.id AS 'ID_Capitulo', C.contador AS 'Numero_Capitulo', C.titulo_cap AS 'Titulo_Capitulo' FROM capitulo AS C
		INNER JOIN historia AS H ON C.id_historia = H.ID
		WHERE H.id = HIS
		ORDER BY C.contador;
	END//
DELIMITER ;

CALL PROC_listarCapitulos (1);

DROP PROCEDURE PROC_listarCapitulos;

SELECT * FROM capitulo;

SELECT * FROM usuario;

INSERT INTO capitulo (id_historia, titulo_cap, contador)
VALUES
(1, 'TraiÃ§Ã£o', 8);

DELETE FROM capitulo WHERE id = 7;

SELECT * FROM capitulo
WHERE id_historia = 1 
ORDER BY id;

ALTER TABLE capitulo DROP contador;

SELECT * FROM capitulo
WHERE id_historia = 1;