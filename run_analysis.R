library(dplyr)

# This script,run_analysis.R, does the following as described in the project:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.


########## READ FILES #############################
#Read labels, observations, subjects and activity data 
#combine and load train and test data
data <- rbind(
    read.table(file.path("./UCI_Data", "/train/X_train.txt")),
    read.table(file.path("./UCI_Data", "/test/X_test.txt"))
    )
#total labels
labels <- rbind(
    read.table(file.path("./UCI_Data", "/train/y_train.txt")),
    read.table(file.path("./UCI_Data", "/test/y_test.txt"))
)
#subjects 
subjects <- rbind(
    read.table(file.path("./UCI_Data", "/train/subject_train.txt")),
    read.table(file.path("./UCI_Data", "/test/subject_test.txt"))
)

#activity text labels
activities <- read.table(file.path("./UCI_Data","/activity_labels.txt"))

##################################################

#get column numbers and names where description has mean or std in it
features <- read.table(file.path("./UCI_Data","/features.txt"))
colnum <- grep("mean|std",features[,2])
colnames <- grep("mean|std",features[,2],value = TRUE)

# clean names
colnames <- gsub("[()-]","",colnames)

cols <- list("col_numbers"=colnum,"colnames"=colnames)

#select the given columns
data <- data %>% select(cols[[1]])

#change the integer labels
labels <- activities[match(labels[,1],activities[,1]),2]

#combine observations and labels
set <- cbind(data,labels,subjects)

#Assign descriptions to variables
column_names <- cols[[2]]
names(set) <- c(column_names,"activitylabel","subject")

averages <- set %>% group_by(activitylabel,subject) %>% summarize_all(list(mean))
