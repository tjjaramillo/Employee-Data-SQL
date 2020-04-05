---List the following details of each employee: employee number, 
---last name, first name, gender, and salary.

DROP VIEW employee_info;

CREATE VIEW employee_info AS
	SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
	FROM employees AS e
	INNER JOIN salaries AS s ON
	s.emp_no=e.emp_no
	ORDER BY "emp_no";
	
SELECT * FROM employee_info;
--------------------------------------
---List employees who were hired in 1986.

DROP VIEW hired_1986;

CREATE VIEW hired_1986 AS
	SELECT first_name, last_name, hire_date
	FROM employees
	WHERE hire_date
	BETWEEN '1986-01-01' AND '1986-12-31'
	ORDER BY hire_date;
	
SELECT * FROM hired_1986;
---------------------------------------
---List the manager of each department with the following information: department number,
---department name, the manager's employee number, last name, first name, and start and
---end employment dates.
DROP VIEW department_manager_info;

CREATE VIEW department_manager_info AS
	SELECT d.dept_no,n.dept_name, d.emp_no, e.first_name, e.last_name, d.from_date, d.to_date
	FROM dept_manager AS d
	INNER JOIN departments AS n ON
	n.dept_no=d.dept_no
	INNER JOIN employees AS e ON
	e.emp_no=d.emp_no;

SELECT * FROM department_manager_info;
-------------------------------------------
---List the department of each employee with the following information: employee number,
---last name, first name, and department name.
DROP VIEW employee_department_info;

CREATE VIEW employee_department_info AS
	SELECT d.emp_no, e.last_name, e.first_name, n.dept_name
	FROM dept_emp AS d
	INNER JOIN employees AS e ON
	e.emp_no=d.emp_no
	INNER JOIN departments AS n ON
	n.dept_no=d.dept_no
	ORDER BY emp_no;
	
SELECT * FROM employee_department_info;
-------------------------------------------
---List all employees whose first name is "Hercules" and last names begin with "B."

DROP VIEW hercules;

CREATE VIEW hercules AS
	SELECT first_name, last_name
	FROM employees
	WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%'
	ORDER BY last_name;
	
SELECT * FROM hercules;
-------------------------------------------
---List all employees in the Sales department, including their employee number, last name, first
---name, and department name.
DROP VIEW sales_department;

CREATE VIEW sales_department AS
	SELECT d.emp_no, e.last_name, e.first_name, n.dept_name
	FROM dept_emp AS d
	INNER JOIN employees AS e ON
	d.emp_no=e.emp_no
	INNER JOIN departments AS n ON
	d.dept_no=n.dept_no
	WHERE d.dept_no IN
	(
		SELECT dept_no FROM departments
		WHERE dept_name = 'Sales'
	)
	ORDER BY emp_no;

SELECT * FROM sales_department;
-------------------------------------------
---List all employees in the Sales and Development departments, including their employee
---number, last name, first name, and department name.

DROP VIEW sales_and_development;

CREATE VIEW sales_and_development AS
	SELECT d.emp_no, e.last_name, e.first_name, n.dept_name
	FROM dept_emp AS d
	INNER JOIN employees AS e ON
	d.emp_no=e.emp_no
	INNER JOIN departments AS n ON
	d.dept_no=n.dept_no
	WHERE d.dept_no IN
	(
		SELECT dept_no FROM departments
		WHERE dept_name = 'Sales'
		OR dept_name = 'Development'
	)
	ORDER BY dept_name;

SELECT * FROM sales_and_development;
-------------------------------------------
---In descending order, list the frequency count of employee last names, i.e., 
---how many employees share each last name.

DROP VIEW last_name_count;

CREATE VIEW last_name_count AS
	SELECT last_name, COUNT(last_name) AS last_name_count
	FROM employees
	GROUP BY last_name
	ORDER BY last_name_count DESC;

SELECT * FROM last_name_count;
