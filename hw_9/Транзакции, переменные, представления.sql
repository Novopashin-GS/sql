-- ¬ базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. ѕереместите запись id = 1 из таблицы shop.users в таблицу sample.users. »спользуйте транзакции.
create table new_table
select * from shop.users u;

truncate table vk.new_table

start transaction;
insert into vk.new_table
select *
from shop.users 
where id = 1;
commit;


-- —оздайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
use shop;
create view need_name as 
select p.name as name_product, c.name as name_catalog
from products p
join catalogs c on p.catalog_id = c.id;

select * from need_name;

-- по желанию) ѕусть имеетс€ таблица с календарным полем created_at. ¬ ней размещены разр€женые календарные записи за август 2018 года '2018-08-01', '2016-08-04',
-- '2018-08-16' и 2018-08-17. —оставьте запрос, который выводит полный список дат за август, выставл€€ в соседнем поле значение 1, 
-- если дата присутствует в исходном таблице и 0, если она отсутствует.
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


-- по желанию) ѕусть имеетс€ люба€ таблица с календарным полем created_at. —оздайте запрос, который удал€ет устаревшие записи из таблицы, оставл€€ только 5 самых свежих записей
delete from august
where `day` not in (select * from ( 
	select * from august a 
	order by `day` desc
	limit 5)as need_days
	)

