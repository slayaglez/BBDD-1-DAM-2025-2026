CREATE TABLE user(
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
verified BOOLEAN DEFAULT false,
password_hash VARCHAR(255),
id_user INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY);

CREATE TABLE blog(
title VARCHAR(255) NOT NULL,
created_in TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
id_user INT REFERENCES user(id_user),
id_blog INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY);

UPDATE usuario AS u
SET first_name = u2.first_name,
last_name = u2.last_name
FROM (VALUES
(5, 'Yasiel', 'Rebeca'),
(8, 'Alberto', 'Acevedo'),
(6, 'Juan', 'Gabriel')) AS u2(id_user, first_name, last_name)
WHERE u2.id_user = u.id_user;
