-- CODIFICAÇÃO:
-- Character set: utf8mb4
-- Collation: utf8mb4_general_ci

CREATE DATABASE plumbum;
USE plumbum;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for estudantes
-- ----------------------------
DROP TABLE IF EXISTS `estudantes`;
CREATE TABLE `estudantes`  (
  `id_estudante` int NOT NULL,
  `estud_nome` varchar(255),
  `estud_turma` int NULL DEFAULT NULL,
  `estud_qtd_txt` int NOT NULL DEFAULT 0,
  `estud_qtd_fp` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_estudante`) USING BTREE,
  INDEX `estud_turma`(`estud_turma`) USING BTREE,
  CONSTRAINT `estudantes_ibfk_1` FOREIGN KEY (`id_estudante`) REFERENCES `usuarios` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `estudantes_ibfk_2` FOREIGN KEY (`estud_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB ;

-- ----------------------------
-- Table structure for ficha_planejamento
-- ----------------------------
DROP TABLE IF EXISTS `ficha_planejamento`;
CREATE TABLE `ficha_planejamento`  (
  `id_fp` int NOT NULL AUTO_INCREMENT,
  `fp_assunto` text,
  `fp_id_tema` int NULL DEFAULT NULL,
  `fp_tema_personalizado` text ,
  `fp_flag_tema_personalizado` char(1) COMMENT 'S - Sim, N - Não',
  `fp_pc1` varchar(30),
  `fp_pc2` varchar(30),
  `fp_pc3` varchar(3),
  `fp_tese` text,
  `fp_argumentos` text,
  `fp_ideias_soltas` text ,
  `fp_flag_ideias_soltas` char(1) COMMENT 'S - Sim, N - Não',
  `fp_id_proposta_intervencao` int NOT NULL,
  `fp_correcao` int NOT NULL DEFAULT 0 COMMENT '0 - Aguardando correção, 1 - Corrigido',
  PRIMARY KEY (`id_fp`) USING BTREE,
  INDEX `fp_id_proposta_intervencao`(`fp_id_proposta_intervencao`) USING BTREE,
  INDEX `fp_id_tema`(`fp_id_tema`) USING BTREE,
  CONSTRAINT `ficha_planejamento_ibfk_1` FOREIGN KEY (`fp_id_proposta_intervencao`) REFERENCES `ficha_prop_intervencao` (`id_prop_intervencao`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ficha_planejamento_ibfk_2` FOREIGN KEY (`fp_id_tema`) REFERENCES `ficha_tema` (`id_tema`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 ;

-- ----------------------------
-- Table structure for ficha_prop_intervencao
-- ----------------------------
DROP TABLE IF EXISTS `ficha_prop_intervencao`;
CREATE TABLE `ficha_prop_intervencao`  (
  `id_prop_intervencao` int NOT NULL AUTO_INCREMENT,
  `pi_quem` text,
  `pi_como` text,
  `pi_onde` text,
  `pi_obj` text,
  PRIMARY KEY (`id_prop_intervencao`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 ;

-- ----------------------------
-- Table structure for ficha_tema
-- ----------------------------
DROP TABLE IF EXISTS `ficha_tema`;
CREATE TABLE `ficha_tema`  (
  `id_tema` int NOT NULL AUTO_INCREMENT,
  `tema` text,
  `tema_prof_vinculado` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_tema`) USING BTREE,
  INDEX `tema_prof_vinculado`(`tema_prof_vinculado`) USING BTREE,
  CONSTRAINT `ficha_tema_ibfk_1` FOREIGN KEY (`tema_prof_vinculado`) REFERENCES `professor` (`id_prof`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 ;

-- ----------------------------
-- Table structure for professor
-- ----------------------------
DROP TABLE IF EXISTS `professor`;
CREATE TABLE `professor`  (
  `id_prof` int NOT NULL,
  `prof_turma` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_prof`) USING BTREE,
  INDEX `prof_turma`(`prof_turma`) USING BTREE,
  CONSTRAINT `professor_ibfk_1` FOREIGN KEY (`id_prof`) REFERENCES `usuarios` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `professor_ibfk_2` FOREIGN KEY (`prof_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB ;

-- ----------------------------
-- Table structure for relatorios
-- ----------------------------
DROP TABLE IF EXISTS `relatorios`;
CREATE TABLE `relatorios`  (
  `int_relatorios` int NOT NULL AUTO_INCREMENT,
  `relat_date` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `relat_id_fp` int NOT NULL,
  `relat_id_txt` int NOT NULL,
  `relat_desc` text ,
  `relat_tipo` int NOT NULL DEFAULT 0 COMMENT '0 - Preliminar, 1 - Final',
  `relat_obs` text,
  PRIMARY KEY (`int_relatorios`, `relat_tipo`) USING BTREE,
  INDEX `relat_id_fp`(`relat_id_fp`) USING BTREE,
  INDEX `relat_id_txt`(`relat_id_txt`) USING BTREE,
  CONSTRAINT `relatorios_ibfk_1` FOREIGN KEY (`relat_id_fp`) REFERENCES `ficha_planejamento` (`id_fp`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `relatorios_ibfk_2` FOREIGN KEY (`relat_id_txt`) REFERENCES `texto` (`id_txt`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 ;

-- ----------------------------
-- Table structure for texto
-- ----------------------------
DROP TABLE IF EXISTS `texto`;
CREATE TABLE `texto`  (
  `id_txt` int NOT NULL AUTO_INCREMENT,
  `txt_data_criacao` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `txt_id_estud` int NOT NULL,
  `texto` text,
  `txt_id_fp` int NOT NULL,
  `txt_correcao` int NOT NULL DEFAULT 0 COMMENT '0 - Aguardando correção, 1 - Corrigido',
  PRIMARY KEY (`id_txt`) USING BTREE,
  INDEX `txt_id_user`(`txt_id_estud`) USING BTREE,
  INDEX `texto_ibfk_2`(`txt_id_fp`) USING BTREE,
  CONSTRAINT `texto_ibfk_1` FOREIGN KEY (`txt_id_estud`) REFERENCES `estudantes` (`id_estudante`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `texto_ibfk_2` FOREIGN KEY (`txt_id_fp`) REFERENCES `ficha_planejamento` (`id_fp`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 ;

-- ----------------------------
-- Table structure for turmas
-- ----------------------------
DROP TABLE IF EXISTS `turmas`;
CREATE TABLE `turmas`  (
  `id_turma` int NOT NULL AUTO_INCREMENT,
  `turma_data_cadastro` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `turma_ano_letivo` int NOT NULL,
  `turma_ensino` char(1) COMMENT 'F - Fundamental, M - Médio, T - Técnico, S - Superior',
  `turma_ano` int NULL DEFAULT NULL COMMENT '7º ano, 8º ano. . . (informar apenas o ano)',
  `turma_semestre` int NULL DEFAULT NULL COMMENT 'Para turmas de Ensino Técnico ou Superior (colocar apenas o número do semestre)',
  `turma_obs` text ,
  PRIMARY KEY (`id_turma`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 ;

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios`  (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `user_dtcadastro` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `user_nome` varchar(255),
  `user_email` varchar(255),
  `user_senha` varchar(255),
  `user_tipo` char(1) COMMENT 'A - Administrador, E - Estudante, P - Professor',
  PRIMARY KEY (`id_user`) USING BTREE,
  UNIQUE INDEX `id_user_UNIQUE`(`id_user`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 ;

-- ----------------------------
-- Table structure for vinculo_tema_prof
-- ----------------------------
DROP TABLE IF EXISTS `vinculo_tema_prof`;
CREATE TABLE `vinculo_tema_prof`  (
  `id_tema` int NOT NULL,
  `tema_professor` int NOT NULL,
  `vinculo_dtcriacao` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id_tema`, `tema_professor`) USING BTREE,
  INDEX `tema_professor`(`tema_professor`) USING BTREE,
  CONSTRAINT `vinculo_tema_prof_ibfk_1` FOREIGN KEY (`id_tema`) REFERENCES `ficha_tema` (`id_tema`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `vinculo_tema_prof_ibfk_2` FOREIGN KEY (`tema_professor`) REFERENCES `professor` (`id_prof`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB ;

-- ----------------------------
-- Triggers structure for table usuarios
-- ----------------------------
DROP TRIGGER IF EXISTS `usuarios_AFTER_INSERT`;
delimiter ;;
CREATE TRIGGER `usuarios_AFTER_INSERT` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
	IF new.user_tipo = "E" THEN 
		INSERT INTO estudantes(id_estudante, estud_nome) VALUES
		(new.id_user, new.user_nome) ;
	ELSE IF new.user_tipo = "P" THEN 
		INSERT INTO professor(id_prof) VALUES
		(new.id_user) ;
        END IF;
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
