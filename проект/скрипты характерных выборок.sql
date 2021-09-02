update production.messages 
set to_user_id = (select id from production.employees
	order by rand() 
	limit 1
)
where from_user_id = to_user_id ; -- ����� �� ������ ���� ����

select count(*), department_id
from production.equipment 
group by department_id; -- ����������� ������������ � �������

select count(*), id_employees 
from production.reporting_of_work 
group by id_employees; -- ����������� ������� �� ������ ������� ����������

select count(*), id_employees
from production.time_stamps 
where `datetime` between '2021-08-01' and '2021-08-31' and status = 'dinner' 
group by id_employees; -- ��������� ������� ��� ��������� ����� �� ���� �� �����

select firstname, lastname, id_what_take
from production.employees e
join production.store_log s on s.id_who_take = e.id
order by e.id; -- ��������� ���, �������, � ����� ��� ���� ��������� �� ������

select name_of_position, e.id
from production.positions p
join production.equipment e on e.department_id = p.department_id; -- ��������� ������������, ������� ����������� ������ ���������