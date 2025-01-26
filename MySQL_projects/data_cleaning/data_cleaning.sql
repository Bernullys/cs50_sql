-- Data cleaning --

SELECT * FROM layoffs;

SELECT COUNT(*)
FROM layoffs;

-- Steps --


-- Step 0. Duplicate raw data --


-- Here we create a new table with the same columns:
CREATE TABLE layoffs_staging
LIKE layoffs;
-- Here we insert all the data in the new table:
INSERT INTO layoffs_staging (
	SELECT *
);
-- I'm adding id to the table to malipulate better :)
-- First create the id column:
ALTER TABLE layoffs_staging
ADD COLUMN id INTEGER;
-- Then populate the id column:
ALTER TABLE layoffs_staging
MODIFY COLUMN id INT AUTO_INCREMENT PRIMARY KEY;


-- Step 1. Remove duplicates if any --


-- Here we set a number for every row, with a partition by every column so as long as there is only one row the row number will be 1:
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;
-- Here we create a CTE to check which rows have more than 1:
WITH duplicates AS (
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
	FROM layoffs_staging
)
SELECT *
FROM duplicates
WHERE row_num > 1;

-- Now I will select one by one to know its id numbers:
SELECT *
FROM layoffs_staging
WHERE company = 'Yahoo' AND location = 'SF Bay Area';

-- And finally here I will delete one by one using its id:
DELETE FROM layoffs_staging
WHERE id = 2358;


-- 2. Standardizing the data.


-- Checking spelling in company column
SELECT company, COUNT(*)
FROM layoffs_staging
GROUP BY company
ORDER BY company;
-- Results: all Ok

-- Checking spelling in location column
SELECT location, COUNT(*)
FROM layoffs_staging
GROUP BY location
ORDER BY location;
-- Results: all Ok

-- Checking spelling in industry column
SELECT industry, COUNT(*)
FROM layoffs_staging
GROUP BY industry
ORDER BY industry;
-- Results: one null and one blank, three different spelling (Crypto, Cryoto Currency and CryptoCurrency)
-- Fixing this issue:
UPDATE layoffs_staging
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Checking spelling in country column
SELECT country, COUNT(*)
FROM layoffs_staging
GROUP BY country
ORDER BY country;
-- Results: two different spelling (United States and United States.)
-- Fixing this issue:
UPDATE layoffs_staging
SET country = 'United States'
WHERE country LIKE 'United States.';

-- Fixing date type, because is in text type:
-- First we need to chaged to the format MySQL take it as date type:
UPDATE layoffs_staging
SET `date` = STR_TO_DATE(`date`, "%m/%d/%Y");
-- Now we can modify its type:
ALTER TABLE layoffs_staging
MODIFY COLUMN `date` DATE;


-- Step 3. Null Values or blank values.

-- Let's see if we can populated data on nulls or blanks:
-- We can do that on company, country and industry:
SELECT *
FROM layoffs_staging
WHERE industry IS NULL 
OR industry = '';
-- In this case is happening only with some industries. With companies: Juul, Carvana, Bally's Interactive and Airbnb.
-- Let's check one by one if we can find its industry.
SELECT company, industry
FROM layoffs_staging
WHERE company = "Juul";
-- We have the counclusion we can populate the mayority.
-- This is a cool tachnique to check which can go with an existing one:
SELECT ls1.industry, ls2.industry
FROM layoffs_staging ls1
JOIN layoffs_staging ls2
	ON ls1.company = ls2.company
WHERE (ls1.industry IS NULL OR ls1.industry = '')
AND ls2.industry IS NOT NULL;
-- Now to make this work we first need to put all blanks as null to after that replace it with its value.
-- Before this query, the last query were returning some blanks and some nulls on ls1.industry.
UPDATE layoffs_staging
SET industry = NULL
WHERE industry = '';
-- Now we can update ls1 with its corresponding value:
UPDATE layoffs_staging ls1
JOIN layoffs_staging ls2
	ON ls1.company = ls2.company
SET ls1.industry = ls2.industry
WHERE ls1.industry IS NULL
AND ls2.industry IS NOT NULL;

-- Let's check which values are null and we can't do anything about it so we could delete them:
-- We have to check if with the info we have we could populate data making calculusor something.
-- I decided to delete all rows that have total_laid_off, percentage_laid_off and funds_raised_millions equals to null or blank.
SELECT total_laid_off, percentage_laid_off, funds_raised_millions
FROM layoffs_staging;

DELETE
FROM layoffs_staging
WHERE total_laid_off IS NULL OR total_laid_off = ''
AND percentage_laid_off IS NULL OR percentage_laid_off = ''
AND funds_raised_millions IS NULL OR funds_raised_millions = '';


-- 4. Remove any columns or rows.

-- I will leave the same colums plus id column I added.

SELECT COUNT(*)
FROM layoffs_staging;