-- task1
drop database if exists test_1;
create database test_1;
use test_1;
drop table if exists users;
create table users (
id serial,
created_at datetime,
updated_at datetime
)
;
insert into test_1.users 
values 
(null, now(), now())
;
-- task2
drop database if exists test_1;
create database test_1;
use test_1;
drop table if exists users;
create table users (
id serial,
created_at varchar(50),
updated_at varchar(50)
);

insert into test_1.users
values (null,'20.10.2017 8:10','20.10.2017 8:10')
;

alter table test_1.users 
add column created_at_true datetime,
add column updated_at_true datetime
;

update test_1.users
set
created_at_true = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
updated_at_true = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i')
;

alter table test_1.users 
drop created_at,
drop updated_at,
rename column created_at_true to created_at,
rename column updated_at_true to updated_at
;


-- task3

drop database if exists test_1;
create database test_1;
use test_1;
drop table if exists users;
create table users (
id serial,
value BIGINT UNSIGNED NOT null
);
insert into test_1.users
values (1, 0),
(2, 2500),
(3, 0),
(4, 30),
(5, 25),
(6, 0),
(7, 1)
;
select id, value from test_1.users
order by case
when value = 0 then 1 
else 0
end, value
;

-- task4

use vk;
select user_id, birthday,  date_format(birthday, '%b') as mouth
from profiles
where date_format(birthday, '%m') = 05 or date_format(birthday, '%m') = 08
limit 20
;

-- task5

drop database if exists test_1;
create database test_1;
use test_1;
drop table if exists catalogs ;
create table catalogs (
id serial,
name varchar(100)
);

insert into test_1.catalogs
values (1, null),
(2, null),
(3, null),
(4, null),
(5, null),
(6, null),
(7, null)
;

SELECT * FROM catalogs
WHERE id IN (5, 1, 2)
order by case when id = 5 then 0
when id = 1 then 1
when id = 2 then 2
else 3
end
;
