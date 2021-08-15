-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
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
-- Выведите список товаров products и разделов catalogs, который соответствует товару.
select *
from products p 
join catalogs c on p.catalog_id = c.id 
-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.
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
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск')
;
select f.id, c.name as `from`, c2.name as `to`
from flights f 
join cities c on f.`from` = c.label
join cities c2 on f.`to` = c2.label 
order by f.id 
;
