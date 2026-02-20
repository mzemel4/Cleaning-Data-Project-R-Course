#First attempt at code file
library(dplyr)
library(readr)
library(data.table)

#Make data directory if one doesn't already exist

if(!file.exists("./data")) {dir.create("./data")}

#Read in files from zip drive
zip_dir <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
extract_dir <- "./data/extract/"
#unzip(zip_dir, exdir = extract_dir)
dirname <- list.files(extract_dir)
fullpath <- paste0(extract_dir,newdir,"/")
featurenames <- fread(paste0(fullpath,"features.txt"))
colnums <- grep("mean\\()|std\\()",featurenames$V2)
trainpath <- paste0(fullpath,"train/")
featuredata <- fread(paste0(trainpath,"X_train.txt"))
names(featuredata) <- featurenames$V2
featuredata <- featuredata %>% select(colnums)
subjectcol <- fread(paste0(trainpath,"subject_train.txt"))
names(subjectcol) <- "subject"
activitycol <- fread(paste0(trainpath,"y_train.txt"))
names(activitycol) <- "activity"
traindata <- cbind(subjectcol,activitycol,featuredata)
