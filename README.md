## Getting and Cleaning Data — Course Project
##### David Levy



### UCI HAR Dataset

The `UCI HAR Dataset` directory is comprised of the unzipped contents of the `harus.zip` file downloaded directly from the UCI Machine Learning repository at `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`. The dataset is formally entitled **Human Activity Recognition Using Smartphones Data Set**, and pertains to "*Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors*," as described by the Abstract on the UCI Machine Learning Repository landing page for the dataset.

This repository contains its own `README.txt` file that should be referred to for details on the format in which the data were originally retrieved for this analysis.



### CodeBook.md

The `CodeBook.md` file is adapted from the `README.txt` and `features_info.txt` provided in the `UCI HAR Dataset` directory. It describes all variables that were selected and the manner in which they were transformed during the tidying process executed by the `run_analysis.R` script. All transformations are also heavily documented in the script itself.

All data and Code Book descriptions pertaining to data that was not selected for the final tidy datasets in this analysis have been removed from the `CodeBook.md` file. The original descriptions remain intact as they were retreieved from the UCI Machine Learning Repository in the documentation located in the `UCI HAR Dataset` directory.



### run_analysis.R

The `run_analysis.R` script downloads all necesssary data files, loads all R package dependencies, and executes five basic tasks:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
