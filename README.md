# Data Cleaning with SQL

## Overview

This repository contains a SQL script designed to clean and preprocess a dataset containing information about company layoffs. The script demonstrates various data cleaning techniques such as removing duplicates, standardizing data, handling null values, and formatting dates.

## Table of Contents

- [Overview](#overview)
- [Dataset](#dataset)
- [Prerequisites](#prerequisites)
- [Script Details](#script-details)
- [Usage](#usage)

## Dataset

The script is designed to work with a dataset of company layoffs, which includes information such as the company name, location, industry, total laid off, percentage laid off, date, stage, country, and funds raised. The dataset must be imported into a MySQL database table called `layoffs_raw`.

## Prerequisites

Before running the script, ensure you have the following:

- **MySQL**: The script is written for MySQL, so you need a MySQL server set up on your machine or a remote server.
- **Database Setup**: A database with the `layoffs_raw` table containing your data.

### Sample Table Structure

Here's a basic structure of the `layoffs_raw` table:

```sql
CREATE TABLE `layoffs_raw` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

## Script Details

The script performs the following data cleaning steps:

1. **Create Staging Table**: Creates a copy of the `layoffs_raw` table called `layoffs_staging` for processing.
2. **Remove Duplicates**: Identifies and removes duplicate rows based on specific columns.
3. **Standardize Data**: Trims whitespace, standardizes industry names, and formats date fields.
4. **Handle Null and Blank Values**: Replaces blank industry values with NULL and fills missing industry values based on company name.
5. **Remove Unnecessary Data**: Deletes rows with both `total_laid_off` and `percentage_laid_off` set to NULL and drops temporary columns.
6. **Final Output**: Provides the cleaned dataset.

## Usage

1. **Import Data**: Import your CSV file into the `layoffs_raw` table in your MySQL database.
2. **Run the Script**: Execute the SQL script against your database to clean the data.
3. **View Cleaned Data**: Query the `layoffs_staging2` table to view the cleaned data.
