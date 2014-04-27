## Read in data
trainLabels <- read.table("train\\y_train.txt")
trainSubjects <- read.table("train\\subject_train.txt")
trainX <- read.table("train\\x_train.txt")
testLabels <- read.table("test\\y_test.txt")
testSubjects <- read.table("test\\subject_test.txt")
testX <- read.table("test\\x_test.txt")
activityLabels <- read.table("activity_labels.txt")[,2]
columns <- read.table("features.txt")[,2]
columns <- as.character(columns)
dim(columns) <- c(1,561)
columns <- cbind(columns, c("Subject"), c("Activity"))
f<- function(s) {activityLabels[s]}
trainLabels <- sapply(trainLabels, f)
testLabels <- sapply(testLabels, f)
trainData <- cbind(trainX, trainSubjects, trainLabels)
testData <- cbind(testX, testSubjects, testLabels)
myData <- rbind(trainData, testData)
names(myData) <- columns

## Filter to take in only means and SDs
myData <- myData[,(grep("(.*-mean\\(\\)$)|(.*-std\\(\\)$)|Subject|Activity",names(myData)))]
avgsd <- sapply(split(myData[,1:18],list(myData$Subject,myData$Activity)), colMeans)
write.table(avgsd,file="averages.txt")
