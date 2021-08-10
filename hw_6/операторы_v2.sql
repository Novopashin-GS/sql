-- task2 Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
select count(*), to_user_id  as id_who_chatting_with_1391_user from (
(select count(*) as count_messages, from_user_id, to_user_id -- кому отправлял 1391 пользователь
from messages m 
where from_user_id = 1391
group by to_user_id 
order by count_messages desc)

union all -- предварительно во второй таблице меняем местами столбцы to_user_id и from_user_id, так как в ней уже посчитано колличество сообщений и можно во внешнем запросе сгруппировать лишь по пользователям с которыми общался наш id

(select count(*) as count_messages, to_user_id, from_user_id -- кто отправлял 1391 пользователю
from messages m 
where to_user_id = 1391
group by from_user_id 
order by count_messages desc) 
) as all_messages

group by to_user_id 
order by count_messages desc
;
-- task3 Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

select count(*), user_id
from likes
where user_id in 
(select user_id from 
		(select * from profiles
		order by birthday desc
		limit 10
		 ) as ten_young
)
group by user_id 
;
-- task4 Определить кто больше поставил лайков (всего) - мужчины или женщины?

select count(*), (select 'f') as `gender` 
from likes
where user_id in (select user_id from profiles where gender = 'f')
union
select count(*), (select 'm') as `gender`  
from likes
where user_id in (select user_id from profiles where gender = 'm') 
;

-- task5

Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
 
select count(*), user_id from (   -- сформируем табличку, которая соберет таких пользователей, которые меньше всего проявляли активность в различных сферах, посчитаем суммарное колличество активности
	(select count(*), user_id  -- 30 человек, которые меньше всех имеют альбомы
	from photo_albums
	group by user_id
	order by count(*)
	limit 30)
	
	union all

	(select count(*), user_id  -- 30 человек, которые меньше всех лайкали
	from likes
	group by user_id
	order by count(*)
	limit 30)
	
	union all

	(select count(*), initiator_user_id -- 30 человек, которые меньше всех отправляли запросы в друзья
	from  friend_requests
	group by initiator_user_id
	order by count(*)
	limit 30)
	
	union all

	(select count(*), from_user_id  -- 30 человек, которые меньше всех отправляли сообщения
	from messages
	group by from_user_id 
	order by count(*) 
	limit 30)
	) as active
	
	group by user_id
	order by count(*)
	limit 10 
	
	

