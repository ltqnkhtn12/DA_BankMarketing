use BANK_MARKETING

select * from bank_marketing

-- Count the number of customers by profession.
select job, count(*) as Count_of_Customers_by_jobs
from bank_marketing
group by job

-- Count the number of customers by marital status.
select marital, count (*) as Count_of_Customers_by_marital
from bank_marketing
group by marital

-- Count the number of customers by education.
select education, count (*) as Count_of_Customers_by_education
from bank_marketing
group by education


-- Calculate the percentage of customers with default credit.
select "default", count(*) as Count_of_Customets_by_dafault, ROUND((count(*) * 100) / (select count(*) from bank_marketing),2) as Default_Percentage
from bank_marketing
group by "default"

-- Calculate the average age of customers by marital status.
select marital, AVG(age) as Average_age_of_Customers_by_marital
from bank_marketing
group by marital

-- Calculate the average age of customers by prodfession.
select job, AVG(age) as Average_age_of_Customers_by_jobs
from bank_marketing
group by job

-- Calculate the average age of customers by the type of product they have registered for (term deposit, personal loan).
select product_type, AVG(age) as average_age
from 
	(
	select
		case
			when y = 1 then 'term_depossit'
			when loan = 1 then 'personal_loan'
		end as product_type,
		age
	from bank_marketing
	) as product_age
group by product_type

-- List the months, days with the number of customers contacted.
select "month", count(*) as number_of_customers_contacted
from bank_marketing
group by "month"
order by number_of_customers_contacted desc

select pdays, count(*) as number_of_customers_contacted
from bank_marketing
group by pdays
order by number_of_customers_contacted desc

-- List customers who have registered for a personal loan and have no default credit.
select *
from bank_marketing
where loan = 1 and "default" = 'no'

-- Percentage
select count(*) as number_of_customers, ROUND((count(*)*100)/(select count(*) from bank_marketing where loan = 1), 2) as "percentage"
from bank_marketing
where loan = 1 and "default" = 'no'

-- calculate the proportion of customers who have registered for a term deposit 
select previous, count (*) as number_of_customers,
	ROUND((count(*) * 100)/(select count(*) from bank_marketing where previous > 0),2) as deposit_percentage
from bank_marketing
where y = 1
group by previous

-- count the maximum and minimum number of contacts made during a campaign
select max(campaign_contacts) as max_contacts,
	min(campaign_contacts) as min_contacts
from
	(
	select campaign, count(*) as campaign_contacts
	from bank_marketing
	group by campaign
	) as contact_counts


-- List customers with housing loans and without housing loans by marital status.
select marital, sum(case when housing = 1 then 1 else 0 end) as with_housing_loan,
	sum(case when housing = 0 then 1 else 0 end) as without_housing_laon
from bank_marketing
group by marital


-- Calculate the number of customers who have registered for a term deposit by their educational level.
select education, count(*) as number_of_customets_with_deposit
from bank_marketing
where y = 1
group by education

-- Count the number of customers by occupation and with default.
select job, count(*) as number_of_customers_with_default
from bank_marketing
where "default" = 'yes'
group by job

select job, count(*) as number_of_customers_with_default
from bank_marketing
where "default" = 'no'
group by job

-- -- Count the number of customers by occupation and with marital
select marital, count(*) as number_of_customers_with_marital
from bank_marketing
where "default" = 'yes'
group by marital

-- List the professions with the highest average number of customers with default.
select job, AVG(default_count) as avg_default_count
from
	(
	select job, count(*) as default_count
	from bank_marketing
	where "default" = 'yes'
	group by job
	) as default_counts
group by job
order by avg_default_count desc

-- Calculate the total number of customers with default by month and year
select "month", count (*) as default_count
from bank_marketing
where "default" = 'yes'
group by "month"

SELECT job,
       product_type,
       COUNT(*) AS default_count
FROM (
    SELECT job,
           CASE
               WHEN y = 1 THEN 'term_deposit'
               WHEN loan = 1 THEN 'personal_loan'
           END AS product_type
    FROM bank_marketing
    WHERE "default" = 'yes'
) AS customer_products
GROUP BY job, product_type;
