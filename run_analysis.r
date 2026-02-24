#First attempt at code file
library(dplyr)
library(readr)
library(data.table)

##This file does the following:
#########################################################################################################################################################
# 1. Merges the training and the test sets to create one data set.                                                                                      #                                                
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.                                                            #
# 3, Uses descriptive activity names to name the activities in the data set                                                                             #
# 4. Appropriately labels the data set with descriptive variable names.                                                                                 #        
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.     #
#########################################################################################################################################################

############ Read in Data From Zip File ###############################################################################################################

#Make data directory if one doesn't already exist
if(!file.exists("./data")) {dir.create("./data")}

#Create string with full path location of zip drive
zip_dir <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Create string with full path to location of directory where data will be extracted to
extract_dir <- "./data/extract/"

#Extract zip data to directory
#unzip(zip_dir, exdir = extract_dir)

#Create string with full path name of the new extracted folder
dirname <- list.files(extract_dir)
fullpath <- paste0(extract_dir,dirname,"/")
list.files(fullpath)
#Read in File that contains the list of features, or the column headings for the 561 measures provided in the training and test data sets
featurenames <- fread(paste0(fullpath,"features.txt"))
activitynames <- fread(paste0(fullpath,"activity_labels.txt"))
names(activitynames) <- c("activityid","activity")

########################, Combine Relevant Feature Data, Subject Data, Activity Data for Train and Test Datasets ################################################

#Identify relevant features - those that provide the mean() or standard deviation() of each base measurement. Keep the column indices of these features
colnums <- grep("mean\\()|std\\()",featurenames$V2)

#Read in Testing and Training Data. Note that each type of data has three component files: feature data, subject data, activity data.  
# All three datasets are ordered identically, and can be matched by order by simply binding columns

for (i in c("train","test")) {

#Specify path to either the test or the train data
path <- paste0(fullpath,i,"/")

#Read in the data file in the specified test or train data directory
featuredata <- fread(paste0(path,"X_",i,".txt"))

#Assign columnnames to the feature data using the previously read in feature names
names(featuredata) <- featurenames$V2

#Select desired columns of feature data using previously identified column numbers for only the mean() and std() columns of each measurement
featuredata <- featuredata %>% select(colnums)

#Read in subject data that matches the feature data
subjectcol <- fread(paste0(path,"subject_",i,".txt"))

#Name the column "subject"
names(subjectcol) <- "subject"

#Read in the activity data that matches the feature data
activitycol <- fread(paste0(path,"y_",i,".txt"))

#Name the column "activity"
names(activitycol) <- "activityid"

#Combine all three data sources: subject data, activity data, feature data using column bind. 
data <- cbind(subjectcol,activitycol,featuredata)

#Name the dataset either datatrain or datatest
assign(paste0("data",i),data)

#Delete temporary datasets no longer needed
rm(data) ; rm(subjectcol); rm(activitycol) ; rm(featuredata)
}
## Combine Training and Test Data Sets by stacking the traindata and testdata datasets
full_data <- rbind(datatrain,datatest)
rm(datatest); rm(datatrain); rm(featurenames)
## Split into two datasets by column, one with mean data and one with std data

mean_indices <- grep("(.*)mean\\()",names(full_data))
std_indices <- grep("(.*)std\\()",names(full_data))

mean_data <- full_data %>% select(c(1,2),all_of(mean_indices))
std_data <- full_data %>% select(c(1,2),all_of(std_indices))
rm(full_data)
##Reshape
melt_mean_data <- melt(mean_data,id=c("subject","activityid"),value.name="mean")
melt_std_data <- melt(std_data,id=c("subject","activityid"),value.name="std")
##Fix variable names to remove the reference to mean() and remove "_" and to make lowercase
melt_mean_data$variable <- tolower(gsub("-mean\\()|-","",melt_mean_data$variable))
melt_std_data <- melt_std_data %>% select(std)
#melt_std_data <- melt_std_data[,!(names(melt_std_data) %in% c("subject","activityid"))]
rm(mean_data) ; rm(std_data)

## Combine Mean and Std Datasets back to form one tidy data set
tidy_data <- cbind(melt_mean_data,melt_std_data)
tidy_data <- merge(tidy_data,activitynames,by.x="activityid",by.y="activityid",all.x=TRUE)
## Create an additional dataset that has the average mean and the average std. of each measure for each subject, activity pair
means_data <- tidy_data %>% group_by(subject,activity,variable) %>% summarize(avgmean = mean(mean),avgstd = mean(std))

#Remove datasets that are no longer needed
rm(melt_mean_data) ; rm(melt_std_data)