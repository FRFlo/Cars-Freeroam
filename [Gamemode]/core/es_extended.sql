CREATE TABLE `users` (
	`identifier` VARCHAR(60) NOT NULL,
	`group` VARCHAR(50) NULL DEFAULT 'user',
	`team` VARCHAR(20) NULL DEFAULT 'wilderness',
	`team_grade` INT NULL DEFAULT 0,

	PRIMARY KEY (`identifier`)
);

CREATE TABLE `team_grades` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`team_name` VARCHAR(50) DEFAULT NULL,
	`grade` INT NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`label` VARCHAR(50) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `team_grades` VALUES (1,'wilderness',0,'wilderness','Joueur');

CREATE TABLE `teams` (
	`name` VARCHAR(50) NOT NULL,
	`label` VARCHAR(50) DEFAULT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `teams` VALUES ('wilderness','Aucune');
