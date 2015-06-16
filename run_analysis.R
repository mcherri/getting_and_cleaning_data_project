# Load required libraries.
library(dplyr)

# Define some useful utility functions

# readAndMergeDataSet read and merge one or more data sets into a signle data
# set given that each data set contains the same number of columns and
# corresponding columns in each data set has the same type. example usage:
#   > merged <- readAndMergeDataSet("file1.txt", "file2.txt")
readAndMergeDataSet <- function(...) {
    do.call(rbind, lapply(list(...), read.table))
}

# Define some constants
dataSetFileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
extractedDirectory <- "UCI HAR Dataset"
trainingSetFile <- file.path(extractedDirectory, "train", "X_train.txt")
trainingLabelsFile <- file.path(extractedDirectory, "train", "y_train.txt")
trainingSubjectFile <- file.path(extractedDirectory, "train", "subject_train.txt")
testSetFile <- file.path(extractedDirectory, "test", "X_test.txt")
testLabelsFile <- file.path(extractedDirectory, "test", "y_test.txt")
testSubjectFile <- file.path(extractedDirectory, "test", "subject_test.txt")
activityLabelsFile <- file.path(extractedDirectory, "activity_labels.txt")
featuresFile <- file.path(extractedDirectory, "features.txt")
outputFile <- file.path("tidy_data.txt")
variableNames <- c("TimeMeanOfBodyAccelerationInX",
                   "TimeMeanOfBodyAccelerationInY",
                   "TimeMeanOfBodyAccelerationInZ",
                   "TimeStandardDeviationOfBodyAccelerationInX",
                   "TimeStandardDeviationOfBodyAccelerationInY",
                   "TimeStandardDeviationOfBodyAccelerationInZ",
                   "TimeMeanOfGravityAccelerationInX",
                   "TimeMeanOfGravityAccelerationInY",
                   "TimeMeanOfGravityAccelerationInZ",
                   "TimeStandardDeviationOfGravityAccelerationInX",
                   "TimeStandardDeviationOfGravityAccelerationInY",
                   "TimeStandardDeviationOfGravityAccelerationInZ",
                   "TimeMeanOfBodyAccelerationDerivativeInX",
                   "TimeMeanOfBodyAccelerationDerivativeInY",
                   "TimeMeanOfBodyAccelerationDerivativeInZ",
                   "TimeStandardDeviationOfBodyAccelerationDerivativeInX",
                   "TimeStandardDeviationOfBodyAccelerationDerivativeInY",
                   "TimeStandardDeviationOfBodyAccelerationDerivativeInZ",
                   "TimeMeanOfBodyAngularVelocityInX",
                   "TimeMeanOfBodyAngularVelocityInY",
                   "TimeMeanOfBodyAngularVelocityInZ",
                   "TimeStandardDeviationOfBodyAngularVelocityInX",
                   "TimeStandardDeviationOfBodyAngularVelocityInY",
                   "TimeStandardDeviationOfBodyAngularVelocityInZ",
                   "TimeMeanOfBodyAngularVelocityDerivativeInX",
                   "TimeMeanOfBodyAngularVelocityDerivativeInY",
                   "TimeMeanOfBodyAngularVelocityDerivativeInZ",
                   "TimeStandardDeviationOfBodyAngularVelocityDerivativeInX",
                   "TimeStandardDeviationOfBodyAngularVelocityDerivativeInY",
                   "TimeStandardDeviationOfBodyAngularVelocityDerivativeInZ",
                   "TimeMeanOfBodyAccelerationMagnitude",
                   "TimeStandardDeviationOfBodyAccelerationMagnitude",
                   "TimeMeanOfGravityAccelerationMagnitude",
                   "TimeStandardDeviationOfGravityAccelerationMagnitude",
                   "TimeMeanOfBodyAccelerationDerivativeMagnitude",
                   "TimeStandardDeviationOfBodyAccelerationDerivativeMagnitude",
                   "TimeMeanOfBodyAngularVelocityMagnitude",
                   "TimeStandardDeviationOfBodyAngularVelocityMagnitude",
                   "TimeMeanOfBodyAngularVelocityDerivativeMagnitude",
                   "TimeStandardDeviationOfBodyAngularVelocityDerivativeMagnitude",
                   "FrequencyMeanOfBodyAccelerationInX",
                   "FrequencyMeanOfBodyAccelerationInY",
                   "FrequencyMeanOfBodyAccelerationInZ",
                   "FrequencyStandardDeviationOfBodyAccelerationInX",
                   "FrequencyStandardDeviationOfBodyAccelerationInY",
                   "FrequencyStandardDeviationOfBodyAccelerationInZ",
                   "FrequencyMeanOfBodyAccelerationDerivativeInX",
                   "FrequencyMeanOfBodyAccelerationDerivativeInY",
                   "FrequencyMeanOfBodyAccelerationDerivativeInZ",
                   "FrequencyStandardDeviationOfBodyAccelerationDerivativeInX",
                   "FrequencyStandardDeviationOfBodyAccelerationDerivativeInY",
                   "FrequencyStandardDeviationOfBodyAccelerationDerivativeInZ",
                   "FrequencyMeanOfBodyAngularVelocityInX",
                   "FrequencyMeanOfBodyAngularVelocityInY",
                   "FrequencyMeanOfBodyAngularVelocityInZ",
                   "FrequencyStandardDeviationOfBodyAngularVelocityInX",
                   "FrequencyStandardDeviationOfBodyAngularVelocityInY",
                   "FrequencyStandardDeviationOfBodyAngularVelocityInZ",
                   "FrequencyMeanOfBodyAccelerationMagnitude",
                   "FrequencyStandardDeviationOfBodyAccelerationMagnitude",
                   "FrequencyMeanOfBodyAccelerationDerivativeMagnitude",
                   "FrequencyStandardDeviationOfBodyAccelerationDerivativeMagnitude",
                   "FrequencyMeanOfBodyAngularVelocityMagnitude",
                   "FrequencyStandardDeviationOfBodyAngularVelocityMagnitude",
                   "FrequencyMeanOfBodyAngularVelocityDerivativeMagnitude",
                   "FrequencyStandardDeviationOfBodyAngularVelocityDerivativeMagnitude",
                   "ActivityLabel")

# Check that the human activity recognition using smartphones data set
# zip file exists in the current working directory. If not print an error
# message and exit.
if (!file.exists(dataSetFileName)) {
    stop(paste("HAR data set zip file does not exist at ",
               file.path(getwd(), dataSetFileName), sep = ""))
}

# Extract HAR data set zip file
unzip(dataSetFileName)

# Step 1: Merge the training and the test sets to create one data set.
merged <- readAndMergeDataSet(trainingSetFile, testSetFile)

# Step 2: Extracts only the measurements on the mean and standard deviation
#         for each measurement.

# Read features list
features <- read.table(featuresFile)

# Get the column number by selecting features that contains 'mean()' or
# 'std()'.
neededColumns <- grep("mean\\(\\)|std\\(\\)", features[, 2])

# Finally extract the needed measurements
extracted <- merged[, neededColumns]

# Step 3: Use descriptive activity names to name the activities in the data
#         set

# Read activity labels
activityLabels <- read.table(activityLabelsFile)

# Read and merge training and test labels
mergedLabels <- readAndMergeDataSet(trainingLabelsFile, testLabelsFile)

# For each merged numberic label find the corresponding name and put the result
# back in a factor
labels <- apply(mergedLabels,
                1:length(mergedLabels),
                function(label) {activityLabels[label, 2]})

# Add activity label to the extracted data set
extracted <- cbind(extracted, labels)

# Step 4: Appropriately label the data set with descriptive variable names.
names(extracted) <- variableNames

# Step 5: From the data set in step 4, create a second, independent tidy data
#         set with the average of each variable for each activity and each
#         subject.

# Read and merge training and test subjects
mergedSubjects <- readAndMergeDataSet(trainingSubjectFile, testSubjectFile)
names(mergedSubjects) <- c("Subject")

# Add subjects to the extracted data set
extracted <- cbind(extracted, mergedSubjects)

# Group and summarise the data set by activity and subject using mean
tidyData <- extracted %>%
            group_by(ActivityLabel, Subject) %>%
            summarise_each(funs(mean))

# Finally write the tidy data
write.table(tidyData, outputFile, row.name = FALSE)

# Clean up
unlink(extractedDirectory, recursive = TRUE)