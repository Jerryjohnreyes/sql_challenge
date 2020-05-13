--1. List the following details of each employee:
--	 employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender,
	salaries.salary
FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no;

--2. List employees who were hired in 1986.
SELECT * FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3. List the manager of each department with the following information:
--	 department number, department name, the manager's employee number,
-- 	 last name, first name, and start and end employment dates.
SELECT dept_manager.dept_no,
	(SELECT departments.dept_name FROM departments
	 WHERE dept_manager.dept_no = departments.dept_no
	) AS "department_name",
	employees.emp_no, employees.last_name, employees.first_name,
	dept_manager.from_date, dept_manager.to_date
FROM dept_manager
LEFT JOIN employees
ON dept_manager.emp_no = employees.emp_no;

--4. List the department of each employee with the following information:
-- 	 employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_names.dept_name
FROM employees
JOIN (SELECT dept_emp.emp_no AS "emp_no", (SELECT departments.dept_name
			 FROM departments
			 WHERE departments.dept_no = dept_emp.dept_no
			) AS "dept_name"
	 FROM dept_emp
	) AS dept_names
ON employees.emp_no = dept_names.emp_no
ORDER BY employees.emp_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number,
--	 last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_names.dept_name
FROM employees
JOIN (SELECT dept_emp.emp_no AS "emp_no", (SELECT departments.dept_name
			 FROM departments
			 WHERE departments.dept_no = dept_emp.dept_no
			) AS "dept_name"
	 FROM dept_emp
	) AS dept_names
ON employees.emp_no = dept_names.emp_no
WHERE dept_names.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their
--	 employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_names.dept_name
FROM employees
JOIN (SELECT dept_emp.emp_no AS "emp_no", (SELECT departments.dept_name
			 FROM departments
			 WHERE departments.dept_no = dept_emp.dept_no
			) AS "dept_name"
	 FROM dept_emp
	) AS dept_names
ON employees.emp_no = dept_names.emp_no
WHERE dept_names.dept_name = 'Sales' OR dept_names.dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names
--	 i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "people_sharing"
FROM employees
GROUP BY last_name
ORDER BY "people_sharing" DESC;