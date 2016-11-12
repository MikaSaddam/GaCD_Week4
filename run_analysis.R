

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
    testActivities <- read.table("data/test/y_test.txt")
    
    ## Get activity names:
    
    testSubjects <- read.table("data/test/subject_test.txt")
    observationType <- rep_len("test", nrow(testData))
    testData <- cbind(observationType, testSubjects, testLabels, testData)
    
    ## Fetch the train data, labels & subjects and join them:
    ## and add in an indicator for training:
    trainData <- read.table("data/train/X_train.txt")
    trainActvities <- read.table("data/train/y_train.txt")
    
    ## Get activity names:
    
    trainSubjects <- read.table("data/train/subject_train.txt")
    observationType <- rep_len("train", nrow(trainData))
    trainData <- cbind(observationType, trainSubjects, trainLabels, trainData)

    ## Merge the test and train data:
    mergedData <- rbind(testData, trainData)
    
    ## Get the column names:
    features <- read.table("data/features.txt", stringsAsFactors=FALSE)
    columnNames <- features$V2
    
    ## Logical Vector to keep only std and mean columns
    stdmeanColumns <- grepl("(std|mean[^F])", columnNames, perl=TRUE)
    
    ## Keep only data we want - including the first three columns, and name  
    ## them in a better way 
    mergedData <- mergedData[, c(TRUE, TRUE, TRUE, stdmeanColumns)]
    
    names(mergedData) <- c("ObservationType","Subject","Activity",
                        columnNames[stdmeanColumns])
    names(mergedData) <- gsub("\\(|\\)", "", names(mergedData))
    names(mergedData) <- tolower(names(mergedData))
    
    ## Now we have a clean data set - mergedData
    
    ## Write to csv:
    
    ##5 From the data set in step 4, creates a second, independent tidy data 
    ##  set with the average of each variable for each activity and each subject
    
    ##  Using dplyr for the summarisation:
    library(dplyr)
    
    ## Drop the Observation Type from the data set as it is not required for 
    ## this part of the process:
    mergedData <- mergedData[ , !(names(mergedData) %in% c("observationtype"))]
    
    sumData <- mergedData %>% 
                    group_by(activity, subject) %>% 
                        summarise_each(funs(mean))
    
    sumData
    
    ## Write to csv:
}



