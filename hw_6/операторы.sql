-- task2
select count(*) as count_messages, from_user_id, to_user_id
from messages m 
where from_user_id = 1391 or to_user_id = 1391
group by to_user_id, from_user_id 
order by count_messages desc
;

-- task3

select count(*), user_id
from likes
where user_id in ( select user_id
from profiles
order by birthday desc
limit 10
)
group by user_id 
;

-- task4

select count(*), (select 'f') as `gender` 
from likes
where user_id in (select user_id from profiles where gender = 'f')
union
select count(*), (select 'm') as `gender`  
from likes
where user_id in (select user_id from profiles where gender = 'm') 
;

-- task5

Ќайти 10 пользователей, которые про€вл€ют наименьшую активность в использовании социальной сети.
 
select count(*), user_id 
from photo_albums
group by user_id
order by count(*)
limit 10
;

select count(*), user_id 
from likes
group by user_id
order by count(*)
limit 10
;

(select count(*), initiator_user_id
from  friend_requests
group by initiator_user_id
order by count(*)
limit 10)
;

(select count(*), from_user_id 
from messages
group by from_user_id 
order by count(*) 
limit 10) 
;

