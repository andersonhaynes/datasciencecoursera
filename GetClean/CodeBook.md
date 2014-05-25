Source:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - Universit√  degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition '@' smartlab.ws 
www.smartlab.ws 



Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Check the README.txt file for further details about this dataset.


Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


Data sets are read into R using the read.table function. Dataframes are 
then created.

Xtest <- read.table("~/UCI HAR Dataset/test/X_test.txt",header=FALSE)
Ytest <- read.table("~/UCI HAR Dataset/test/y_test.txt",header=FALSE)
Subtest <- read.table("~/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
Xtrain <- read.table("~/UCI HAR Dataset/train/X_train.txt",header=FALSE)
Ytrain <- read.table("~/UCI HAR Dataset/train/y_train.txt",header=FALSE)
SubTrain <- read.table("~/UCI HAR Dataset/train/subject_train.txt",header=FALSE)

Descriptive and relevant names are then loaded from the activity_labels.txt file
in order to replace the names found in the Ytest and Ytrain data frames. 

activities <- read.table("~/UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
Ytest$V1 <- factor(Ytest$V1,levels=activities$V1,labels=activities$V2)
Ytrain$V1 <- factor(Ytrain$V1,levels=activities$V1,labels=activities$V2)

Columns of each dataframe are then labeled  using  varaibles from the features.txt file.

features <- read.table("~/UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(Xtest)<-features$V2
colnames(Xtrain)<-features$V2
colnames(Ytest)<-c("Activity")
colnames(Ytrain)<-c("Activity")
colnames(Subtest)<-c("Subject")
colnames(SubTrain)<-c("Subject")

Activity and Subject columns are merged using into test and train data frames
to create a new dataframe. NeatData

Xtest<-cbind(Xtest,Ytest)
Xtest<-cbind(Xtest,Subtest)
Xtrain<-cbind(Xtrain,Ytrain)
Xtrain<-cbind(Xtrain,SubTrain)
NeatData<-rbind(Xtest,Xtrain)

Using the sapply function isued to calculate the means and standard deviations of the various measurements.

NeatData_mean<-sapply(NeatData,mean,na.rm=TRUE)
NeatData_sd<-sapply(NeatData,sd,na.rm=TRUE)

New data set is created along with the means and standard deviations
of the Subject and Activity fields.

DT <- data.table(NeatData)
clean<-DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(clean,file="cleandata.csv",sep=",",row.names = FALSE)


