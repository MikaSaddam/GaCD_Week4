

processData <- function() 
{
    ###########################################################################
    ## 1 Merges the training and the test sets to create one data set.       ##
    ## 2 Extracts only the measurements on the mean and standard deviation   ## 
    ##   for each measurement.                                               ##
    ## 3 Uses descriptive activity names to name the activities in the data  ##
    ##   set                                                                 ##
    ## 4 Appropriately labels the data set with descriptive variable names.  ##
    ###########################################################################

    ## Read data sets and combine
    ## First check that the data folder exists:
    if (!file.exists("data")) 
    { 
        stop("Data folder not found!")
    }
    
    ## Fetch the test data, labels & subjects and join them:
    ## and add in an indicator for test:
    testData <- read.table("data/test/X_test.txt")
    testLabels <- read.table("data/test/y_test.txt")
    testSubjects <- read.table("data/test/subject_test.txt")
    testOrTrainTags <- rep_len("test", nrow(testData))
    testData <- cbind(testOrTrainTags, testSubjects, testLabels, testData)
    
    ## Fetch the train data, labels & subjects and join them:
    ## and add in an indicator for training:
    trainData <- read.table("data/train/X_train.txt")
    trainLabels <- read.table("data/train/y_train.txt")
    trainSubjects <- read.table("data/train/subject_train.txt")
    testOrTrainTags <- rep_len("train", nrow(trainData))
    trainData <- cbind(testOrTrainTags, trainSubjects, trainLabels, trainData)

    ## Merge the test and train data:
    
    theData <- rbind(testData, trainData)
    
    ## Get the column names:
    features <- read.table("data/features.txt", stringsAsFactors=FALSE)
    columnNames <- features$V2
    
    ## Logical Vector to keep only std and mean columns
    stdmeanColumns <- grepl("(std|mean[^F])", columnNames, perl=TRUE)
    
    ## Keep only data we want - including the first three columns, and name  
    ## them in a better way 
    theData <- theData[, c(TRUE, TRUE, TRUE, stdmeanColumns)]
    
    names(theData) <- c("TestOrTrain","Subjects","Labels",
                        columnNames[stdmeanColumns])
    names(theData) <- gsub("\\(|\\)", "", names(theData))
    names(theData) <- tolower(names(theData))

    theData
}




##5 From the data set in step 4, creates a second, independent tidy data set with the average
##  of each variable for each activity and each subject.