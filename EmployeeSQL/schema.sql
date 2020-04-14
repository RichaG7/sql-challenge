DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
);

DROP TABLE IF EXISTS dept_emp;

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE,
	to_date DATE,
	PRIMARY KEY (emp_no, dept_no, from_date, to_date)
);

DROP TABLE IF EXISTS dept_manager;

CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE,
	to_date DATE,
	PRIMARY KEY (dept_no, emp_no, from_date, to_date)
);

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE,
	PRIMARY KEY (emp_no, birth_date, first_name, last_name, gender, hire_date)
);

DROP TABLE IF EXISTS salaries;

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT,
	from_date DATE,
	to_date DATE,
	PRIMARY KEY (emp_no, salary, from_date, to_date)
);

DROP TABLE IF EXISTS titles;

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR,
	from_date DATE,
	to_date DATE,
	PRIMARY KEY (emp_no, title, from_date, to_date)
);

SELECT * FROM departments LIMIT 100;
SELECT * FROM dept_emp LIMIT 100;
SELECT * FROM dept_manager LIMIT 100;
SELECT * FROM employees LIMIT 100;
SELECT * FROM salaries LIMIT 100;
SELECT * FROM titles LIMIT 100;
