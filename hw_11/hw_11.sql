-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
-- идентификатор первичного ключа и содержимое поля name.
use shop;
create table logs (
created_at datetime,
table_name varchar (50),
str_id bigint unsigned,
name varchar (50)
) engine = archive;

delimiter //
create trigger tr_users after insert on users
for each row
begin 
	insert into logs values (now(), 'users', new.id, new.name);
end//
delimiter ;
delimiter //
create trigger tr_catalogs after insert on catalogs
for each row
begin 
	insert into logs values (now(), 'catalogs', new.id, new.name);
end//
delimiter ;
delimiter //
create trigger tr_products after insert on products
for each row
begin 
	insert into logs values (now(), 'products', new.id, new.name);
end//
delimiter ;

-- В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.


SADD ip '187.171.89.249' '187.171.89.250' '187.171.89.251'
SCARD ip

-- При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
set lol@mail.ru lol 
set lol lol@mail.ru

get lol@mail.ru 
get lol

-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
db.products.insert({"name": "Intel Core i3-8100", "description": "Процессор для настольных ПК", "price": "8000.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()}) 
db.catalogs.insertMany([{"name": "Процессоры"}, {"name": "Мат.платы"}, {"name": "Видеокарты"}])

