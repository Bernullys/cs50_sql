CREATE TABLE `Users` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    `username` VARCHAR(32) NOT NULL UNIQUE,
    `password` VARCHAR(128) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `Schools` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(128) NOT NULL UNIQUE,
    `type` ENUM('Primary', 'Secondary', 'Higher Education') NOT NULL,
    `location` VARCHAR(128) NOT NULL UNIQUE,
    `founded` YEAR NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `Companies`(
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(128) NOT NULL UNIQUE,
    `industry` ENUM('Technology', 'Education', 'Business') NOT NULL,
    `location` VARCHAR(128) NOT NULL UNIQUE,
    PRIMARY KEY(`id`)
);

-- CREATE TABLE `Connections` (

-- );

CREATE TABLE `school_connections` (
    `id` INT AUTO_INCREMENT,
    `school_id` INT NOT NULL UNIQUE,
    `alumni_id` INT NOT NULL UNIQUE,
    `start_date` DATETIME NOT NULL,
    `end_date` DATETIME,
    `degree` ENUM('BA', 'MA', 'PhD') NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`school_id`) REFERENCES `Schools`(`id`),
    FOREIGN KEY(`alumni_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE `company_connections` (
    `id` INT AUTO_INCREMENT,
    `worker_id` INT NOT NULL UNIQUE,
    `all_companies_id` INT NOT NULL UNIQUE,
    `worker_start_date` DATETIME NOT NULL,
    `worker_end_date` DATETIME,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`worker_id`) REFERENCES `Users`(`id`),
    FOREIGN KEY(`all_companies_id`) REFERENCES `Companies`(`id`)
);
