use production;
drop trigger if exists count_store;
delimiter //
create trigger count_store before insert on store_log
for each row
begin
	update store 
	set `count` = `count` - 1
	where store.id = new.id_what_take;
end//                 -- триггер, который автоматически уменьшает колличество компонентов на складе, после того как компонент взяли

insert into store_log values (null, 1001, 1617);

use production;
drop procedure if exists null_component
delimiter //
create procedure null_component()
begin
	select id, name_of_component, component_code
	from store s 
	where `count` = 0;
end// -- процедура, которая сразу нам будет выводить компоненты, которые закончились

call null_component() 