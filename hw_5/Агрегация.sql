-- task 1 
use vk;
select round(AVG(TIMESTAMPDIFF(year, birthday, now()))) as age
from profiles


-- task 2
use vk;
select count(*), dayname(concat(year(now()), '-', substring(birthday, 6, 10))) as birhday_day 
from profiles
group by birhday_day
order by count(*) desc
;

-- task 3
drop database if exists test_1;
create database test_1;
use test_1;
drop table if exists test;
create table test (
value BIGINT UNSIGNED NOT null
);

insert into test_1.test
values (1),
(2),
(3),
(4),
(5)
;

select exp(sum(ln(value))) as `result`
from test
;