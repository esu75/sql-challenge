--Module 9_ Challenge Solution


--Department table

CREATE TABLE departments(
	dept_no  VARCHAR (30) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
primary key (dept_no)
);

-- Employees table

CREATE TABLE employees(
	emp_no  INTEGER NOT NULL,
	PRIMARY KEY(emp_no),
	emp_title_id VARCHAR(10),
	birth_date DATE ,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(10) NOT NULL,
	hire_date DATE
);

--Tittles table

CREATE TABLE titles(
	title_id  VARCHAR (10) NOT NULL,
	title VARCHAR (30) NOT NULL,
PRIMARY KEY (title_id)
);


--Dept_emp table
CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL, 	--emp_no is a FOREIGN KEY for this table
	dept_no VARCHAR(10) NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


--Dept_manager table
CREATE TABLE Dept_manager(
	dept_no VARCHAR(10) NOT NULL, 	--dept_no is a FOREIGN KEY for this table 
	emp_no  INTEGER NOT NULL, 		--emp_no is a FOREIGN KEY for this table
FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--Salaries table
CREATE TABLE salaries(
	emp_no  INTEGER NOT NULL, --emp_no is a FOREIGN KEY for this table
	salary INTEGER NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);



--Analysis************************************************

--List the employee number, last name, first name, sex, and salary of each employee.
---Join salaries table with employees table:
SELECT
	e.emp_no,
	e.last_name AS "Last_Name",
	e.first_name AS "First_Name",
	e.sex AS "Sex",
	s.salary AS "Salaries"
from employees AS e
join salaries AS s
on e.emp_no = s.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT  
	first_name AS "Last_Name",
	last_name AS "First_Nmae", 
	hire_date AS "Hire_Date"
FROM employees 
WHERE extract(year from hire_date) = 1986;


--List the manager of each department along with their department number, department name,
--employee number, last name, and first name.
SELECT 
	dm.dept_no,
	dp.dept_name AS "Department_Name",
	dm.emp_no,
	e.last_name AS "Last_Name",
	e.first_name AS "First_Name"
FROM 
	Dept_manager AS dm
INNER JOIN 
	employees  AS e 
ON 
	e.emp_no = dm.emp_no
INNER JOIN 
	departments AS dp 
ON 
	dm.dept_no = dp.dept_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT 
	D.dept_no,
	D.emp_no,
	e.last_name AS "Last_Name",
	e.first_name AS "First_Name",
	dp.dept_name AS "Department_Name"
FROM 
	Dept_emp AS d
INNER JOIN 
	employees AS e ON e.emp_no = d.emp_no
INNER JOIN 
	departments AS dp 
ON 
	d.dept_no = dp.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT 
	first_name AS "Last_Name", 
	last_name AS "First_Name", 
	sex AS "Sex"
FROM 
	employees
WHERE 
	first_name = 'Hercules' 
	And last_name LIKE 'B%';

--List each employee in the , including their employee number, last name, and first name.
--*** I will do this part in two ways since the question vague
--***First method using the subquery:
SELECT 
	emp_no, 
	last_name AS "Last_Name", 
	first_name AS "First_Name"
FROM
	employees 
where 
emp_no IN (select emp_no from dept_emp where dept_no = 'd007');

--**** second method using join (innner join) and this display department name too:
																	 
SELECT 
	e.emp_no,
	e.last_name AS "Last_Name",
	e.first_name "First_Name",
	dp.dept_name AS "Department_Name"
FROM 
	employees AS e
INNER JOIN 
	dept_emp AS d
ON 
	e.emp_no = d.emp_no
INNER Join 
	departments AS dp 
ON 
	d.dept_no = dp.dept_no  
WHERE 
	dept_name = 'Sales';



--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT 
	e.emp_no,
	e.last_name AS "Last_Name",
	e.first_name AS "First_Name",
	dp.dept_name AS "Department_Name"
FROM 
	employees AS e
INNER JOIN 
	dept_emp AS d
ON 
	e.emp_no = d.emp_no
INNER Join 
	departments AS dp 
ON 
	d.dept_no = dp.dept_no  
WHERE 
	dept_name = 'Sales' OR dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT 
	last_name AS "Last_Name",count(last_name)AS "Frequency of Last_Names"
FROM employees
group by employees.last_name
order by "Frequency of Last_Names" DESC;


