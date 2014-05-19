## Step 1) Merges the training and the test sets to create one data set.

# Function file.copyAppend
# If fileTo does not exist: copies fileFrom to fileTo
# If fileTo exists: appends fileFrom to fileTo
file.copyAppend <- function(fileFrom, fileTo) {
    message(fileFrom, "->", fileTo)
    if (!file.exists(fileTo)) {
        file.copy(from=fileFrom, to=fileTo)
    }
    else {
        file.append(file1=fileTo, file2=fileFrom)
    }
}

# Function my.read.fwf
# Avoids memory issues with standard read.fwf
# Read file as a list of long lines, split each line into a vector, convert list to data frame  
my.read.fwf <- function (fileName) {
    # Fixed width file: determine line width and nr of rows
    fileWidth <- nchar(readLines(fileName))
    if (min(fileWidth) != max(fileWidth)) {
        message(fileName, " is not a fixed-width file; using read.csv instead.")
        df4 <- read.csv(fileName, header=FALSE, colClasses="numeric")
    }
    else {
        # Read file as a single column
        # Remove objects after use to free memory
        message("Reading ", fileName)
        print("Determine length ...")
        fileLines <- length(readLines(fileName))
        print("Read.fwf into single column ...")
        df1 <- read.fwf(fileName, nrows=fileLines, 
                        colClasses="character", 
                        widths=max(fileWidth))
        # Split column into multiple columns
        # This may introduce a new initial column that is empty
        print("Split columns ...")
        df2 <- strsplit(df1$V1, "\\s+")
        print("Convert to numeric ...")
        df3 <- lapply(df2, as.numeric)
        print("Convert to data frame ...")
        df3b <- matrix(unlist(df3),nrow=length(df3), byrow=TRUE)
        # Remove unused large objects and do garbage collection to return memory to OS
        remove(df1,df2,df3); gc()
        # Convert the matrix into a data frame and return result
        if (sum(is.na(df3b[,1])) == length(df3b[,1])) {
            # first column is empty
            df4 <- data.frame(df3b[,-1])
        }
        else {
            df4 <- data.frame(df3b)
        }
        remove(df3b); gc()
        df4
    }
}

message("Step 1")
# Create directory to contain merged files
dirData <- "./UCI Har Dataset"
dirMerged <- paste(dirData, "merged", sep="/")
if (!file.exists(dirData)) {
    stop("Folder not found: ", dirData)
}
if (!file.exists(dirMerged)) {
    dir.create(dirMerged)
}
setwd(dirMerged)
print(getwd())
lapply(list("../train/subject_train.txt", "../test/subject_test.txt"), 
       file.copyAppend, "subject_merged.txt")
lapply(list("../train/X_train.txt", "../test/X_test.txt"), 
       file.copyAppend, "X_merged.txt")
lapply(list("../train/y_train.txt", "../test/y_test.txt"), 
       file.copyAppend, "y_merged.txt")

# Read fixed-width files and convert to csv
# Subject
dfSubject <- my.read.fwf("subject_merged.txt")
colnames(dfSubject) <- "subject"
write.csv(dfSubject, "subject_merged.csv")
# Y
dfY <- my.read.fwf("y_merged.txt")
colnames(dfY) <- "activityId"
write.csv(dfY, "y_merged.csv")
# X
dfX <- my.read.fwf("X_merged.txt")
featureNames <- read.csv("../features.txt", sep=" ", header=FALSE)
colnames(dfX) <- featureNames$V2
write.csv(dfX, "X_merged.csv")

# Combine all into a single data frame and save
dfMerged <- cbind(dfSubject, dfY, dfX)
write.csv(dfMerged, "All_merged.csv")

## Step 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
message("Step 2")
featureSelection <- grepl("(^subject$|^activityId$|\\-(mean|std)\\(\\))",colnames(dfMerged), 
                          ignore.case=TRUE)
dfMergedSelection <- dfMerged[,featureSelection]

## Step 3) Uses descriptive activity names to name the activities in the data set
# get activity labels
message("Step 3")
activityLabels <- read.csv("../activity_labels.txt", sep=" ", header=FALSE, 
                           col.names=c("id","activity"))

## Step 4) Appropriately labels the data set with descriptive activity names. 
message("Step 4")
dfMergedSelection <- merge(dfMergedSelection, activityLabels, all.x=TRUE, all.y=FALSE, 
                           by.x="activityId", by.y="id")
# Remove activity nr, leaving just the activity name
dfMergedSelection <- dfMergedSelection[, -which(names(dfMergedSelection) %in% "activityId")]

# Recode labels
# Replace variables by friendly names
dfRecodeVariables <- data.frame(
    matrix(c(
        "mean()", "Mean", "Mean value",
        "std()", "StdDev", "Standard deviation",
        "mad()", "MedianAbsDev", "Median absolute deviation",
        "max()", "Max", "Largest value in array",
        "min()", "Min", "Smallest value in array",
        "sma()", "SignalMagnitudeArea", "Signal magnitude area",
        "energy()", "Energy", "Energy measure. Sum of the squares divided by the number of values",
        "iqr()", "Interquartile", "Interquartile range",
        "entropy()", "Entropy", "Signal entropy",
        "arCoeff()", "Autoregression", "Autorregresion coefficients with Burg order equal to 4",
        "correlation()", "Correlation", "correlation coefficient between two signals",
        "maxInds()", "MaxFrequencyComponent", "index of the frequency component with largest magnitude",
        "meanFreq()", "MeanFrequency", "Weighted average of the frequency components to obtain a mean frequency",
        "skewness()", "Skewness", "skewness of the frequency domain signal",
        "kurtosis()", "Kurtosis", "kurtosis of the frequency domain signal",
        "bandsEnergy()", "BandsEnergy", 
            "Energy of a frequency interval within the 64 bins of the FFT of each window",
        "angle()", "Angle", "Angle between to vectors",
        "Mag", "Magnitude", "",
        "Acc", "Accelleration", "Measured 3-axial linear acceleration using the embedded accellerometer",
        "Gyro", "Velocity", "Measured 3-axial angular velocity using the embedded gyroscope"
    ), ncol=3, byrow=TRUE))
colnames(dfRecodeVariables) <- c("variable", "variable.friendly", "description")

# recode variables to friendly names
featureNames2 <-as.character(colnames(dfMergedSelection))
for (i in 1:length(featureNames2)) {
    x <- featureNames2[i]
    for (j in 1:length(dfRecodeVariables$variable)) {
        x <- gsub(dfRecodeVariables[j,1], dfRecodeVariables[j,2], x, fixed=TRUE)
    };
    featureNames2[i] <- x
}
# other recodes
featureNames2 <- gsub("BodyBody", "Body", featureNames2) # label misspellings
featureNames2 <- sub("^t", "time.", featureNames2)  # initial t = time-based metric
featureNames2 <- sub("^f", "freq.", featureNames2)  # initial f = frequency-based metric
# cleanup for acceptable R names
featureNames2 <- make.names(featureNames2)          # strip illegal characters from names
featureNames2 <- gsub("\\.+", ".", featureNames2)   # replace repeated dots by a single one
featureNames2 <- sub("\\.$", "", featureNames2)     # strip trailing dot
colnames(dfMergedSelection) <- featureNames2

## step 5) Creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject. 
message("Step 5: aggregating data")
dfTidy <- aggregate(dfMergedSelection[,-which(names(dfMergedSelection) %in% c("subject", "activity"))],
                    by=list(dfMergedSelection$subject, dfMergedSelection$activity), 
                    mean)
colnames(dfTidy)[1:2]<-c("subject","activity")
# Save tidy file
fileName <- "All_tidy.csv"
write.csv(dfTidy, file=fileName, row.names=FALSE)
message("Saved to file ", fileName, " in folder ", dirMerged)
fileName <- "All_tidy.txt"
write.table(dfTidy, file=fileName, row.names=FALSE, sep="\t")
message("Saved to file ", fileName, " in folder ", dirMerged)
message("Ready.")
# Back to project folder
setwd("../..")
print(getwd())
