Course Project on UCI HAR Dataset
========================

## Overview

Data from a Human Activity Recognition (HAR) study was processed as required for the Johns Hopkins (Coursera) "Getting and Cleaning Data" course project.  This document describes the process for creating the _tidy_ data set.   

The overall process involve these major tasks

* Reading and cleaning the data sets
* Combining the test and train data sets 
* Selecting a subset of mean standard deviation variables from the combined dataset
* Processing the data subset into a new "tidy" dataset
* Storing the results.

_Read the CODEBOOK.md file for more information on the data_

## File locations and other requirements

* The _run_analysis.R_ script may be executed in any directory, but it should have write privileges in that directory to allow sub directory creation.
* The _UCI_HAR_Dataset.zip_  file, if it exists, should be in the the same directory as run_analysis.R
* The script always extracts the UCI HAR dataset into the subdirectory _/UCI HAR Dataset_
* The script creates a single result file in the directory from which the script was executed.
* The script requires the plyr package
     

## Data Source

The _run_analysis.R_ script which processes the data is also capable of automatically downloading and unzipping the UCI HAR data set.  When the script is run one of two things will happen

* If the file _UCI_HAR_Dataset.zip_ exists, it will be unzipped
* If the file does not exists, it will be downloaded from the URL [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Data Preparation

#### Features
* The features.txt file was read and the features renamed to create the vector _features_
* In the process the feature names were made slightly more descriptive and more "R" compatible.
    * Punctuation, such as parenthesis, were removed or replaced
    * Names were modified to be more descriptive
        - As an example, the variable _tBodyAcc-mean()-X_ becomes _time.BodyAcc.mean.X_
        - Similarly for frequency domain variables: _fBodyGyro-mean()-Z_ becomes _freq.BodyGyro.mean.Z_
* Several features the UCI-HAR database do not have unique names.  However, it was not necessary to deal with these duplicate features as they aren't required in the tidy dataset.

#### Test and Train data X_Data
* The _X_train.txt_ and _X_test.txt_ files were processed as follows
* The cleaned-up feature names were used as column names for both the test and train data.
* The feature names were applied as the data files were read from disk. (Not as a separate step, as suggested in the project instructions)
* The test and train data sets were combined into a new variable called _har.dataSet_
* The data didn't require any further cleaning to deal with missing, or bad data.

#### Activity Data (Y)
* The activity_text file was loaded to obtain the six activity labels (e.g. "WALKING")
* The contents of  _y_train.txt_ and _y_test.txt_ activity files were read and combined into a new variable called _activities_
* Using the activity labels, _activities_ was remapped into a 6-level factor variable

#### Subjects
* The test and train subject data was read and combined into a variable called _subject_


#### Subsetting the data
The project instructions included a directive to _extract only the measurements on the mean and standard deviation for each measurement._  The standard deviation requirement was pretty clear.  However the UCI features.txt file contain three types of labels including the word mean.  Examples are:

* fBodyGyro-mean()-X
* fBodyGyro-meanFreq()-X
* angle(tBodyAccMean,gravity)

It seems reasonably obvious that the angle example doesn't need to be included.  At the risk of having too much data rather than too little.  Both mean() and meanFreq() types of variables are included in the final tidy dataset. All other variables (columns) were removed from _har.dataSet_.

Note: The meanFreq() variables may be removed, if desired, by simply uncommenting one line of code.

## Data Processing
#### Averaging by Subject and Activity
The course instructions for step 5 were to take the data set in step 4 (i.e. _har.dataSet_), and create a second, independent tidy data set with the average of each variable for each activity and each subject.

There are two possible ways to interpret this requirement:

1. Average for each activity and _for_ each subject
2. Average for each activity-subject pair.

Using feedback from one of the course TA's, the second interpretation was selected.

The processing steps to convert _har.dataSet_ into the tidy dataset _tidyMean.dataSet_ are:

* Use the R function _aggregate()_  to compute the mean of each column by subject-activity pairings.  
* Include columns to indicate the activity-subject pairing
* Save the results into a text file without the row names (original variable names)

## Tidy Dataset Output
#### Files
The _run_analysis.R_ script creates the following file in the script execution directory

* _tidyMean_DataSet.csv_ ---  a text file consisting of 180 observations over 81 variables (columns) with column names

