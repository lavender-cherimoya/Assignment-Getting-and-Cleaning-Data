# Load the needed packages
library(dplyr)
library(data.table)

# A) Load the data from the url if the data folder does not already exist in the
# correct folder
data_folder_name <- "UCI_Har_Dataset.zip"
file_data_unzip <- "UCI HAR Dataset"

if (!file.exists(data_folder_name)){
      data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(data_url, data_folder_name, method="curl")
}

# Unzips the data file if it is not already the case
if (!file.exists(file_data_unzip)) {
      unzip(data_folder_name)
}

# B) Accessing and saving the relevant data in dataframes
## Test data
X_test <- read.table(file.path(file_data_unzip, "test/X_test.txt"))
y_test <- read.table(file.path(file_data_unzip, "test/y_test.txt"), col.names="integer_label")
subject_test <- read.table(file.path(file_data_unzip, "test/subject_test.txt"), col.names="Subject")

## Train data
X_train <- read.table(file.path(file_data_unzip, "train/X_train.txt"))
y_train <- read.table(file.path(file_data_unzip, "train/y_train.txt"), col.names="integer_label")
subject_train <- read.table(file.path(file_data_unzip, "train/subject_train.txt"), col.names="Subject")

## Other information
features <- read.table(file.path(file_data_unzip, "features.txt"), col.names=c("index", "variable"))
activity_labels <- read.table(file.path(file_data_unzip, "activity_labels.txt"), col.names=c("integer_label", "type_of_activity"))

# Change column names for X_test and X_train data tables
setnames(X_test, names(X_test), features$variable)
setnames(X_train, names(X_train), features$variable)

# C) Merge the training and testing sets together
## First, per columns
test_set <- cbind(subject_test, y_test, X_test)
train_set <- cbind(subject_train, y_train, X_train)
## Then, per row
merged_data <- rbind(train_set, test_set)

# D) Only keep the mean() and std() measurements variables in the merged_data table
# The information that indicates which variables are the mean() and std() are given 
# in the features_info.txt files that comes with the dataset
var_keep <- c("mean()", "std()")
sub_data <- merged_data %>% select(Subject, integer_label, contains(var_keep))

# E) Replace the integer_label with the corresponding activity_label
sub_data$integer_label <- activity_labels[sub_data$integer_label, 2]
## Change column name for the integer_label column
setnames(sub_data, "integer_label", "Activity")

# F) Rename the variables to be more descriptive
names(sub_data)<-gsub("^t", "TimeDomain-", names(sub_data))
names(sub_data)<-gsub("^f", "FrequencyDomain-", names(sub_data))
names(sub_data)<-gsub("Acc", "Accelerometer", names(sub_data))
names(sub_data)<-gsub("Gyro", "Gyroscope", names(sub_data))
names(sub_data)<-gsub("Mag", "Magnitude", names(sub_data))
names(sub_data)<-gsub("BodyBody", "Body", names(sub_data))
names(sub_data)<-gsub("-mean\\(\\)", "-Mean", names(sub_data))
names(sub_data)<-gsub("-std\\(\\)", "-STD", names(sub_data))
names(sub_data)<-gsub("gravity", "Gravity", names(sub_data))
names(sub_data)<-gsub("angle", "Angle", names(sub_data))
names(sub_data)<-gsub("X", "XComponent", names(sub_data))
names(sub_data)<-gsub("Y", "YComponent", names(sub_data))
names(sub_data)<-gsub("Z", "ZComponent", names(sub_data))

# G) Create a new data set which averages each variable for each activity and subject
final_data_average <- sub_data %>% group_by(Subject, Activity) %>% summarise_all(mean)

# Save it in a txt file and drop the index of the row
write.table(final_data_average, "FinalDataAverage.txt", row.name=FALSE)

