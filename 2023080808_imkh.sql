select * from employee;
select * from department;

select emp_id, emp_name, dept_code, dept_title
from employee
join department on (dept_code = dept_id);

-- 춘대학 3-6
SELECT STUDENT_NO, STUDENT_NAME, DEPAREMENT_NAE
FROM TB_STUDENT;