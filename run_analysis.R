## Clear Environement

rm(list = ls())

## Load packages

library("matrixStats")
library("plyr")
library("dplyr")

## Load train subject, label and data

train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_label <- read.table("UCI HAR Dataset/train/y_train.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")

## Load test subject, label and data
 
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_label <- read.table("UCI HAR Dataset/test/y_test.txt")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")

## Load features names

features<- read.table("UCI HAR Dataset/features.txt")
features_names <- features$V2

## Select only mean and std columns

mstd <- grep("(mean|std)",features_names)
mstd_names <- features_names[mstd]
mstd_names <- gsub("()","",mstd_names,fixed=TRUE)

test_data_mstd <- test_data[,mstd]
train_data_mstd <- train_data[,mstd]

## C-bind test and train to full data sets, and r-bind to complete dataset

test_full <- cbind(test_subject,test_label,test_data_mstd)
train_full <- cbind(train_subject,train_label,train_data_mstd)

names(test_full) <- c("subjetID","activityID",mstd_names)
names(train_full) <- c("subjetID","activityID",mstd_names)

data_full <- rbind(train_full,test_full)
data_full <- arrange(data_full,data_full$subjetID)

## Transform "activityID" to factor and change labels

data_full$activityID <- as.factor(data_full$activityID)
data_full$activityID <- revalue(data_full$activityID,c("1"="WALKING","2"="WALKING_UP","3"="WALKING_DOWN","4"="SITTING","5"="STANDING","6"="LAYING"))

## Group_by subjectID and activityID and summarize

data_group <- group_by(data_full,data_full$subjetID,data_full$activityID)
data_sum <- as.data.frame(summarise_all(data_group,mean))
data_sum <- data_sum[-c(3,4)]
data_sum <- rename(data_sum, subjectID = `data_full$subjetID`, activityID = `data_full$activityID`)
