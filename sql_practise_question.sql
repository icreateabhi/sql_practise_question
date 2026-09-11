use interview;

CREATE TABLE employes (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    department VARCHAR(50),
    salary INT,
    joining_date DATE,
    manager_id INT
);

INSERT INTO employes
(employee_id, employee_name, department_id, department, salary, joining_date, manager_id)
VALUES
(1,  'Rahul',   101, 'IT',       55000, '2022-01-10',  NULL),
(2,  'Amit',    101, 'IT',       70000, '2021-06-15', 1),
(3,  'Sneha',   101, 'IT',       90000, '2020-03-20', 1),
(4,  'Karan',   101, 'IT',       60000, '2023-07-01', 2),
(5,  'Priya',   102, 'HR',       50000, '2022-02-18',  NULL),
(6,  'Neha',    102, 'HR',       65000, '2021-09-12', 5),
(7,  'Megha',   102, 'HR',       72000, '2020-11-10', 5),
(8,  'Vikas',   103, 'Finance',  80000, '2020-04-18',  NULL),
(9,  'Ankit',   103, 'Finance',  60000, '2022-11-05', 8),
(10, 'Simran',  103, 'Finance',  95000, '2019-08-22', 8),
(11, 'Arjun',   103, 'Finance',  70000, '2021-01-30', 8),
(12, 'Rohit',   104, 'Sales',    45000, '2023-05-10',  NULL),
(13, 'Pooja',   104, 'Sales',    75000, '2021-03-14', 12),
(14, 'Nikhil',  104, 'Sales',    65000, '2022-12-10', 12),
(15, 'Tanya',   104, 'Sales',    85000, '2020-06-19', 12),
(16, 'Ravi',    101, 'IT',       70000, '2022-08-15', 2),
(17, 'Anjali',  102, 'HR',       65000, '2023-01-11', 6),
(18, 'Manish',  103, 'Finance',  80000, '2022-05-25', 8),
(19, 'Sakshi',  104, 'Sales',    75000, '2021-07-17', 12),
(20, 'Varun',   101, 'IT',       95000, '2019-12-01', 1);


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments
(department_id, department_name, location)
VALUES
(101, 'IT', 'Delhi'),
(102, 'HR', 'Gurgaon'),
(103, 'Finance', 'Noida'),
(104, 'Sales', 'Delhi');

select * from employes;
select * from departments;

-- Q1. Employee name aur unka department name display karo.

select employee_name,department from employes;

-- Q2. Employee name, salary aur department location display karo.
select e.employee_name, e.salary, d.location from employes e
 left join departments d
on e.department_id=d.department_id;


-- Q3. Employees jinki salary manager ki salary se greater hai.

	select e.employee_name, e.salary from employes e
	inner join employes e1
	on e.employee_id=e1.manager_id
	where e.salary>e1.salary;

-- Q4. Har department mein kitne employees hain? Department table se department name bhi display karo.
select count(e.employee_name) as employee_count,d.department_name
from employes e
right join departments d
on e.department_id=d.department_id
group by d.department_name;
select count(employee_name) as employee_count,department
from employes
group by department;


-- Q5. IT department ke employees se greater salary wale employees find karo.
select employee_name,salary,department from employes
where salary > ( select  max(salary) from employes
where department='IT');
-- Q6. Har department mein kitne employees hain?

select department,count(employee_name) from employes
group by department;

-- Q7. Har department ki average salary nikalo.

select department, round(avg(salary),0) from employes
group by department;

-- Q8. Har department ki maximum salary nikalo.

select department,max(salary) from employes
group by department;
-- Q9. Sirf woh departments nikalo jahan 4 se zyada employees hain.
select department,count(employee_name) as total_employe_count from employes
group by department
having total_employe_count>4;

-- Q10. Sirf woh departments nikalo jinki average salary 70,000 se greater hai.

select department,salary from employes
where salary > (
select avg(salary) from employes) order by salary desc;

-- Q11. Employees whose salary is greater than Rahul's salary.

select employee_name,salary from employes
where salary > (
select salary from employes
where employee_name = "Rahul");

-- Q12. Employees whose salary is greater than the company average salary.
select employee_name, salary from employes
where salary > (
select avg(salary) as avg_salary from employes);

-- Q13. Employees whose salary is greater than the average salary of their own department.
select employee_name,salary,department from employes e
where salary > (
select avg(salary) as avg_salary from employes e1
where e.department=e1.department);

-- Q14. Highest salary wale employee(s) find karo.
select employee_name, salary from employes
where salary =(
select max(salary) as highest_salary from employes);

select max(salary) as highest_salary;

-- Q15. Second-highest salary wale employee(s) find karo.
select employee_name,salary from(
select employee_name,salary,dense_rank() over(order by salary desc)as rnk from employes) x
where rnk=2;
-- Q16. CTE use karke company average se greater salary wale employees find karo.
with cte as(
select avg(salary) from employes
)
select employee_name,salary from employes
where salary>(select avg(salary) from cte);

select	 * from employes	;

select employee_name,salary from employes
order by salary desc
limit 1
offset 1;

select employee_name,salary from(
select employee_name, salary,
row_number() over(order by salary desc) as rnk
from employes) x
where rnk=1;

select employee_name,salary,department,department_rnk from(
select employee_name,salary,department,
row_number()over(partition by department order by salary desc) as department_rnk
from employes) x
where department_rnk <= 3;

select employee_name,salary,department,department_rnk from(
select employee_name,salary,department,
row_number()over(partition by department order by salary desc) as department_rnk
from employes) x
where department_rnk = 3;


-- Retrive employees working in Finance Department

select employee_name,department
from employees
where department = "Finance";
-- increase the salary by 10% of IT Department;

select * from employes;

select employee_name,salary,round(salary*1.10) AS updated_salary from employes
where Department="IT";

select * from employes where department="IT";
update employes SET salary=salary*1.10
where department="IT";

-- Find Duplicate Email from a person table
select name, email from persom
where email in(
select email,count(email) as count
from person
group by email
having count>1);

select * from(
select name,email,
row_number()over(partition by email order by name desc) as email_count);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(101, 'Rahul', 'Delhi'),
(102, 'Amit', 'Noida'),
(103, 'Priya', 'Gurgaon'),
(104, 'Neha', 'Delhi'),
(105, 'Rohit', 'Faridabad'),
(106, 'Sneha', 'Noida');
select * from customers;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    product VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    revenue DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 101, '2026-01-05', 'Laptop', 'Electronics', 1, 60000),
(2, 101, '2026-01-20', 'Mouse', 'Electronics', 2, 2000),
(3, 101, '2026-03-10', 'Keyboard', 'Electronics', 1, 3000),
(4, 101, '2026-05-15', 'Monitor', 'Electronics', 1, 15000),

(5, 102, '2026-01-12', 'Shoes', 'Fashion', 1, 4000),
(6, 102, '2026-02-18', 'T-Shirt', 'Fashion', 2, 2000),

(7, 103, '2026-01-08', 'Phone', 'Electronics', 1, 30000),
(8, 103, '2026-02-14', 'Earphones', 'Electronics', 1, 3000),
(9, 103, '2026-04-20', 'Charger', 'Electronics', 2, 2000),
(10, 103, '2026-06-05', 'Power Bank', 'Electronics', 1, 2500),

(11, 104, '2026-02-10', 'Jeans', 'Fashion', 1, 2500),
(12, 104, '2026-02-10', 'Shirt', 'Fashion', 1, 1800),

(13, 105, '2026-01-15', 'Laptop', 'Electronics', 1, 55000),
(14, 105, '2026-03-22', 'Bag', 'Fashion', 1, 3000),
(15, 105, '2026-04-12', 'Watch', 'Accessories', 1, 5000),

(16, 106, '2026-01-25', 'Headphones', 'Electronics', 1, 5000),
(17, 106, '2026-03-15', 'Shoes', 'Fashion', 1, 4500);

select * from orders;
select * from customers;
select * from orders o
join customers c
on o.customer_id=c.customer_id;

-- Find the customers whose total revenue is greater than ₹20,000.

select customer_id,sum(revenue) as revenue
from orders
group by customer_id
having revenue > 20000;

-- Find the customers who have placed at least 3 orders.
select customer_id,count(order_id) as order_count
from orders
group by customer_id
having order_count >= 3;

-- Find the customer who generated the highest total revenue.
select c.customer_name,sum(revenue) as total_revenue
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name
order by total_revenue desc
limit 1;

-- Find customers whose total revenue is greater than the average total revenue of all customers.
with total_revenue as(
select c.customer_name, sum(revenue) as t_revenue from customers c
join orders o 
on c.customer_id=o.customer_id
group by customer_name)

select customer_name,t_revenue
from total_revenue
where t_revenue>(
select avg(t_revenue) from total_revenue);

-- Find the latest order placed by each customer.
with rank_order as (
select *, row_number() over(partition by customer_id order by order_date desc ) as rnk
from orders)

select * from rank_order
where rnk=1;

-- Find all customers who have never placed any order.
select c.customer_id,c.customer_name from customers c
left join orders o
on c.customer_id=o.customer_id
where o.order_id is null;


-- Find the top 2 customers by total revenue.
select customer_id,sum(revenue) as total_revenue
from orders
group by customer_id
order by total_revenue desc;

-- Find the total revenue generated by each customer.
select c.customer_name, sum(o.revenue) as total_revenue
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name;

-- Find customers who have placed at least 3 orders.
select customer_id, count(order_id) as order_count
from orders
group by customer_id
having order_count>=3;

-- Find customers whose total revenue is greater than ₹20,000.
select c.customer_name,o.customer_id,sum(revenue) as total_revenue
from customers  c
join orders o
on o.customer_id=c.customer_id
group by c.customer_id,o.customer_id
having total_revenue > 20000;

-- Find customers who have never placed an order.
select c.customer_name from customers c
left join orders o
on c.customer_id=o.customer_id
where o.customer_id is null;

select count(customer_id) from customers;
select count(distinct customer_id) from orders;


-- Find the customer who has placed the highest number of orders.
select c.customer_name,count(o.order_id) as highest_order_count
from customers c
join orders o
on c.customer_id=o.customer_id
group by c. customer_name
order by  highest_order_count desc
limit 1;

-- Find customers whose total revenue is higher than the average revenue of all customers.
with customer_sales as(
select customer_id,sum(revenue) as total_revenue
from orders
group by customer_id
)
select customer_id,total_revenue
from customer_sales
where total_revenue>(
select avg(total_revenue) as avg_revenue
from customer_sales);

-- second-highest revenue customer
select customer_id,sum(revenue) as total_revenue
from orders
group by customer_id
order by total_revenue desc
limit 1
offset 1;

-- second-highest revenue customer
with customer_sales as(
select c.customer_name,o.customer_id,sum(revenue) as total_revenue
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name,o.customer_id),
ranked as(
select customer_id,customer_name,total_revenue,dense_rank() over(order by total_revenue desc) as rnk
from customer_sales)
select customer_name,customer_id,total_revenue
from ranked 
where rnk=2;

-- Find customers who placed orders in at least 2 different months, and show their customer name.

select c.customer_name,o.customer_id,count(distinct date_format(order_date,'%m')) as month
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name,o.customer_id
having month>=2;

-- Find the customer whose latest order was placed in 2026-05 or later.

select c.customer_name,o.customer_id,max(o.order_date)as latest_order
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name,c.customer_id
having latest_order >='2026-05-01';

-- Find customers whose total revenue is higher than their city's average customer revenue.
with customer_avg_revenue as(
select c.customer_name,c.city,sum(o.revenue) as total_revenue
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name,c.city),
city_avg as(
select city,avg(total_revenue) as city_avg 
from customer_avg_revenue
group by city)

select car.customer_name,car.total_revenue,ca.city,ca.city_avg
from customer_avg_revenue car
join city_avg ca
on car.city=ca.city
where car.total_revenue>ca.city_avg;

-- Find the customer who placed the most orders in each city.
with order_count as(
select customer_name, city,count(order_id) as order_count
from customers c
join orders o
on c.customer_id=o.customer_id
group by customer_name,city),
ranked as(
select customer_name,city, order_count,
dense_rank() over(partition by city order by order_count desc) as rnk
from order_count)

select customer_name,city,order_count
from ranked
where rnk=1;

-- Find the latest order of each customer and show:
-- customer_name,product,order_date,revenue,Clues:
with latest_order as(
select c.customer_name,o.product,o.order_date,o.revenue,
dense_rank() over(partition by o.customer_id order by o.order_date desc) as rnk
from customers c
join orders o
on c.customer_id=o.customer_id)
select customer_name,product,order_date,revenue
from latest_order
where rnk=1;


-- Find customers who placed orders in January but did not place any order in February 2026.

select c.customer_name,o.customer_id,
sum(case when month(o.order_date)=1 then 1 else 0 end) as january_count,
sum(case when month(o.order_date)=2 then 1 else 0 end) as feb_count
from customers c
join orders o 
on c.customer_id=o.customer_id
group by c.customer_name,o.customer_id
having january_count>0 and feb_count=0;












select * from orders;