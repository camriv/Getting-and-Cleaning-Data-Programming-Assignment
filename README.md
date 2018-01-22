# Getting and Cleaning Data Programming Assignment
Files for Week 4 Programming Assignment

## Human Activity Recognition Using Smartphones Dataset  - Tidy Version
This version includes the following additional files:
- 'README.md' - updated to describe additional files to the tidy version of this dataset
- 'run_analysis.R' - script to produce the tidy data
- 'codebook.md' - describes the data cleaning script to produce the tidy data
- 'tidydata.txt' - the cleaned data

This describes how to use the script **run_analysis.R** to combine, streamline, label, and summarize the original data set into **tidydata.txt**.

### Pre-cleaning Steps
1. Create and set the project directory
2. Download the raw data set to a temporary file, then extract files to project directory
3. Read in R the following data:
  + **subject_train.txt** - identifies the subjects who performed the activity for each record for the training set
  + **y_train.txt** - identifies the activity for each record of the training set
  + **X_train.txt** - data for all 561-feature measurements for each record in the training set
  + **subject_test.txt** - identifies the subjects who performed the activity for each record for the test set
  + **y_test.txt** - identifies the activity for each record of the test set
  + **X_test.txt** - data for all 561-feature measurements for each record in the test set

### Cleaning Steps:
1. Merge the *training* and *test* sets to create one data set
  + Merge the *training* and *test* records of **subject**, **y**, and **X** data sets using rbind
  + Match the subject to the activity to the data by using cbind on the *merged* **subject**, **y**, and **X** data sets

2. Extract only the measurements on the mean and standard deviation for each measurement
  + Read in R **features.txt** which describes the measurements in **X**
  + Determine the indices of **features** that  contains mean and standard deviations of measurements (a total of 66 indices will be returned)
  + Streamline the *merged* **X** data in step 1a using the indices; this will be the *new* **X** data

3. Use descriptive activity names to name the activities in the data set
  + Read in R **activity_labels.txt** which describes the activities represented as integers in **y**; label its variables as *activityID* for the integers and *activity* for the actual activity being done
  + Label the *merged* **y** data in step 1b with *activityID*
  + Use merge() by *activityID* to match the appropriate **activity label** to the integers in **y**

4. Appropriately label the data set with descriptive variable names
  + Label the *merged* **subject** data in step 1b with *subjectID*
  + Create **xnames**, a character vector which will be used as variable names for the *merged* and *streamlined* **X** data in step 2c. This vector will be produced by streamlining **features** using the same indices used to streamline the **X** data in step 2
  + Make the variables in **xnames** be more readable by using gsub - eliminate "()" at the end of each line; rewrite std, mean, and mag as StdDev, Mean, and Magnitude; expand t and f to time and freq, respectively; eliminate duplicating words; add space in between each relevant word
  + Use **xnames** as label to the *merged* and *streamlined* **X** data in step 2c
  + Combine the *streamlined* data by using cbind on the *merged* **subject** data in step 1b, the *activity* variable in the *merged* **y** data in step 3c, and the *streamlined* and *labeled* **X** data in step 4d

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
  + Load the dplyr package
  + Convert the *combined* data frame in step 4c into a data frame tbl
  + Group the data into *activity* and *subject ID* using group_by ()
  + Summarize the grouped data by taking the each of the streamlined measurements' average per unique subjectID-activity combination (35 unique combinations in total)
  + Export the *summarized data frame tbl* into **tidydata.txt**
  + The summarized data will have 35 records of unique *subjectID-activity* combinations and 68 variables - one for *subjectID*, one for *activity*, and 66 for the mean and standard deviation measurements



### Original Data from:
#### Human Activity Recognition Using Smartphones Dataset (Version 1.0)
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Università degli Studi di Genova  
Via Opera Pia 11A, I-16145, Genoa, Italy  
activityrecognition@smartlab.ws  
www.smartlab.ws  

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

### Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

### License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
