drop database if exists production;

create database production;

use production;

drop table if exists employees;
create table employees(
	id serial primary key,
	firstname VARCHAR(50),
    lastname VARCHAR(50),
    mail VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100),
	phone BIGINT UNSIGNED UNIQUE,
	department_id BIGINT UNSIGNED NOT null,
	position_id BIGINT UNSIGNED NOT null,
	
	INDEX employees_firstname_lastname_idx(firstname, lastname)
	);
	
drop table if exists departments;
create table departments (
	id serial primary key,
	name_department VARCHAR(50) unique
	);

drop table if exists positions;
create table positions (
	id serial primary key,
	name_of_position VARCHAR(50) unique,
	department_id BIGINT UNSIGNED NOT null,
	
	foreign key (department_id) references departments(id)
	);
	
alter table employees add constraint employees_fk
foreign key (department_id) references departments(id)
ON UPDATE cascade;

alter table employees add constraint employees_fk1
foreign key (position_id) references positions(id)
ON UPDATE cascade;

drop table if exists messages;
create table messages (
	id SERIAL primary key,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),

    foreign key (from_user_id) REFERENCES employees(id),
    foreign key (to_user_id) REFERENCES employees(id)
);


drop table if exists store;
create table store(
	id SERIAL primary key,
	name_of_component varchar(100) unique,
	component_code BIGINT UNSIGNED NOT null unique,
	`count` int UNSIGNED not null,
	
	INDEX store_component_code_idx(component_code),
	INDEX name_of_component_idx(name_of_component)
	);

drop table if exists store_log;
create table store_log(
	id SERIAL primary key,
	id_who_take BIGINT UNSIGNED NOT null,
	id_what_take BIGINT UNSIGNED NOT null,
	
	foreign key (id_who_take) references employees(id) ON DELETE RESTRICT,
	foreign key (id_what_take) references store(id) ON update cascade,
	INDEX store_who_take_what_take_idx(id_who_take, id_what_take)
	);

drop table if exists access_rights;
create table access_rights (
	id_employees BIGINT UNSIGNED NOT null,
	service_elevator bool not null,
	`store` bool not null,
	engineering_room bool not null,
	work_this_equipment bool not null,
	
	foreign key (id_employees) references employees(id)
	);

drop table if exists time_stamps;
create table time_stamps(
	id serial primary key,
	id_employees BIGINT UNSIGNED NOT null,
	`datetime` datetime,
	`status` ENUM('arrival', 'leave', 'dinner', 'end dinner', 'business trip'),
	
	foreign key (id_employees) references employees(id),
	index id_employees_idx (id_employees)
	);

drop table if exists equipment;
create table equipment (
	id serial primary key,
	department_id BIGINT UNSIGNED NOT null,
	description text not null,
	
	foreign key (department_id) references departments(id)
	);

drop table if exists reporting_of_work;
create table reporting_of_work(
	id serial primary key,
	id_employees BIGINT UNSIGNED NOT null,
	report text not null,
	`time` datetime default now(),
	
	foreign key (id_employees) references employees(id)
	);

