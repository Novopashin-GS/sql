create view employees_info as 
select firstname, lastname, phone, mail
from employees; -- уберем лишние данные для администраторов


create view generated_reports as 
select id_employees, `time`
from reporting_of_work; -- проверим лишь наличие отчетов