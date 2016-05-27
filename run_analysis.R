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
