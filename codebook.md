# Code Book

This code describes how to use the script **run_analysis.R** to combine, streamline, label, and summarize the original data set into **tidydata.txt**.

## Pre-cleaning Steps
#### 1. Create and set the project directory
#### 2. Download the raw data set to a temporary file, then extract files to project directory
#### 3. Read in R the following data:
  + **subject_train.txt** - identifies the subjects who performed the activity for each record for the training set
  + **y_train.txt** - identifies the activity for each record of the training set
  + **X_train.txt** - data for all 561-feature measurements for each record in the training set
  + **subject_test.txt** - identifies the subjects who performed the activity for each record for the test set
  + **y_test.txt** - identifies the activity for each record of the test set
  + **X_test.txt** - data for all 561-feature measurements for each record in the test set

## Cleaning Steps:
#### 1. Merge the *training* and *test* sets to create one data set
  + Merge the *training* and *test* records of **subject**, **y**, and **X** data sets using rbind
  + Match the subject to the activity to the data by using cbind on the *merged* **subject**, **y**, and **X** data sets

#### 2. Extract only the measurements on the mean and standard deviation for each measurement
  + Read in R **features.txt** which describes the measurements in **X**
  + Determine the indices of **features** that  contains mean and standard deviations of measurements (a total of 66 indices will be returned)
  + Streamline the *merged* **X** data in step 1a using the indices; this will be the *new* **X** data

#### 3. Use descriptive activity names to name the activities in the data set
  + Read in R **activity_labels.txt** which describes the activities represented as integers in **y**; label its variables as *activityID* for the integers and *activity* for the actual activity being done
  + Label the *merged* **y** data in step 1b with *activityID*
  + Use merge() by *activityID* to match the appropriate **activity label** to the integers in **y**

#### 4. Appropriately label the data set with descriptive variable names
  + Label the *merged* **subject** data in step 1b with *subjectID*
  + Create **xnames**, a character vector which will be used as variable names for the *merged* and *streamlined* **X** data in step 2c. This vector will be produced by streamlining **features** using the same indices used to streamline the **X** data in step 2
  + Make the variables in **xnames** be more readable by using gsub - eliminate "()" at the end of each line; rewrite std, mean, and mag as StdDev, Mean, and Magnitude; expand t and f to time and freq, respectively; eliminate duplicating words; add space in between each relevant word
  + Use **xnames** as label to the *merged* and *streamlined* **X** data in step 2c
  + Combine the *streamlined* data by using cbind on the *merged* **subject** data in step 1b, the *activity* variable in the *merged* **y** data in step 3c, and the *streamlined* and *labeled* **X** data in step 4d

#### 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
  + Load the dplyr package
  + Convert the *combined* data frame in step 4c into a data frame tbl
  + Group the data into *activity* and *subject ID* using group_by ()
  + Summarize the grouped data by taking the each of the streamlined measurements' average per unique subjectID-activity combination (35 unique combinations in total)
  + Export the *summarized data frame tbl* into **tidydata.txt**
  + The summarized data will have 35 records of unique *subjectID-activity* combinations and 68 variables - one for *subjectID*, one for *activity*, and 66 for the mean and standard deviation measurements
