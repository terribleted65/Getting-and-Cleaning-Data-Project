---
The script run_analysis.R reads the data from the UCI HAR Dataset and cleans it
up into a tidy dataset. The key data used from the 561 column input data are the
mean and standard deviation information.  Once the data is cleaned, the average
of each column is calucalated for each activity/subject match. A description of 
how to run the script and where to get the data is available in the README.md file.
---
Input file: UCI HAR Dataset [1]
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The dataset includes the following files:
=========================================
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Files from the dataset not used for processing include:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

Dataset variables correlating to the test and training data:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of 561 variables of each feature vector is available in 
the UCI HAR dataset file 'features.txt'
---
The run_analysis.R variables used:
test_x_data - the testing data with 561 columns and 2947 rows
test_y_data - the activity id for the x_data test data with 1 column and 2947 rows
test_subjects_data - the testing subjects id for the x_data test data with 1 column
and 2947 rows
train_x_data - the training data with 561 columns and 7352 rows
train_y_data - the activity id for the x_data train data with 1 column and 7352 rows
train_subjects_data - the training subjects id for the x_data train data with 1 column
and 7352 rows
data_features_header_data - header names for the train_x & test_x data
activity_type - activity id along with activity name to match to the 
test_x & train_x data
cleaned_features_header - taking the data_features_header_data and cleaning up
the names to be more readable using gsub to substitute strings
testing_data - column type binding of test_* variables above
training_data - column type binding of training_* variables above
subject_test_train_data - row type binding of the column combined data 
testing_data & training_data
keep_columns - logical vector with the columns wanted identified by a TRUE.
These columns include _id, Mean, and StdDev in their column names.
subject_test_train_mean_stddev - using the logical vector keep_columns to get
a subset of the larger subject_test_train_data
merged_subj_test_train_act_name - merged dataset of the activity id,name, and
the testing and training data.  this has the id/name at the beginning of the 
data so it is more readable for the user.
sub_tst_trn_no_type - the merged data with the activity type names removed
mean_subj_test_train_data - the merged data with the average or mean calculated
for each Standard Deviation and Mean column by the activity type id and 
subject combination
tidydata - merging the activity type names back the beginning of the data
tidydata_sorted - sort of the merged data by activity id and subect id
tidydata.txt - output text file that is tab delimited with 89 columns and 
180 rows.  
---
Steps followed in run_analysis.R as described in the script:
###
# read in UCI HAR Dataset and store into in-memory tables
###
# read subject test data
# read subject training data
# read file of feature header names
# read file of activity types tracked for subjects
###
# use gsub to pattern match and clean up the labels for the columns of the
# features dataset
###
# make headers of columns user friendly names
###
# assign column names to the in-memory tablets
###
# set testing data column names
# set training data column names
###
# merge the testing data by columns into one table and do the same with the
# training data.  then combine the testing and training data by rows as they 
# each have the same columns.
###
# combine the subject testing data
# combine the subject training data
# combing testing and training data
###
# trim down the combined table to only include columns with _id, Mean, & StdDev
###
# identify the columns to keep
# save only the identified columns for id's, mean, and std dev
# combine/merge the training and activity type data by matching the activity_id
# create a table without the activity type names and will prepend the names in
# a later step
###
# do the final calculation and merge the data and sort the data to write out the
# final output tidy data
###
# calculate the avearge or mean of each activity for each subject
# combine/merge the aggregated/summarized data with the activity_type pre-pended
# sort the final dataset by activity_id and subject_id to improve readability
# write final tidy dataset to a tab delimited text fill and surpress row #'s
========
License:
========
Use of this dataset in publications must be acknowledged by referencing the 
following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.