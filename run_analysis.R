rm(list = ls())
library(reshape2)
library(plyr)
library(dplyr)

getwd()
setwd("/users/prakhar/desktop")

if(!file.exists("coursera_project")){
  dir.create("coursera_project")
}

if(!file.exists("UCI HAR Dataset")){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  download.file(url, "./coursera_project/file.zip", method = "curl")
  setwd("/users/prakhar/desktop/coursera_project")
  unzip("file.zip")
  rm(url)
}
  

activity_label <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity_performed <- read.table("UCI HAR Dataset/test/y_test.txt")
new_table <- left_join(activity_performed,activity_label)
rm(activity_label)
rm(activity_performed)
activity_performed <- read.table("UCI HAR Dataset/test/X_test.txt")
names(activity_performed) <- features[,2]
subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
reqd_data <- activity_performed[, ]
as.character(names(activity_performed))
my <-activity_performed[ ,grep(".*mean.*|.*std.*", names(activity_performed))]
temp_names <- features[grep(".*mean.*|.*std.*", features[,2]),]
naming <- temp_names[,2]
my <- cbind(my,new_table)
my <- cbind(my,subject)
colnames(my) <- c(as.character(naming),"activity_num","activity_name", "subject")
my$activity_num <- NULL
rm(activity_performed)
rm(new_table)
rm(reqd_data)
rm(subject)
rm(temp_names)
rm(naming)
rm(features)

#for training data
activity_label1 <- read.table("UCI HAR Dataset/activity_labels.txt")
features1 <- read.table("UCI HAR Dataset/features.txt")
activity_performed1 <- read.table("UCI HAR Dataset/train/y_train.txt")
new_table <- left_join(activity_performed1,activity_label1)
rm(activity_label1)
rm(activity_performed1)
activity_performed <- read.table("UCI HAR Dataset/train/X_train.txt")
names(activity_performed) <- features1[,2]
subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
reqd_data <- activity_performed[, ]
as.character(names(activity_performed))
my1 <-activity_performed[ ,grep(".*mean.*|.*std.*", names(activity_performed))]
temp_names <- features1[grep(".*mean.*|.*std.*", features1[,2]),]
naming <- temp_names[,2]
my1 <- cbind(my1,new_table)
my1 <- cbind(my1,subject)
colnames(my1) <- c(as.character(naming),"activity_num","activity_name", "subject")
my1$activity_num <- NULL
rm(activity_performed)
rm(new_table)
rm(reqd_data)
rm(subject)
rm(temp_names)
rm(naming)
rm(features1)

#bind test and train data

final <- rbind(my,my1)
rm(my)
rm(my1)
write.table(final, "./reqd_data.txt")

