-- task2 ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.
select count(*), to_user_id  as id_who_chatting_with_1391_user from (
(select count(*) as count_messages, from_user_id, to_user_id -- ���� ��������� 1391 ������������
from messages m 
where from_user_id = 1391
group by to_user_id 
order by count_messages desc)

union all -- �������������� �� ������ ������� ������ ������� ������� to_user_id � from_user_id, ��� ��� � ��� ��� ��������� ����������� ��������� � ����� �� ������� ������� ������������� ���� �� ������������� � �������� ������� ��� id

(select count(*) as count_messages, to_user_id, from_user_id -- ��� ��������� 1391 ������������
from messages m 
where to_user_id = 1391
group by from_user_id 
order by count_messages desc) 
) as all_messages

group by to_user_id 
order by count_messages desc
;
-- task3 ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.

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
-- task4 ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

select count(*), (select 'f') as `gender` 
from likes
where user_id in (select user_id from profiles where gender = 'f')
union
select count(*), (select 'm') as `gender`  
from likes
where user_id in (select user_id from profiles where gender = 'm') 
;

-- task5

����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����.
 
select count(*), user_id from (   -- ���������� ��������, ������� ������� ����� �������������, ������� ������ ����� ��������� ���������� � ��������� ������, ��������� ��������� ����������� ����������
	(select count(*), user_id  -- 30 �������, ������� ������ ���� ����� �������
	from photo_albums
	group by user_id
	order by count(*)
	limit 30)
	
	union all

	(select count(*), user_id  -- 30 �������, ������� ������ ���� �������
	from likes
	group by user_id
	order by count(*)
	limit 30)
	
	union all

	(select count(*), initiator_user_id -- 30 �������, ������� ������ ���� ���������� ������� � ������
	from  friend_requests
	group by initiator_user_id
	order by count(*)
	limit 30)
	
	union all

	(select count(*), from_user_id  -- 30 �������, ������� ������ ���� ���������� ���������
	from messages
	group by from_user_id 
	order by count(*) 
	limit 30)
	) as active
	
	group by user_id
	order by count(*)
	limit 10 
	
	

