Getting and Cleaning Data Project
=================================

Getting and cleaning data project is my own solution to [Coursera](https://www.coursera.org/) [Getting and Cleaning Data](https://www.coursera.org/course/getdata) course project. Basically is performs the following steps on [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) [data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in order to tidy the data set. The script:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For a detailed description of each step look at [run_analysis.R](https://github.com/mcherri/getting_and_cleaning_data_project/blob/master/run_analysis.R).

Usage
-----

To get the tidy data set:

1. Make sure [dplyr](http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html) package is installed.
```
install.packages("dplyr")
```
2. Download the script [run_analysis.R](https://github.com/mcherri/getting_and_cleaning_data_project/blob/master/run_analysis.R) in the current working directory and put the [HAR data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in the same directory.
3. In R console execute:
```
source("run_analysis.R")
```
4. The script will generate "tidy_data.txt". To load in R use the following in R console:
```
read.table("tidy_data.txt", header = TRUE)
```

Notes
-----

* Only variables ending with mean() and std() were considered from the original data set because they represent IMHO the mean and standard deviation requested by the project the instruction. 
* Variables ending with meanFreq() are mean frequency measurement and variables containing "Mean" are sliding window average. Both were not considered.


Code Book
---------

For more information about "tidy_data.txt" format please refer to the [code book](https://github.com/mcherri/getting_and_cleaning_data_project/blob/master/CodeBook.md)
