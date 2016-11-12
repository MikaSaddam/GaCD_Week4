## Code Book for Course Project

### Overview

#### Source of the original data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is recordings of activities of a group of 30 volunteers aged 19 to 48 
years old. Each person performed six activities:

1 WALKING

2 WALKING_UPSTAIRS

3 WALKING_DOWNSTAIRS

4 SITTING

5 STANDING

6 LAYING

all while wearing a smartphone on the waist.

The data was recorded with the embedded accelerometer and gyroscope on the 
device. The obtained data was randomly partitioned into two sets, where 70% of 
the volunteers were selected for generating the training data and 30% the test 
data. 

#### Attribute Information:

For each record in the dataset is provided: 

- Its activity label. 
- An identifier of the subject who carried out the experiment.
- A 561-feature vector with time and frequency domain variables. 
    - Triaxial acceleration from the accelerometer (total acceleration) and the 
        estimated body acceleration. 
    - Triaxial Angular velocity from the gyroscope. 


### Process

The script `run_analysis.R` performs the following process to clean up the data
and create tiny data sets:

1.  Read data sets and combine

2.  Fetch the test data, labels & subjects and join them
    and add in an indicator for observation type ("test")

3.  Fetch the train data, labels & subjects and join them
    and add in an indicator for observation type ("training")

4.  Merge the test and train data

5.  Get the column names from "features.txt"
    
6.  Extract only the std and mean columns

7.  Keep only data we want - including the first three columns, and name  
    them in a better way 
    
8.  Merges in the activity_labels in order to replace the numeric representation
    of the activities with english named equivalents.

9.  Now we have a clean data set - mergedData

10  From the merged data set, creates a second, independent tidy data 
    set with the average of each variable for each activity and each subject
    excluding the observation type.
    
11. Uses the dplyr function summarise_each to do the clever multi-column summary


### Output

#### mergedData.csv

`mergedData.csv` is a data frame with 10299 observations and 69 variables.

- The 1st column contains the activity names.
- The 2nd column contains the observation type - "test" or "train".
- The 3rd column contains the subject Identifiers.
    - The Subject Identifiers are integers between 1 and 30.
- The last 66 columns are measurements.

#### sumData.csv

`sumData.csv` is a data frame with 180 observations and 68 variables.

- The 1st column contains the activity names.
- The 2nd column contains the subject Identifiers.
    - The Subject Identifiers are integers between 1 and 30.
- The averages for each of the 66 measurement attributes are in columns 3 to 68
