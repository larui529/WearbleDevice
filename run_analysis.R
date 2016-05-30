# 
# Author: Rui La <larui529@gmail.com>
#
# Note: this code can be run on Mac OSX
#

## download zip file from internet
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "UCIData.zip"
#check if the file is exist
if (!file.exists(fileName)) {
  message ("downloading file")
  download.file(fileURL, destfile = "UCIData.zip", method = "curl")
}
fileName2 <- "UCI.txt"
## unzip the file
if (!file.exists(fileName2)) {
  message ("unzip the file")
  unzip(zipfile = "UCIData.zip")
  
}
##read files from unzipped file
testX <- read.table("./UCI HAR Dataset/test/X_test.txt", sep = "",header= FALSE)
testY <- read.table("./UCI HAR Dataset/test/Y_test.txt", sep = "",header= FALSE)
trainX <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "",header= FALSE)
trainY <- read.table("./UCI HAR Dataset/train/Y_train.txt", sep = "",header= FALSE)
testS <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = "",header= FALSE)
trainS <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = "",header= FALSE)

features <- read.table( "./UCI HAR DATAset/features.txt", sep = "", header = FALSE)
##define names of each variables
names (testX) <- features [,2]
names (trainX) <- features [,2]
names (testY) <- "Class_Label"
names (trainY) <- "Class_Label"
names (testS) <- "SubjectID"
names (trainS) <- "SubjectID"

##Merge test and train data together
xData <- rbind(testX, trainX)
yData <- rbind (testY, trainY)
sData <- rbind (testS, trainS)
##create a big table of data
data <- cbind (xData, yData, sData)


IndexFeature <- grep ("mean|std|Class|Subject",names(data),value = TRUE)
data <- data[,IndexFeature]

##Using descriptive activity names to name the activities in data set

activityNames <- read.table("./UCI HAR Dataset/activity_labels.txt")
data <- merge (data, activityNames, by.x = "Class_Label", by.y = "Class_Label")


##Appropriately labels the data set with descriptive variable names.

names(data) <- gsub(pattern="[()]", replacement="", names(data))
names(data) <- gsub(pattern="[-]", replacement="_", names(data))
data <- data[,!(names(data) %in% c("Class_Label"))]



##From the data set in step 4, creates a second, independent tidy data 
##set with the average of each variable for each activity and each subject.

library(reshape2)
meltdataset <- melt(data=data, id=c("SubjectID", "Class_Name"))
tidyData <- dcast(data=meltdataset, SubjectID + Class_Name ~ variable, mean)
write.csv(tidyData, file="TidyDataSet.txt", row.names=FALSE)