-- �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", 
-- � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".
drop function hello;
delimiter //
use vk//
create function hello ()
returns varchar (250) 
reads sql data
begin
	if (curtime() between '06:00:00' and '12:00:00') then return '������� ����';
	elseif (curtime() between '12:00:00' and '18:00:00') then return '������ ����';
	elseif (curtime() between '18:00:00' and '00:00:00') then return '������ �����';
	else return '������ ����';
	end if;
end//

delimiter ;
select hello();

-- � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. ��������� ����������� ����� ����� ��� ���� �� ���.
-- ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������.
--  ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.
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

-- (�� �������) �������� �������� ������� ��� ���������� ������������� ����� ���������.
-- ������� ��������� ���������� ������������������ � ������� ����� ����� ����� ���� ���������� �����. ����� ������� FIBONACCI(10) ������ ���������� ����� 55.
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
