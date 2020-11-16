### Getting & Cleaning Data — Course Project
### David Levy
### November 15, 2020

##   Per assignment directions, the run_analysis.R script should do the 
##   following:

##   1. Merges the training and the test sets to create one data set.

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




##   2. Extracts only the measurements on the mean and standard deviation for 
##      each measurement.

# construct a T/F vector marking the indices of desired variables
mean_std_ind <- grepl('(mean|std)', features$feature)

# use the index vector to extract only the corresponding columns of x and
# initiate a new, reduced x_red dataframe
x_red <- x[, mean_std_ind]




##   3. Uses descriptive activity names to name the activities in the data set

# turn numeric y data into a factor with labels from activity_labels.txt
y$activity <- factor(y$V1, labels=activityLabels$activity)




##   4. Appropriately labels the data set with descriptive variable names.

# retrieve column names for the reduced x_red dataframe
names(x_red) <- features$feature[mean_std_ind]




##   5. From the data set in step 4, creates a second, independent tidy data set 
##      with the average of each variable for each activity and each subject.