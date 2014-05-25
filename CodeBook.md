## Purpose

This Code Book provides background information to the R script that performs a data cleanup of the Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

## Study design

This script follows the requirements as stated in the [Getting and Cleaning Data Course Project] (https://class.coursera.org/getdata-003). Detailed information about the original study can be found here: [Human Activity Recognition Using Smartphones Data Set] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The R script "run_analysis.R" does the following: 

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Code book

### Variables

* file.copyAppend(): Function, either copies or appends a file to another file based on existence of the second file. 
* my.read.fwf(): Function, reads fixed-width file with efficient use of memory.
* dirData: Character string, top folder for the data set 
* dirMerged: Character string, folder containing the merged files and result files.
* dfSubject: Data frame, containing "subject" data as read from file "subject_merged.txt".
* dfY: Data frame, containing "activity" data, as read from file "y_merged.txt".
* dfX: Data frame, containing "features" data, as read from file "X_merged.txt".
* featureNames: Data frame, containing feature names, as read from file "features.txt".
* dfMerged: Data frame, containing merged subject, activity and features data columns.
* featureSelection: Logical vector, indicating selection of columns to be used for the tidy data set.
* dfMergedSelection: Data frame, containing merged subject, activity and selected features data columns.
* activityLabels: Data frame, containing activity indentifiers and corresponding activity name.
* dfRecodeVariables: Data frame, containing variable recodings: column "variable" is the original variable name, "variable.friendly" is the friendly name for the variable, "description" is explanatory text for the given variable. 
* featureNames2: Character vector, containing the recoded feature names.
* dfTidy: Data frame, containing the tidy data set.

### Files

For an overview of used files, please consult README.md.

Tidy files:
* ./UCI HAR Dataset/merged/All_tidy.csv
* ./UCI HAR Dataset/merged/All_tidy.txt

Both files have a header line, and following fields and value ranges: 

* subject: numeric; integer value range: 1 .. 30
* activity: character; values: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
* timebodyaccellerationmeanx: numeric; value range: -1 .. 1
* timebodyaccellerationmeany: numeric; value range: -1 .. 1
* timebodyaccellerationmeanz: numeric; value range: -1 .. 1
* timebodyaccellerationstddevx: numeric; value range: -1 .. 1
* timebodyaccellerationstddevy: numeric; value range: -1 .. 1
* timebodyaccellerationstddevz: numeric; value range: -1 .. 1
* timegravityaccellerationmeanx: numeric; value range: -1 .. 1
* timegravityaccellerationmeany: numeric; value range: -1 .. 1
* timegravityaccellerationmeanz: numeric; value range: -1 .. 1
* timegravityaccellerationstddevx: numeric; value range: -1 .. 1
* timegravityaccellerationstddevy: numeric; value range: -1 .. 1
* timegravityaccellerationstddevz: numeric; value range: -1 .. 1
* timebodyaccellerationjerkmeanx: numeric; value range: -1 .. 1
* timebodyaccellerationjerkmeany: numeric; value range: -1 .. 1
* timebodyaccellerationjerkmeanz: numeric; value range: -1 .. 1
* timebodyaccellerationjerkstddevx: numeric; value range: -1 .. 1
* timebodyaccellerationjerkstddevy: numeric; value range: -1 .. 1
* timebodyaccellerationjerkstddevz: numeric; value range: -1 .. 1
* timebodyvelocitymeanx: numeric; value range: -1 .. 1
* timebodyvelocitymeany: numeric; value range: -1 .. 1
* timebodyvelocitymeanz: numeric; value range: -1 .. 1
* timebodyvelocitystddevx: numeric; value range: -1 .. 1
* timebodyvelocitystddevy: numeric; value range: -1 .. 1
* timebodyvelocitystddevz: numeric; value range: -1 .. 1
* timebodyvelocityjerkmeanx: numeric; value range: -1 .. 1
* timebodyvelocityjerkmeany: numeric; value range: -1 .. 1
* timebodyvelocityjerkmeanz: numeric; value range: -1 .. 1
* timebodyvelocityjerkstddevx: numeric; value range: -1 .. 1
* timebodyvelocityjerkstddevy: numeric; value range: -1 .. 1
* timebodyvelocityjerkstddevz: numeric; value range: -1 .. 1
* timebodyaccellerationmagnitudemean: numeric; value range: -1 .. 1
* timebodyaccellerationmagnitudestddev: numeric; value range: -1 .. 1
* timegravityaccellerationmagnitudemean: numeric; value range: -1 .. 1
* timegravityaccellerationmagnitudestddev: numeric; value range: -1 .. 1
* timebodyaccellerationjerkmagnitudemean: numeric; value range: -1 .. 1
* timebodyaccellerationjerkmagnitudestddev: numeric; value range: -1 .. 1
* timebodyvelocitymagnitudemean: numeric; value range: -1 .. 1
* timebodyvelocitymagnitudestddev: numeric; value range: -1 .. 1
* timebodyvelocityjerkmagnitudemean: numeric; value range: -1 .. 1
* timebodyvelocityjerkmagnitudestddev: numeric; value range: -1 .. 1
* frequencybodyaccellerationmeanx: numeric; value range: -1 .. 1
* frequencybodyaccellerationmeany: numeric; value range: -1 .. 1
* frequencybodyaccellerationmeanz: numeric; value range: -1 .. 1
* frequencybodyaccellerationstddevx: numeric; value range: -1 .. 1
* frequencybodyaccellerationstddevy: numeric; value range: -1 .. 1
* frequencybodyaccellerationstddevz: numeric; value range: -1 .. 1
* frequencybodyaccellerationjerkmeanx: numeric; value range: -1 .. 1
* frequencybodyaccellerationjerkmeany: numeric; value range: -1 .. 1
* frequencybodyaccellerationjerkmeanz: numeric; value range: -1 .. 1
* frequencybodyaccellerationjerkstddevx: numeric; value range: -1 .. 1
* frequencybodyaccellerationjerkstddevy: numeric; value range: -1 .. 1
* frequencybodyaccellerationjerkstddevz: numeric; value range: -1 .. 1
* frequencybodyvelocitymeanx: numeric; value range: -1 .. 1
* frequencybodyvelocitymeany: numeric; value range: -1 .. 1
* frequencybodyvelocitymeanz: numeric; value range: -1 .. 1
* frequencybodyvelocitystddevx: numeric; value range: -1 .. 1
* frequencybodyvelocitystddevy: numeric; value range: -1 .. 1
* frequencybodyvelocitystddevz: numeric; value range: -1 .. 1
* frequencybodyaccellerationmagnitudemean: numeric; value range: -1 .. 1
* frequencybodyaccellerationmagnitudestddev: numeric; value range: -1 .. 1
* frequencybodyaccellerationjerkmagnitudemean: numeric; value range: -1 .. 1
* frequencybodyaccellerationjerkmagnitudestddev: numeric; value range: -1 .. 1
* frequencybodyvelocitymagnitudemean: numeric; value range: -1 .. 1
* frequencybodyvelocitymagnitudestddev: numeric; value range: -1 .. 1
* frequencybodyvelocityjerkmagnitudemean: numeric; value range: -1 .. 1
* frequencybodyvelocityjerkmagnitudestddev: numeric; value range: -1 .. 1

### Code and transformations

#### Step 1. Merges the training and the test sets to create one data set.

1.1. Merge files

* Create subfolder "merged" inside the top folder of the data set.
* Copy the files subject_train.txt, y_train.txt and X_train.txt to the "merged" folder. The destination file is renamed to subject_merged.txt, y_merged.txt and X_merged.txt, respectively.
* Append the files subject_test.txt, y_test.txt and X_test.txt to the files subject_merged.txt, y_merged.txt and X_merged.txt, respectively.
* The function file.copyAppend() manages the file copy and append task. 

1.2. Combine files into a single data set

X_merged.txt is a large data set in fixed-width format. Reading it using read.fwf() sometimes presents a problem in memory-constrained systems. Function my.read.fwf() aims to work around this using the following strategy:
* Determine file line width
* Read file as a wide, single column of character data
* Split column into multiple columns
* Convert columns in numeric values
* Convert values to data frame
* Release objects immediately after use and run garbage collector to free memory
* If my.read.fwf encounters a file that appears to be non-fixed width, it will treat the file as a comma-separated file.

In this way, subject_merged.txt, y_merged.txt and X_merged.txt are read into dfSubject, dfY and dfX, respectively.

The three data frames are then combined into one using cbind().

All four data frames are saved as comma-separated files in the "merged" folder. While not strictly needed for the assignment, it may be handy to keep these processed raw files as reading csv files is usually much faster than fixed-width text files. The files don't have a header line.

#### Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

For this assignment, the choice is made to select features that contain the string "-mean()" or "-std()". This results in 68 columns, including subject and activity (66 features therefore).

#### Step 3. Uses descriptive activity names to name the activities in the data set

The file "activity_labels.txt" is read to obtain the names of the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) and their identifiers.

#### Step 4. Appropriately labels the data set with descriptive activity names.

4.1. Label activities

Data frame dfMergedSelection, containing the merged subject, activity and selected features data columns, is joined with the data frame containing the descriptive activity names. The activityId column is removed from the result. 

4.2. Recode features

The used feature names are rather technical and not very reader-friendly. To improve readibility feature names are recoded. It is done as follows, and applies to the selected set of features. Character vector featureNames2 holds the feature names as they undergo recoding.

* Variable recoding: Create data frame dfRecodeVariables, containing original feature name ("variable") and friendly feature name ("variable.friendly") . A third element, "description", is included but currently not used in the code. The data frame can be extended as needed. The elements contain patterns that are passed to the substitute functions gsub() and sub() as fixed text, replacing in each feature name occurrences of "variable" by "variable.friendly". 
* Additional variable recoding: Some features in the original raw data set contained obvious misspellings. These are renamed, i.e. BodyBody becomes Body. Initial t and f are renamed to "time" and "frequency", respectively.
* All variables are made compliant with R naming convention, using make.names(). Dots are removed and variable names are converted to lowercase.

#### Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Using the aggregate() function, the mean is calculated for the selected features. Subject and activity columns are excluded from aggregation. The subject and activity group columns output by the aggregate() function are labeled with "subject" and "activity". The generated tidy data frame is saved as comma-separated file and as tab-delimited file in the "merged" folder.

## History

19 May 2014: Creation.
25 May 2014: Updated, to comply with variable naming conventions as stated in Week 4 lecture on Editing Text Variables.
