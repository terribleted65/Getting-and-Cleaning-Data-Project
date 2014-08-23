---
Getting and Cleaning Data Project

run_analysis.R Script

This script merges and cleans up data from the "Human Activity Using Smarphones
Dataset.  The script does the following:
1.  Read in the files from the downloaded UCI HAR Dataset and store the data
    into internal in-memory tables.
2.  Change the labels of the dataset column headers to make them more user
    friendly.
3.  Assign column names to the internal tables.  Using the updated lables from
    step 2 for two of the tables.
4.  Merge the testing and training data into one table
5.  Keep only the columns with _id, Mean, and StdDev
6.  Calcluate the average for each variable for each activity and each subject
7.  Sort the data into activity-subject order for readability
8.  Write the output to tidydata.txt

How to run the script
1.  Download the dataset:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2.  Unzip the dataset
3.  Place the run_analysis.R script in the created main data directory 
    UCI HAR Dataset
4.  type source("run_analysis.R") to run the script
5.  in the same directory as the script, find the results in tidydata.txt

Output file -tidydata.txt
The resulting tabl delimited text file contains one row for each activity-subject
match with an average calculated for the columns with Mean and StdDev

NOTE:
A description of the input data, variables uses, and any data transformations is
described in the CodeBook.md.
---