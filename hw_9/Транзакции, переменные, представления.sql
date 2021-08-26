-- � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.
create table new_table
select * from shop.users u;

truncate table vk.new_table

start transaction;
insert into vk.new_table
select *
from shop.users 
where id = 1;
commit;


-- �������� �������������, ������� ������� �������� name �������� ������� �� ������� products � ��������������� �������� �������� name �� ������� catalogs.
use shop;
create view need_name as 
select p.name as name_product, c.name as name_catalog
from products p
join catalogs c on p.catalog_id = c.id;

select * from need_name;

-- �� �������) ����� ������� ������� � ����������� ����� created_at. � ��� ��������� ���������� ����������� ������ �� ������ 2018 ���� '2018-08-01', '2016-08-04',
-- '2018-08-16' � 2018-08-17. ��������� ������, ������� ������� ������ ������ ��� �� ������, ��������� � �������� ���� �������� 1, 
-- ���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.
use vk;
create table august (
`day` date);

delimiter //

use vk//

drop procedure if exists create_august//

create procedure create_august ()
begin
	declare i int default 1;
	cycle: while i < 32 do
	insert into august values (concat('2018-08-',i));
	set i = i + 1;
	end while cycle;
end//

delimiter ;

call create_august ()

create table test (
day date);

insert into test values ('2018-08-01'),
('2018-08-04'),
('2018-08-16'),
('2018-08-17');



select a.`day` as d, t.`day`,
case
when t.`day` is not null then 1
when t.`day` is null then 0
end as `true/false`
from august a 
left join test t on a.`day` = t.`day` 


-- �� �������) ����� ������� ����� ������� � ����������� ����� created_at. �������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������
delete from august
where `day` not in (select * from ( 
	select * from august a 
	order by `day` desc
	limit 5)as need_days
	)

