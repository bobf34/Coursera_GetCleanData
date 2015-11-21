Course Project on UCI HAR Dataset
========================

## Overview

Data from a Human Activity Recognition (HAR) study was processed as required for the Johns Hopkins (Coursera) "Getting and Cleaning Data" course project.  This document describes the process for creating the _tidy_ data set.   

The overall process involves these major tasks:

* Reading and cleaning the data sets
* Combining the test and train data sets 
* Selecting a subset of mean standard deviation variables from the combined dataset
* Processing the data subset into a new "tidy" dataset
* Storing the results.

_Read the CodeBook.md file for more information on the data_

## File locations and other requirements

* The _UCI_HAR_Dataset.zip_  file, if it exists, should be in the the same directory as _run_analysis.R_.
* The _run_analysis.R_ script:
    * May be executed in any directory, but requires write privileges in that directory to allow unzipping.
    * Always extracts the UCI HAR dataset into the subdirectory _./UCI HAR Dataset_.
    * Overwrites any previous extractions.
    * Creates a single result file in the directory from which the script was executed.
    * Requires the plyr package.
     

## Data Source

The _run_analysis.R_ script is capable of automatically downloading and unzipping the UCI HAR data set.  When the script is run one of two things will happen:

* If the file _UCI_HAR_Dataset.zip_ exists, it will be unzipped
* If the file does not exists, before unzipping it will first be downloaded from the URL: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Data Preparation

#### Features
* The features.txt file is read and the features renamed to create the vector _features_
* In the process the feature names are made slightly more descriptive and more "R" compatible.
    * Punctuation, such as parenthesis, are removed or replaced
    * Names are modified to be more descriptive
        - As an example, the variable _tBodyAcc-mean()-X_ becomes _time.BodyAcc.mean.X_
        - Similarly for frequency domain variables: _fBodyGyro-mean()-Z_ becomes _freq.BodyGyro.mean.Z_
* Several features the UCI-HAR database do not have unique names.  However, it was not necessary to deal with these duplicate features as they aren't required in the tidy dataset.

#### Test and Train data X_Data
The _X_train.txt_ and _X_test.txt_ files are processed as follows:

* The cleaned-up feature names are used as column names for both the test and train data.
* The feature names are applied as the data files are read from disk. (not as a separate step, as suggested in the project instructions).
* The test and train data sets are combined into a new variable called _har.dataSet_.
* The data set did not require any further cleaning to deal with missing, or bad data.

#### Activity Data (Y)
* The activity_text file is read to obtain the six activity labels (e.g. "WALKING").
* The contents of _y_train.txt_ and _y_test.txt_ activity files are read and combined into a new variable called _activities_.
* Using the activity labels, _activities_ is remapped into a descriptive six-level factor variable.

#### Subjects
* The test and train subject data are read and combined into a variable called _subject_


#### Subsetting the data
The project instructions included a directive to _extract only the measurements on the mean and standard deviation for each measurement._  The standard deviation requirement was pretty clear.  However the UCI features.txt file contain three types of labels including the word mean.  Examples are:

* fBodyGyro-mean()-X
* fBodyGyro-meanFreq()-X
* angle(tBodyAccMean,gravity)

It seems reasonably obvious that the angle example doesn't need to be included as the name indicates that it is a function of a mean variable, and not necessarily a mean variable itself.  At the risk of having too much data rather than too little, both mean() and meanFreq() types of variables are included in the final tidy dataset. All other variables (columns) are removed from _har.dataSet_.

Note: The meanFreq() variables may be removed, if desired, by simply uncommenting one line of code.

## Data Processing
#### Averaging by Subject and Activity
The course instructions for step 5 were to take the data set in step 4 (i.e. _har.dataSet_), and create a second, independent tidy data set with the average of each variable for each activity and each subject.

There are two possible ways to interpret this requirement:

1. Average for each activity and _for_ each subject.
2. Average for each activity-subject pair.

Using feedback from one of the course TA's, the second interpretation was selected.

The processing steps to convert _har.dataSet_ into the tidy dataset _tidyMean.dataSet_ are:

* Use the R function _aggregate()_  to compute the mean of each column by subject-activity pairings.  
* Include columns to indicate the activity-subject pairing.
* Save the results into a text file without the row names.

## Tidy Dataset Output
The _run_analysis.R_ script creates the following file in the script execution directory:

* _tidyMean_DataSet.txt_ , a space-separated text file that contains:
    * 180 observations (rows)
    * 81 variables (columns)
    * Column names
    
By uncommenting one line, the file can also generate a csv file, which is easier to read in github.  A sample of this output is included in the github repository.
