### Getting & Cleaning Data — Course Project
### David Levy
### November 15, 2020

##  load libraries and retrieve data
library(tidyverse)

# data loading string initiation
datafile <- 'harus.zip'
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
dir <- 'UCI HAR Dataset'

# file download if not already complete
if(!file.exists(datafile)){
    download.file(url, datafile) 
}

# unzip file if not already complete
if(!file.exists(dir)){
    unzip(datafile)
}


##  per assignment directions, the run_analysis.R script should do the 
##  following:

##  1. Merges the training and the test sets to create one data set.

# retrieve test data
xtest <- read.table('UCI HAR Dataset/test/X_test.txt')
ytest <- read.table('UCI HAR Dataset/test/y_test.txt')
subjtest <- read.table('UCI HAR Dataset/test/subject_test.txt')

# retrieve train data
xtrain <- read.table('UCI HAR Dataset/train/X_train.txt')
ytrain <- read.table('UCI HAR Dataset/train/y_train.txt')
subjtrain <- read.table('UCI HAR Dataset/train/subject_train.txt')

# merge data
x <- rbind(xtest, xtrain)
y <- rbind(ytest, ytrain)
subj <- rbind(subjtest, subjtrain)




##  2. Extracts only the measurements on the mean and standard deviation for 
##     each measurement.

# get features from the appropriate file
features <- read_delim('UCI HAR Dataset/features.txt', ' ',
                       col_names = c('index', 'feature'))

# construct a T/F vector marking the indices of desired variables
mean_std_ind <- grepl('(mean|std)', features$feature)

# use the index vector to extract only the corresponding columns of x and
# initiate a new, reduced x_red dataframe
x_red <- x[, mean_std_ind]




##  3. Uses descriptive activity names to name the activities in the data set

# get activity labels from the appropriate file
activityLabels <- read_delim('UCI HAR Dataset/activity_labels.txt', ' ',
                             col_names = c('label', 'activity'))

# reformat labels to meet tidy data guidelines
actLabs <- str_to_lower(str_remove_all(activityLabels$activity, 
                                                       '[^[:alnum:]]'))

# turn numeric y data into a factor with labels from activity_labels.txt
activity <- factor(y$V1, labels=actLabs)




##  4. Appropriately labels the data set with descriptive variable names.

# retrieve column names for the reduced x_red dataframe
names(x_red) <- features$feature[mean_std_ind]

# transform subject data into factors and rename column
subject <- as.factor(subj$V1)

# column bind activity and subject data to x_red with descriptive names
tidyDataSet <- cbind(subject, x_red, activity)



##  5. From the data set in step 4, creates a second, independent tidy data set 
##     with the average of each variable for each activity and each subject.

# use dplyr grouping and summarise across functions to get means within activity 
# and subject gorupings
avTidyData <- tidyDataSet %>%
    group_by(activity, subject) %>%
    summarise(across(everything(), mean))

# rename all columns except for `subject` and `activity`
names(avTidyData)[-c(1:2)] <- paste('avg_', names(avTidyData)[-c(1:2)], sep='')


# write tidy data to new csv files
outputFile <- 'Tidy Data'
if(!file.exists(outputFile)){
    dir.create(outputFile)
}

write.table(avTidyData, 'Tidy Data/avTidyData.txt', row.name=FALSE)
