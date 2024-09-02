# Cleaning-Data-in-World-Layoffs-Dataset
This is a SQL Data Cleaning Project done in MySQL.
There's no need for an extra readme file for this as I already have added the comments to improve readabilty. So, let's just discuss each steps one by one and have a quick revision.

The first thing I have done is, I viewed the whole table as we generally do to view a table in SQL:

    SELECT * FROM layoffs;

As I'm going to perform Data Cleaning in the dataset, I'll definitely need some changes, including removing, modifying and renaming values; so it'd be better to copy the table to a new one and then perform the necessary changes there. That's what I have done next. Our main dataset name is "world_layoffs" so let's name the new table as "layoffs_staging".

Next I have inserted all the data from the main table to the new one and just for clarification, view the complete table once before proceeding. Alright! From this we began our Data Cleaning Process. The very first thing I have done is to check whether it contains duplicates or not. Here I have used "ROW_NUMBER()" function, becasue it'll show us if any it contains duplicate values. From the row number, we can then easily identify the duplicates and delete them.

But the issue here is that we can't directly delete the values in a CTE (Common Table Expression), else it'll throw an error "The target table duplicate_cte of the DELETE is not updatable". So, in order to delete them without getting any error, next I have create a whole new table and copied all the data into it so that we can easily delete them.
This time, you'll probably not get any error messege, if you have written the correct query.

Alright our first step of our Data Cleaning Process, i.e. to remove duplicates is done. Next is to standadide the data. So, first I have used "TRIM()" function. This function basically removes the whitespaces. Then I have used the "LIKE" operator. This helps in pattern matching. So, if we have same values with different names, we can rename it and match them. For example, there is values "Crypto" and "CryptoCurrency". Here, I can rename all the values that starts with "Crypto" to "Crypto". This is because these two should be same but, our database system will not auto-detect it. 

One more thing I have done here is that we have a column named "date" which is in the text format and we need to change it to date format. So, for that I first used the function "STR_TO_DATE(`date`, '%m/%d/%Y')" for the correct sql date format and then modified its format to date using "ALTER" command.

Out thirt step is to check the Null values or Blank Values. Here, I have simply used the "IS NULL" contraint to check if it's null. For blank values, just check normally as we check a blank value with a blank space. For example,

    SELECT * FROM layoffs_staging2
    WHERE industry = '';

Finally, our last step is removing any columns or rows if it's of no use. To delete any row, use "DELETE" command and for columns, use "ALTER" command with "DROP" column. And guess what, our Data Cleaning process is done. Now view the cleaned data once again before proceeding, it can be either EDA or making any reports or improting somewhere else to visualize. 

Happy Exploring!

1. **Import Data**: Import your CSV file into the `layoffs_raw` table in your MySQL database.
2. **Run the Script**: Execute the SQL script against your database to clean the data.
3. **View Cleaned Data**: Query the `layoffs_staging2` table to view the cleaned data.
