setwd("/home/bobc/DataScience/GetCleanData/CourseProject")
require(plyr)

#download and unzip the original dataset and unzip
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
localFilename = "UCI_HAR_Dataset.zip"
if (!file.exists(localFilename)){
  cat("Downloading the dataset zip file...")
  download.file(url,destfile = localFilename )
  cat("Done!\n")
}

# Unzip the file if it exists
if (file.exists(localFilename)) {
  cat("Unzipping the dataset file...")
  unzip(localFilename, overwrite=TRUE) 
  cat("Done!\n")
  
} else {
   stop("Error: Unable to find zip file")
}


# set the working directory to the UCI dir created during the unzip
setwd("./UCI HAR Dataset")

## Read the activity labels and make sure that they're in ascending order
activity_labels <- read.table("activity_labels.txt", col.names = c("activity", "activityLabel"))
activity_labels <- activity_labels[order(activity_labels$activity),]

## Read features names.  Ignore duplicate variable names
features <- read.table("features.txt", as.is=T, col.names = c("featureNumber", "featureName"))$featureName

# clean up the feature names to make them more R friendly, don't worry about columns that will be cut later
features <- gsub("\\(+\\)+-",".",features)  # change "()-" to a period
features <- gsub("\\(+\\)",".",features)     # change "()" to a period
features <- gsub("\\.$","",features)         # get rid of periods on the end
features <- gsub("\\,", ".", features)       # replace comma's with periods
features <- gsub("^f","freq.",features)      # make the frequency variables more readable
features <- gsub("^t","time.",features)      # make the time variables more readable

## Read the train and test  data attaching the features as labels for each column
# add a new column with a descriptive label for the activity of that row
X_train <- read.table("train/X_train.txt", col.names = features)
X_test  <- read.table("test/X_test.txt", col.names = features)

## Merge the test and train data
har.dataSet <- rbind(X_train,X_test)

## Create the activity labels from the original y data in the dataset

## Merge the the y train and test data into numeric 'activities'
# read the test and train y data and assign it a more descriptive variable name of 'activity'
y_train <- read.table("train/y_train.txt", col.names = "activity")
y_test  <- read.table("test/y_test.txt", col.names = "activity" )
activities <- rbind(y_train,y_test)$activity

# replace the activity number with a descriptive label.  
activities <- activity_labels$activityLabel[ activities]

## Read the train and test subject data and bind in the same order as for the data set
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
subject_test  <- read.table("test/subject_test.txt", col.names = "subject")
subject = rbind(subject_train, subject_test)


# Extract the mean and std measurements keeping the descriptive activities column 
# Note 1: Intentionally not including columns like 'angle(tBodyAccMean,gravity)'
# Note 2: None of the duplicate features survive this nex step, so they don't need to be dealt with

# start with all of the variables that include lower-case mean and std
meanStdColNames <- names(har.dataSet)[grep('(mean|std)',names(har.dataSet))]

# Uncomment the line to remove variables of the form  *meanFreq()*
# meanStdColNames = meanStdColNames[grep('meanFreq',meanStdColNames, invert=T)]

#Subset the data
har.dataSet = subset(har.dataSet, select= c(meanStdColNames))
                 

## From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.

# Average each pairing of subject and activity
tidyMean.dataSet <-aggregate(har.dataSet, by=list(activities,subject$subject),FUN=mean)

# Rename the columns created by aggregate
tidyMean.dataSet <- plyr::rename(tidyMean.dataSet, replace=c("Group.1" = "activity", "Group.2" = "subject"))
                                                      
# The tidy data set is now complete.
setwd("../")
write.csv(tidyMean.dataSet, file="tidyMean_DataSet.csv", row.names = FALSE)

cat("All Done!")
