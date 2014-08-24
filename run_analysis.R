###
# read in UCI HAR Dataset and store into in-memory tables
###
# read subject test data
test_x_data <- read.table("./test/X_test.txt")
test_y_data <- read.table("./test/y_test.txt")
test_subjects_data <- read.table("./test/subject_test.txt")
# read subject training data
train_x_data <- read.table("./train/X_train.txt")
train_y_data <- read.table("./train/y_train.txt")
train_subjects_data <- read.table("./train/subject_train.txt")
# read file of feature header names
data_features_header_data <- read.table("./features.txt")
# read file of activity types tracked for subjects
activity_type <- read.table("./activity_labels.txt")
###
# use gsub to pattern match and clean up the labels for the columns of the
# features dataset
###
# make headers of columns user friendly names
cleaned_features_header <- gsub("\\()","",data_features_header_data[,2])
cleaned_features_header <- gsub("-std","-StdDev",cleaned_features_header)
cleaned_features_header <- gsub("-mean","-Mean",cleaned_features_header)
cleaned_features_header <- gsub("([Gg]ravity)","Gravity",cleaned_features_header)
cleaned_features_header <- gsub("([Mm]ag)","Magnitude",cleaned_features_header)
cleaned_features_header <- gsub("([Aa]cc)","Accel",cleaned_features_header)
cleaned_features_header <- gsub("BodyBody","Body",cleaned_features_header)
cleaned_features_header <- gsub("tBody","TimeBody",cleaned_features_header)
cleaned_features_header <- gsub("^(t)","Time",cleaned_features_header)
cleaned_features_header <- gsub("^(f)","Freq",cleaned_features_header)
###
# assign column names to the in-memory tablets
###
# set testing data column names
colnames(test_subjects_data) <- "subject_id"
colnames(test_x_data) <- cleaned_features_header
colnames(test_y_data) <- "activity_id"
# set training data column names
colnames(activity_type) <- c("activity_id", "activity_type")
colnames(train_subjects_data) <- "subject_id"
colnames(train_x_data) <- cleaned_features_header
colnames(train_y_data) <- "activity_id"
###
# merge the testing data by columns into one table and do the same with the
# training data.  then combine the testing and training data by rows as they 
# each have the same columns.
###
# combine the subject testing data
testing_data <- cbind(test_y_data, test_subjects_data, test_x_data)
# combine the subject training data
training_data <- cbind(train_y_data, train_subjects_data, train_x_data)
# combing testing and training data
subject_test_train_data <- rbind(training_data, testing_data)
###
# trim down the combined table to only include columns with _id, Mean, & StdDev
###
# identify the columns to keep
keep_columns <- (grepl("_id",colnames(subject_test_train_data)) | 
                     grepl("Mean",colnames(subject_test_train_data)) |
                     grepl("StdDev",colnames(subject_test_train_data)))
# save only the identified columns for id's, mean, and std dev
subject_test_train_mean_stddev <- subject_test_train_data[keep_columns==TRUE]
# combine/merge the training and activity type data by matching the activity_id
merged_subj_test_train_act_name <- merge(activity_type, 
    subject_test_train_mean_stddev, by="activity_id",all.x=TRUE)
# create a table without the activity type names and will prepend the names in
# a later step
sub_tst_trn_no_type <- 
    merged_subj_test_train_act_name[,names(merged_subj_test_train_act_name) 
    != "activity_type"]
###
# do the final calculation and merge the data and sort the data to write out the
# final output tidy data
###
# calculate the avearge or mean of each activity for each subject
mean_subj_test_train_data <- aggregate(sub_tst_trn_no_type[,names(sub_tst_trn_no_type) 
    != c("activity_id","subject_id")], by=list(activity_id=sub_tst_trn_no_type$activity_id,
    subject_id=sub_tst_trn_no_type$subject_id),mean)
# combine/merge the aggregated/summarized data with the activity_type pre-pended
tidydata <- merge(activity_type,mean_subj_test_train_data,by="activity_id",all.x=TRUE)
# sort the final dataset by activity_id and subject_id to improve readability
tidydata_sorted <- tidydata[order(tidydata$activity_id, tidydata$subject_id), ]
# write final tidy dataset to a tab delimited text fill and surpress row #'s
write.table(tidydata_sorted, "./tidydata.txt",row.names=FALSE,sep="\t")