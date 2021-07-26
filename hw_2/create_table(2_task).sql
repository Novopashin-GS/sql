drop database if exists example; -- запустить через source create_table.sql
create database example;
use example;
create table users (id serial, name varchar(100) not null);
