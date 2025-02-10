-- Exploratory Data Analysis --

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging;

SELECT *
FROM layoffs_staging
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`) AS laid_off_by_year, SUM(total_laid_off)
FROM layoffs_staging
GROUP BY laid_off_by_year
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging
GROUP BY stage
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`,1,7) AS `month`, SUM(total_laid_off)
FROM layoffs_staging
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC;

WITH Rolling_total AS (
SELECT SUBSTRING(`date`,1,7) AS `month`, SUM(total_laid_off) AS total_off
FROM layoffs_staging
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC
)
SELECT `month`, total_off,
SUM(total_off) OVER(ORDER BY `month`) AS rolling_total
FROM Rolling_total;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH company_year (company, years, total_laid_off) AS (
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
)
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL
ORDER BY ranking ASC;


WITH company_year (company, years, total_laid_off) AS (
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
), company_year_rank AS (
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL
ORDER BY ranking ASC
)
SELECT *
FROM company_year_rank
WHERE ranking <=5;
