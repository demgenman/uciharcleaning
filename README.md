## About this repository

This repository contains an R script that performs a data cleanup of the Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

## Files

* README.md: This file.
* CodeBook.md: The code book that describes the variables, the data, and any transformations or work performed to clean up the data.
* run_analysis.R: The R script that performs the data clean up.

## External dependencies

The files is this repository depend on several external files.

* [UCI HAR Dataset.zip] (http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip): The raw data. Files used:
    * ./UCI HAR Dataset/train/subject_train.txt
    * ./UCI HAR Dataset/test/subject_test.txt
    * ./UCI HAR Dataset/train/y_train.txt
    * ./UCI HAR Dataset/test/y_test.txt
    * ./UCI HAR Dataset/train/X_train.txt
    * ./UCI HAR Dataset/test/X_test.txt
    * ./UCI HAR Dataset/features.txt
    * ./UCI HAR Dataset/activity_labels.txt
    
* [Human Activity Recognition Using Smartphones Data Set] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones): Detailed information about the data set.

## Instruction list

These are the steps to perform the clean up on the data set:

1. Download [UCI HAR Dataset.zip] (http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip) and unzip it into your working directory. This creates a folder called "UCI HAR Dataset" with files and subfolders.

2. Execute the R script run_analysis.R in the working directory. The script processes the data set files and places the result files in the subfolder called "merged" in folder "UCI HAR Dataset". The following result files get created in this step:

* Files containing the merged original "training" and "test" data. These files do not contain header lines. 
    * subject_merged.txt: The combined data from files subject_train.txt and subject_test.txt. 
    * y_merged.txt: The combined data from files y_train.txt and y_test.txt.
    * X_merged.txt: The combined data from files X_train.txt and X_test.txt.

* Processed raw files. The files include a header line and are in comma-delimited format. The first column is the row name, the remaining columns are the data.
    * subject_merged.csv: The data column name is "subject".
    * y_merged.csv: The data column names are the 561 names given by the file "features.txt"
    * X_merged.csv: The data column name is "activityId"
    * All_merged.csv: The combined data from the above files. Columns are "subject", "activityId" and the 561 names.

* Tidy files. The files contain average metrics for the 30 subjects and 6 activities each. The metrics have been given friendly names. Metrics selected for the tidy files include all features having "mean()" and "std()" in their original feature name as given by the file "features.txt". For more information about naming please consult CodeBook.md. 
    * All_tidy.csv: Comma-delimited format.
    * All_tidy.txt: Tab-delimited format.

* During execution the script temporarily changes the working directory to the "merged" folder. Just before the script completes the script resets the working directory to what it was when the script started.

## History

19 May 2014: Creation.
