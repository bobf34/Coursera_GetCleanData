# Code Book

## Overview

Data from a Human Activity Recognition (HAR) study was processed as required for the Johns Hopkins (Coursera) "Getting and Cleaning Data" course project. This document describes the data sources, and the resultant "tidy" data set.   

_Read the README.md file for information on the data processing._

## UCI HAR Data Set Information
A database of acceleration and angular velocity data was collected for the purpose of training machine-learning models to recognize various human activities such as walking, sitting and laying.  The data was collected using inertial measurement units (IMU's) inside of a Samsung Galaxy SII cell phone.   More detailed information is available with the original data set which is stored on the UCI Machine Learning repository located at: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The raw XYZ acceleration and angular velocity data was augmented with new features. As an example, time-series data was converted into frequency-domain data and then further divided into various frequency bands.  Each dataset record contains the following:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* An activity label describing one of six activities such as walking, sitting, or laying.
* An identifier for each of the 30 subjects involved in the experiments

In preparation for training machine learning models, the data had already been separated into separate test and train data sets.

### Data Source
While the data is available at the link above, the data used for this project was downloaded from the URL specified in the project instructions: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  

The data was downloaded during the week of Nov 16th, 2015.

### Data Used 
The UCI data set contains a number of files, not all of which were used.  

General information files for human consumption:

* README.txt
* feaatures_info.txt

Information processed by the run_analysis.R script include:

* features.txt --- 561 variables
* activity_labels.txt -- 6 lables
* train/subject_train.txt --- 7352 rows
* train/X_train.txt --- 7352 rows
* train/y_train.txt --- 7352 rows
* test/subject_test.txt ---2947 
* test/X_test.txt --- 2947 rows
* test/y_test.txt --- 2947 rows

### Data Not Used 
None of the files in the directories "test/Intertial Signals" and "train/Inertial Signals" were used in this project.


## Tidy Dataset
#### Tidy Dataset Files

* _tidyMean_DataSet.txt_ ---  a space-separated text file consisting of 180 observations over 81 variables (columns) with column names

#### Tidy Dataset Description

Column Info

* activity (LAYING, SITTING, STANDING, WALKING, WALKING\_DOWNSTAIRS, WALKING\_UPSTAIRS )
* subject (1 to 30)
* Averaged signals:
    * A subset of 79 of the (renamed) original columns in the HAR dataset.  (See the README file for a description of the renaming process.) 
    * Row values are the mean value computed over the corresonding subject and activity.
    * In the variable listing below _XYZ_ indicates three variables one each for X, Y and Z.
* Units:
    * The time and frequency variables in this data set are unitless as they are the computed mean of unitless features within the UCI-HAR dataset (which are  normalized and bounded within [-1,1]).

VARIABLES
```
activity
subject 

time.BodyAcc.meanXYZ
time.BodyAcc.std.XYZ
time.GravityAcc.meanXYZ
time.GravityAcc.stdXYZ
time.BodyAccJerk.meanXYZ
time.BodyAccJerk.stdXYZ
time.BodyGyro.meanXYZ
time.BodyGyro.stdXYZ
time.BodyGyroJerk.meanXYZ
time.BodyGyroJerk.stdXYZ

time.BodyAccMag.mean
time.BodyAccMag.std
time.GravityAccMag.mean
time.GravityAccMag.std
time.BodyAccJerkMag.mean
time.BodyAccJerkMag.std
time.BodyGyroMag.mean
time.BodyGyroMag.std
time.BodyGyroJerkMag.mean
time.BodyGyroJerkMag.std

freq.BodyAcc.meanXYZ
freq.BodyAcc.stdXYZ
freq.BodyAccJerk.meanXYZ
freq.BodyAccJerk.stdXYZ
freq.BodyGyro.meanXYZ
freq.BodyGyro.stdXYZ

freq.BodyAccMag.mean
freq.BodyAccMag.std
freq.BodyBodyAccJerkMag.mean
freq.BodyBodyAccJerkMag.std
freq.BodyBodyGyroMag.mean
freq.BodyBodyGyroMag.std
freq.BodyBodyGyroJerkMag.mean
freq.BodyBodyGyroJerkMag.std
```


