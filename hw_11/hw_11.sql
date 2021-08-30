-- �������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users, catalogs � products � ������� logs ���������� ����� � ���� �������� ������, �������� �������,
-- ������������� ���������� ����� � ���������� ���� name.
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

-- � ���� ������ Redis ��������� ��������� ��� �������� ��������� � ������������ IP-�������.


SADD ip '187.171.89.249' '187.171.89.250' '187.171.89.251'
SCARD ip

-- ��� ������ ���� ������ Redis ������ ������ ������ ����� ������������ �� ������������ ������ � ��������, ����� ������������ ������ ������������ �� ��� �����.
set lol@mail.ru lol 
set lol lol@mail.ru

get lol@mail.ru 
get lol

-- ����������� �������� ��������� � �������� ������� ������� ���� ������ shop � ���� MongoDB.
db.products.insert({"name": "Intel Core i3-8100", "description": "��������� ��� ���������� ��", "price": "8000.00", "catalog_id": "����������", "created_at": new Date(), "updated_at": new Date()}) 
db.catalogs.insertMany([{"name": "����������"}, {"name": "���.�����"}, {"name": "����������"}])

