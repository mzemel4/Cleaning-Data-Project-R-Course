## **Code book for means_data dataset**

### Dataset Basic Information
This is a codebook for the means_data dataset. The dataset contains 5940 rows and 5 variables (subject,activity,variable,avgmean, and avgstd).  

### Source Data and Processing
The dataset was created from the "Human Activity Recognition Using Smartphones" project of UCI. Information about this data can be found at the following link: 
[HAR UCI Link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  The dataset contains summary information on smartphone accelerometer data, measured on 30 individuals while they were engaged in six types of activities.
33 different components of the accelerator measurements (acceleration and velocity in three dimensions) were recorded at several points in time for each individual.  The base data used in this analysis is the mean and std deviation of each of the 33 measurements in a given window.  

The means_data dataset provides the *average* mean and *average* standard deviation of each measure averages over a given subject-activity pair.

### Variables

**subject**: ID of subject, integer value from 1 - 30.

**activity**: Name of activity performed, string variable with the following values:

* LAYING
* SITTING
* STANDING
* WALKING
* WALKING_DOWNSTAIRS
* WALKING_UPSTAIRS

**variable**: variable measured, given component of accelerometer measurement, across both the time (t) and frequency (f) domains and measured in the x,y, and z planes.  String variable with 33 different values:

* fbodyaccjerkx
* fbodyaccjerky        
* fbodyaccjerk
* fbodyaccmag
* fbodyaccx
* fbodyaccy
* fbodyaccz
* fbodybodyaccjerkmag
* fbodybodygyrojerkmag
* fbodybodygyromag
* fbodygyrox
* fbodygyroy
* fbodygyroz
* tbodyaccjerkmag
* tbodyaccjerkx
* tbodyaccjerky
* tbodyaccjerkz
* tbodyaccmag
* tbodyaccx
* tbodyaccy
* tbodyaccz
* tbodygyrojerkmag
* tbodygyrojerkx
* tbodygyrojerky
* tbodygyrojerkz
* tbodygyromag
* tbodygyrox
* tbodygyroy
* tbodygyroz
* tgravityaccmag
* tgravityaccx
* tgravityaccy
* tgravityaccz

**avgmean**: average of mean variable measurement for a given subject and activity pair, averaged over all time windows 

**avgstd**: average of std. deviation of variable measurements for a given subject and activity pair, averaged over all time windows