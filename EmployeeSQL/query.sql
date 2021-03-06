--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
CREATE OR REPLACE VIEW emp_details AS
SELECT emp_no, last_name, first_name, gender, (
	SELECT salary
	FROM salaries
	WHERE employees.emp_no = salaries.emp_no)
FROM employees;

SELECT * FROM emp_details LIMIT 100;

--2. List employees who were hired in 1986.
CREATE OR REPLACE VIEW emp_1986 AS
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE hire_date between '1986-01-01' and '1986-12-31';

SELECT * FROM emp_1986 LIMIT 100;

--3. List the manager of each department with the following information: 
--department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.
CREATE OR REPLACE VIEW manager AS
SELECT (
	SELECT dept_no
	FROM departments
	WHERE dept_manager.dept_no = departments.dept_no), (
	SELECT dept_name
	FROM departments
	WHERE dept_manager.dept_no = departments.dept_no), 
	emp_no, (
	SELECT first_name
	FROM employees
	WHERE dept_manager.emp_no = employees.emp_no), (
	SELECT last_name
	FROM employees
	WHERE dept_manager.emp_no = employees.emp_no)
	from_date, 
	to_date
FROM dept_manager;

SELECT * FROM manager LIMIT 100;

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
CREATE OR REPLACE VIEW dept_emp_full AS
SELECT emp_no, (
	SELECT last_name
	FROM employees
	WHERE dept_emp.emp_no = employees.emp_no), (
	SELECT first_name
	FROM employees
	WHERE dept_emp.emp_no = employees.emp_no), (
	SELECT dept_name
	FROM departments
	WHERE dept_emp.dept_no = departments.dept_no)
FROM dept_emp;

SELECT * FROM dept_emp_full LIMIT 100;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
CREATE OR REPLACE VIEW hercules AS
SELECT first_name, last_name
FROM employees
WHERE first_name='Hercules' AND last_name LIKE 'B%';

SELECT * FROM hercules LIMIT 100;

--6. List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
CREATE OR REPLACE VIEW sales_emp AS
SELECT emp_no, last_name, first_name, (
	SELECT dept_name
	FROM departments
	WHERE dept_name = 'Sales')
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN (
		SELECT dept_no
		FROM departments
		WHERE dept_name='Sales'));

SELECT * FROM sales_emp LIMIT 100;

--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
CREATE OR REPLACE VIEW sales_dev_emp AS
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN (
		SELECT dept_no
		FROM departments
		WHERE dept_name IN ('Sales', 'Development')));

SELECT * FROM sales_dev_emp LIMIT 100;

CREATE OR REPLACE VIEW sales_dev_emp_final AS
SELECT emp_no, last_name, first_name, string_agg(
	(SELECT string_agg(dept_name, ',')
	FROM departments JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
	WHERE sales_dev_emp.emp_no = dept_emp.emp_no)::text, ',') AS dept_name
FROM sales_dev_emp
GROUP BY emp_no, last_name, first_name;

SELECT * FROM sales_dev_emp_final LIMIT 100;

--8. In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
CREATE OR REPLACE VIEW last_name_count AS
SELECT last_name, COUNT(last_name) as last_name_count
FROM employees
GROUP BY last_name
ORDER by last_name_count desc;

SELECT * FROM last_name_count LIMIT 100;



