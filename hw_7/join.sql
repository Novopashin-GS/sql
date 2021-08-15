-- ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.
insert into orders values 
(null,2,now(),now()),
(null,3,now(),now()),
(null,4,now(),now()),
(null,2,now(),now())
;
select count(*), name
from users u 
join orders o on u.id = o.user_id 
group by u.id
;
-- �������� ������ ������� products � �������� catalogs, ������� ������������� ������.
select *
from products p 
join catalogs c on p.catalog_id = c.id 
-- (�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). 
-- ���� from, to � label �������� ���������� �������� �������, ���� name � �������. 
-- �������� ������ ������ flights � �������� ���������� �������.
create table flights
(id serial primary key,
`from` varchar(50),
`to` varchar(50)
)
;
create table cities
(label varchar(50),
name varchar(50)
)
;
insert into flights values
(null, 'moscow', 'omsk'),
(null, 'novgorod', 'kazan'),
(null, 'irkutsk', 'moscow'),
(null, 'omsk', 'irkutsk'),
(null, 'moscow', 'kazan')
;
insert into cities values
('moscow', '������'),
('irkutsk', '�������'),
('novgorod', '��������'),
('kazan', '������'),
('omsk', '����')
;
select f.id, c.name as `from`, c2.name as `to`
from flights f 
join cities c on f.`from` = c.label
join cities c2 on f.`to` = c2.label 
order by f.id 
;
