## Create and set project directory
dir.create(file.path("..","Desktop","UCI HAR Dataset"))
setwd(file.path("..","Desktop","UCI HAR Dataset"))

## Download and unzip project files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tf <- tempfile(pattern = "tf", tmpdir = tempdir(), fileext = ".zip")
download.file(url,tf)
files <- unzip(tf, junkpaths=TRUE)

## Read data
strain <- read.table("./subject_train.txt")
ytrain <- read.table("./y_train.txt")
xtrain <- read.table("./X_train.txt")
stest <- read.table("./subject_test.txt")
ytest <- read.table("./y_test.txt")
xtest <- read.table("./X_test.txt")

## Step 1: Merge the training and the test sets to create one data set
sraw <- rbind(strain, stest)
yraw <- rbind(ytrain, ytest)
xraw <- rbind(xtrain, xtest)
raw <- cbind(sraw, yraw, xraw)

## Step 2: Extract only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./features.txt", stringsAsFactors = FALSE)
xindices <- (grepl("-mean()",features[[2]]) & !grepl("-meanFreq()",features[[2]])) | grepl("-std()",features[[2]])
xdata <- xraw[,xindices]
## Later will combine subject, y, and x in Step 4 later

## Step 3: Use descriptive activity names to name the activities in the data set
actlabels <- read.table("./activity_labels.txt")
colnames(actlabels) <- c("activityID","activity")
colnames(yraw) <- "activityID"
ydata <- merge(x=yraw, y=actlabels, by="activityID", sort=FALSE)
## Later will combine subject, y, and x in Step 4 later

## Step 4: Appropriately label the data set with descriptive variable names.
colnames(sraw) <- "subjectID"
xnames <- features[xindices,2]
for (i in 1:length(xnames)) 
{
  xnames[i] = gsub("\\()","",xnames[i])
  xnames[i] = gsub("-std","StdDev",xnames[i])
  xnames[i] = gsub("-mean","Mean",xnames[i])
  xnames[i] = gsub("^t","time ",xnames[i])
  xnames[i] = gsub("^f","freq ",xnames[i])
  xnames[i] = gsub("[Bb]ody[Bb]ody|[Bb]ody","Body ",xnames[i])
  xnames[i] = gsub("[Gg]ravity","Gravity ",xnames[i])
  xnames[i] = gsub("[Aa]cc","Acc ",xnames[i])
  xnames[i] = gsub("[Gg]yro","Gyro ",xnames[i])
  xnames[i] = gsub("[Jj]erk","Jerk ",xnames[i])
  xnames[i] = gsub("[Mm]ag","Magnitude ",xnames[i])
}
colnames(xdata) <- xnames
data <- cbind(sraw,ydata["activity"],xdata)

## Step 5: From the data set in step 4, create a second, independent tidy data
## set with the average of each variable for each activity and each subject.
library(dplyr)
dtbl <- tbl_df(data) 
tidydata <- dtbl %>% group_by(activity,subjectID) %>% summarize_all(funs(mean))
write.table(tidydata, file = "tidydata.txt", row.names = FALSE, col.names = TRUE)

