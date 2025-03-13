-- Data Cleaning 

SELECT *
FROM layoffs;


-- 1. Remove duplicates 
-- 2. Standardise Data 
-- 3. Remove Null And Blank Values 
-- 4. Remove unneccessary columns 



-- create a duplicate table of layoffs so that mistakes dont affect the rawdata
create table layoffs_staging 
like layoffs; 


SELECT *
FROM layoffs_staging;


insert layoffs_staging 
select *
from layoffs ; 

-- 1. removing duplicates 
-- creating rownumber distinct which is partitioned by the company industry ......so on


SELECT * , row_number() over (
partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
FROM layoffs_staging;


-- creating a cte to identify 2 similar row and remove it 
with duplicate_cte as
(
SELECT * , 
row_number() over (
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) as row_num
FROM layoffs_staging
)
select * 
from duplicate_cte
where row_num > 1;

-- checking one of the company from the filter using cte
SELECT *
FROM layoffs_staging
where company = 'casper'
;

-- creating copy of layoffs staging table to delete duplicate 
-- using copy to clipboard 
-- this is done since we cannot delete in cte the rownum > 2 

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

-- insert data from table layoffs_staging

insert into layoffs_staging2
SELECT * , 
row_number() over (
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) as row_num
FROM layoffs_staging;


-- additionaly of we see here there is one more column name that is rrow_num 
-- to add row_number column we created new table 

select *
from layoffs_staging2
where row_num > 1 ; 

-- deleting duplicsate row ie.. row_num > 1 

delete 
from layoffs_staging2
where row_num > 1 ; 

-- checking for visiblity of row-num > 1


select *
from layoffs_staging2
where row_num > 1 
 ; 
 

-- 2. standardizing data

-- step 1 check company 
select company, trim(company)
from layoffs_staging2
 ; 
 
-- we use trim to trim the compnay name to remove white spaces 
update layoffs_staging2
set company = trim(company);

-- step 2 check industry 
-- we can see the first 2 columns is null and black 
-- we see crypto industry is repleated twice with 2 different names 
select distinct industry
from layoffs_staging2
order by 1
;

-- here we see 95 percent of the name are crypto
select *
from layoffs_staging2
where industry like 'Crypto%'
;

-- we update all the other which are not like crypto 
update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';


-- step 3 check location (try to check as many columns as possible as we may have minute errors )

select distinct location 
from layoffs_staging2
order by 1  ; 

-- while checking country we found us with and without fullstop  
select distinct country
from layoffs_staging2
order by 1  ; 

-- removing white spaces 
select country, trim(country)
from layoffs_staging2
order by 1
 ; 
 
 -- trailing or removing full stop 
 -- trailing is a form of trim 
 -- using this to remove fullstop to clean ruined data
 
 
select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1
 ; 

-- update in real table 

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%' ;


-- checking to find is it updated or not 

select distinct country
from layoffs_staging2
order by 1
 ; 
 
 -- now checking the date coloumn 
 -- used in Time-Series EDA
 -- standardised format of date 
 
 select `date`,
 str_to_date(`date`, '%m/%d/%Y')
 from layoffs_staging2; 
 
 update layoffs_staging2
 set `date` = str_to_date(`date`, '%m/%d/%Y')
 ;
 
 -- checking
select `date`
from layoffs_staging2; 
 
 -- changing data type from text to date in the date column in staging2 table not to do  it in original table 
 -- altering data in originall table must  be avoided 
 
alter table layoffs_staging2
modify column `date` DATE; 

-- checking 
select *
from layoffs_staging2; 
 
-- 3. working with null and blank values 

 
select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null; 
; 


-- now removing null values and white spaces in industry column 

select  *
from layoffs_staging2
where industry is null 
or industry = '';
 
 select * 
 from layoffs_staging2
 where company = 'Airbnb';
 
 -- filtering one has black or null value and the other has actual value 
 select t1.industry, t2.industry 
 from layoffs_staging2 t1
 join layoffs_staging2 t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null ;


-- change to a update statement 
-- (found this statemnt doesnt work)
update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null ;

-- so trying to change the blank spaces to null 

update layoffs_staging2 
set industry = null 
where industry = '';

-- now trying with same querry but alterd as we dont have blank values 

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null ;

-- checking 
select  *
from layoffs_staging2
where industry is null 
or industry = '';


-- found ballys only company is still null 
-- (since there is no not null row for  ballys it  is not updated )

-- we cannot resolve null and blank values problem in 
-- total laid off and percenntage laid off 
-- it would have been possible if we have total employees columns 
-- it also depends on the availability of data 

-- funds raisd also we can get the data from internet 
-- not not a part of this project (data cleaning)


-- checking
select  *
from layoffs_staging2
 ; 

-- since both the values are null this data is inaccurate 
-- cannot be used in further analysys 
-- so we can delete it 
-- but be 100% sure before deleting 
 
select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null; 

-- after 100 percent sure we can delete the unnecessary data 

delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null; 

-- checking 
select *
from layoffs_staging2;

-- 4. deleting unnecessary column 
-- now we are going to delete row nuumber 

alter table layoffs_staging2
drop column row_num;


-- checking the finalised clean data 
select *
from layoffs_staging2;


