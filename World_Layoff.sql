-- DATA CLEANING in Layoff Dataset

SELECT * FROM layoffs;

/*
Steps I'm going to take to clean the data:
	 1. Remove Duplicates
	 2. Standadize the data
	 3. Null values or Blank values
	 4. Remove any Columns or Rows
*/

-- Copying the whole table in a new table.
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * FROM layoffs_staging;


INSERT layoffs_staging
SELECT * FROM layoffs;


-- Checking Duplicates
SELECT *, ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
		`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;


WITH duplicate_cte AS (
SELECT *, ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
		`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging)
SELECT * FROM duplicate_cte
WHERE row_num > 1;


SELECT * FROM layoffs_staging
WHERE company = 'Casper';


-- Error Code: 1288. The target table duplicate_cte of the DELETE is not updatable	0.000 sec
WITH duplicate_cte AS (
SELECT *, ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
		`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging)
DELETE FROM duplicate_cte
WHERE row_num > 1;


-- Let's create another table with an added column 'row_num' with it.
CREATE TABLE layoffs_staging2 (
	company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT DEFAULT NULL,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT DEFAULT NULL,
    row_num INT);


INSERT layoffs_staging2
SELECT *, ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
		`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT * FROM layoffs_staging2;


SELECT * FROM layoffs_staging2
WHERE row_num > 1;


-- 1. Removing all the Duplicates
DELETE FROM layoffs_staging2
WHERE row_num > 1;


-- 2. Standadizing the data
SELECT company, TRIM(company)
FROM layoffs_staging2;


-- TRIM() removes the whitespaces.
UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry 
FROM layoffs_staging2
ORDER BY 1;


SELECT * FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2 ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


SELECT DISTINCT country
FROM layoffs_staging2 ORDER BY 1;

SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET `date`= STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date` FROM layoffs_staging2;


ALTER TABLE layoffs_staging2
MODIFY `date` DATE;

SELECT * FROM layoffs_staging2;


-- 3. Null values or Blank values
SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';


UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';


SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


SELECT * FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT * FROM layoffs_staging2
WHERE industry IS NULL OR industry = '';

SELECT * FROM layoffs_staging2
WHERE company LIKE 'Bally%';


-- 4. Removing any Columns or Rows
SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * FROM layoffs_staging2;

