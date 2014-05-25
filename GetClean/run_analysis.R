library(data.table)

#read data sets into R

Xtest <- read.table("~/UCI HAR Dataset/test/X_test.txt",header=FALSE)
Ytest <- read.table("~/UCI HAR Dataset/test/y_test.txt",header=FALSE)
Subtest <- read.table("~/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
Xtrain <- read.table("~/UCI HAR Dataset/train/X_train.txt",header=FALSE)
Ytrain <- read.table("~/UCI HAR Dataset/train/y_train.txt",header=FALSE)
SubTrain <- read.table("~/UCI HAR Dataset/train/subject_train.txt",header=FALSE)

activities <- read.table("~/UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
Ytest$V1 <- factor(Ytest$V1,levels=activities$V1,labels=activities$V2)
Ytrain$V1 <- factor(Ytrain$V1,levels=activities$V1,labels=activities$V2)

# Label columns
features <- read.table("~/UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(Xtest)<-features$V2
colnames(Xtrain)<-features$V2
colnames(Ytest)<-c("Activity")
colnames(Ytrain)<-c("Activity")
colnames(Subtest)<-c("Subject")
colnames(SubTrain)<-c("Subject")

# Merge data
Xtest<-cbind(Xtest,Ytest)
Xtest<-cbind(Xtest,Subtest)
Xtrain<-cbind(Xtrain,Ytrain)
Xtrain<-cbind(Xtrain,SubTrain)
NeatData<-rbind(Xtest,Xtrain)

# get mean and SD
NeatData_mean<-sapply(NeatData,mean,na.rm=TRUE)
NeatData_sd<-sapply(NeatData,sd,na.rm=TRUE)

# create new tidy data set
DT <- data.table(NeatData)
tidy<-DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy,file="tidy.csv",sep=",",row.names = FALSE)

