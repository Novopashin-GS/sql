create view employees_info as 
select firstname, lastname, phone, mail
from employees; -- ������ ������ ������ ��� ���������������


create view generated_reports as 
select id_employees, `time`
from reporting_of_work; -- �������� ���� ������� �������