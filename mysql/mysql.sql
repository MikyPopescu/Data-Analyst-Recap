SELECT * FROM employee_demographics;
SELECT * FROM employee_salary;
SELECT * FROM parks_departments;

# INNER JOIN
SELECT 
    d.employee_id, d.age, s.occupation
FROM 
    employee_demographics d
INNER JOIN 
    employee_salary s
ON 
    d.employee_id=s.employee_id;


# OUTER JOINS
-- LEFT  + RIGHT
SELECT 
    *
FROM 
    employee_demographics d
RIGHT JOIN 
    employee_salary s
ON 
    d.employee_id=s.employee_id
;

# SELF JOIN
SELECT 
    emp1.employee_id AS emp_santa,
    emp1.first_name AS first_name_santa,
    emp1.last_name AS last_name_santa,
    emp2.employee_id AS emp_name,
    emp2.first_name AS first_name_emp,
    emp2.last_name AS last_name_emp
FROM 
    employee_salary emp1
JOIN
    employee_salary emp2
ON 
    emp1.employee_id + 1 = emp2.employee_id;


# JOINING MULTIPLE TABLES
SELECT 
    *
FROM 
    employee_demographics d
INNER JOIN 
    employee_salary s
ON 
    d.employee_id = s.employee_id
INNER JOIN
    parks_departments p
ON
    s.dept_id = p.department_id;

# UNIONS
SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;

-- we can use UNION ALL to show all values

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, last_name, 'Old Lady' as Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Old Man'
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Highly Paid Employee'
FROM employee_salary
WHERE salary >= 70000
ORDER BY first_name
;


# String functions
SELECT LENGTH ('sky');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;

SELECT UPPER('sky');
SELECT LOWER('SKY');

SELECT first_name, upper(first_name)
FROM employee_demographics;

SELECT TRIM('    skky   ');
SELECT LTRIM('    skky  ');
SELECT RTRIM('    skky  ');

SELECT 
    first_name,
    LEFT(first_name,4), 
    RIGHT(first_name,4),
    SUBSTRING(first_name,3,2),
    birth_date,
    SUBSTRING(birth_date,6,2) birth_month
FROM employee_demographics;

SELECT 
    first_name,
    REPLACE(first_name,'a','z') -- Mzrk
FROM employee_demographics;

SELECT LOCATE ('x','Alexander'); -- poz 4

SELECT 
    first_name,
    last_name,
    CONCAT(first_name,' ',last_name) AS full_name
FROM employee_demographics;

# CASE
SELECT  
    first_name,
    last_name,
    CASE
        WHEN age<=30 THEN 'Young'
        WHEN age BETWEEN 31 AND 50 THEN 'Old'
        WHEN age >= 50 THEN 'Very old'
    END AS Age_Braket
FROM 
    employee_demographics
;


-- Pay increase and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus
SELECT 
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary < 50000 THEN salary + (salary*0.05)
        WHEN salary > 50000 THEN salary + (salary*0.07)
    END AS New_Salary,
    CASE
        WHEN dept_id = 6 THEN salary * .10
    END AS Bonus
FROM 
    employee_salary
;

-- Subqueries
-- in WHERE / SELECT /FROM
SELECT 
    *
FROM 
    employee_demographics
WHERE
    employee_id IN 
                    ( SELECT 
                           employee_id 
                      FROM 
                           employee_salary
                      WHERE
                            dept_id =1

);


SELECT 
    first_name,
    salary,
    (SELECT AVG(salary) FROM employee_salary)
FROM 
    employee_salary
;


SELECT AVG(max_age) -- , AVG(`MAX(age)`)
FROM
    (SELECT 
        gender,
        AVG(age) AS avg_age, 
        MAX(age) AS max_Age, 
        MIN(age) AS min_age, 
        COUNT(age) AS count_age
    FROM 
        employee_demographics
    GROUP BY 
        gender
    ) as agg_tbl
GROUP BY gender;

# Window functions
