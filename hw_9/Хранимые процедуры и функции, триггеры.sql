-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
drop function hello;
delimiter //
use vk//
create function hello ()
returns varchar (250) 
reads sql data
begin
	if (curtime() between '06:00:00' and '12:00:00') then return 'Доборое утро';
	elseif (curtime() between '12:00:00' and '18:00:00') then return 'Добрый день';
	elseif (curtime() between '18:00:00' and '00:00:00') then return 'Добрый вечер';
	else return 'Доброй ночи';
	end if;
end//

delimiter ;
select hello();

-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них.
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
--  При попытке присвоить полям NULL-значение необходимо отменить операцию.
use shop;
delimiter //
create trigger null_one_or_all before insert on products
for each row 
begin 
	if (isnull(new.name) and isnull(new.desription)) 
	then signal sqlstate '45000' set MESSAGE_TEXT = 'null string';
	elseif (isnull(new.name)) then set new.name = 'name';
	elseif (isnull(new.desription)) then set new.desription = 'description';
	end if;
end//

delimiter ;

-- (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
delimiter //
create function FIBONACCI (`number` int)
returns int
reads sql data
begin
	declare i int default 0;
	declare x int default 0;
	cycle: while i <= `number` do
	set x = x + i; 
	set i = i + 1;
	end while cycle;
return x;
end//

select FIBONACCI (10)
