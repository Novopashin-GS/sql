drop database if exists vk;
create database vk;
use vk;

drop table if exists users;
create table users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR (50),
	lastname VARCHAR (50),
	email VARCHAR (100) UNIQUE,
	password_hash VARCHAR (100),
	phone BIGINT UNSIGNED UNIQUE,
	INDEX users_firstname_lastname_idx(firstname, lastname)
);

drop table if exists profiles;
create table profiles(
	user_id BIGINT UNSIGNED NOT null UNIQUE,
	gender CHAR (1),
	birthday DATE,
	photo_id BIGINT UNSIGNED NOT null,
	created_at DATETIME DEFAULT now(),
	hometown VARCHAR (100)
);
ALTER TABLE profiles ADD CONSTRAINT fk_user_id
	FOREIGN KEY (user_id) REFERENCES users (id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT;

drop table if exists messages;
create table messages (
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT now(),
	FOREIGN KEY (from_user_id) REFERENCES users (id),
	FOREIGN KEY (to_user_id) REFERENCES users (id)
);

drop table if exists friend_requests;
create table friend_requests(
	initiator_user_id BIGINT UNSIGNED NOT NULL,
	target_user_id BIGINT UNSIGNED NOT NULL,
	`status` ENUM('requsted', 'approved', 'declined', 'unfrinded'),
	requested_at DATETIME DEFAULT now(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (initiator_user_id, target_user_id),
	FOREIGN KEY (initiator_user_id) REFERENCES users (id),
	FOREIGN KEY (target_user_id) REFERENCES users (id)
);

ALTER TABLE friend_requests 
ADD CHECK(initiator_user_id <> target_user_id);

drop table if exists comunities;
create table comunities(
	id SERIAL,
	name varchar(50),
	admin_user bigint unsigned not null,
	INDEX comunities_name_idx(name),
	FOREIGN KEY (admin_user) REFERENCES users (id)
);

drop table if exists users_comunities;
create table users_comunities(
	user_id BIGINT UNSIGNED NOT NULL,
	comunity_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, comunity_id),
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (comunity_id) REFERENCES comunities(id)
);

drop table if exists media_types;
create table media_types(
	id SERIAL, 
	name VARCHAR(255),
	created_at DATETIME DEFAULT now(),
	update_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

drop table if exists media;
create table media(
	id SERIAL,
	media_type_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	body text,
	filename varchar(255),
	`size` int,
	metadata JSON,
	created_at DATETIME DEFAULT now(),
	update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

drop table if exists likes;
create table likes(
	id SERIAL primary KEY,
	target_media_id_like BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	target_user_like BIGINT UNSIGNED NOT null,
	created_at DATETIME DEFAULT now(),
	FOREIGN KEY (target_media_id_like) REFERENCES media (id),
	FOREIGN KEY (target_user_like) REFERENCES users (id)
);

drop table if exists `photo_albums`;
create table `photo_albums`(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	name varchar(50),
	PRIMARY KEY(id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

drop table if exists `photos`;
create table `photos`(
	photo_name varchar (100),
	album_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
	FOREIGN KEY (media_id) REFERENCES media(id)
);

drop table if exists audio_recordings;
create table audio_recordings(	
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	name varchar(50),
	PRIMARY KEY(id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

drop table if exists music;
create table music (
	music_name char (100),
	audio_recordings_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT null,
	FOREIGN KEY (audio_recordings_id) REFERENCES audio_recordings(id),
	FOREIGN KEY (media_id) REFERENCES media(id)
);

ALTER TABLE likes 
ADD CONSTRAINT likes_fk_1 
FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE profiles 
ADD CONSTRAINT profiles_fk_1 
FOREIGN KEY (photo_id) REFERENCES media(id);
	
	