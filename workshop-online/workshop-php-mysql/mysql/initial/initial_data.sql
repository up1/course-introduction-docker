USE your_database;

CREATE TABLE IF NOT EXISTS `users` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(100) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `USERNAME` (`username`)	
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

INSERT INTO `users`(`username`) VALUES('user1'),('user2'),('user3'),('user4'),('user5'),('user6'),('user7');
