--Deliverable 1 query code
--retrieve the emp_no, first_name, last_name, columns from employees table
--retrieve the title, to_date, from_date from titles table
SELECT e.emp_no, e.first_name, e.last_name, t.from_date, t.to_date, t.title
INTO employee_titles
FROM employees as e
    INNER JOIN titles as t
    ON (e.emp_no = t.emp_no)
--filter only those who were born between 1952-1955
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--order by employee number, descending
ORDER BY e.emp_no DESC;

-- Use Dictinct with Orderby to remove duplicate rows
--i don't know if this code will work, check distinct on documentation
--retrieve employee number, first and last name, and title from employee titles table
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
FROM employee_titles
--create a new table with the duplicates deleted out
INTO unique_titles
--exclude those who have already left the company
WHERE (to_date == '9999-01-01')
--ORDER BY emp_no ascending, to_date descending
ORDER BY emp_no ASC, to_date DESC;

--retrieve number of employees by most recent job title who are retiring
--figure out how to save this into a new table
SELECT COUNT(title), title FROM employee_titles
INTO retiring_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

--mentorship eligibility
--select the appropriate columns from employees, dept_emp, and titles tables
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date , de.from_date, de.to_date, t.title
--create a new table
INTO mentorship_eligibility
FROM employees as e
    INNER JOIN dept_emp as de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles as t
        ON (e.emp_no = t.emp_no)
--filter by current employees
WHERE (de.to_date = '9999-01-01')
--only select employees born in 1965
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
--order by employee number
ORDER BY e.emp_no ASC;