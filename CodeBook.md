The goal of the `run_analysis.R` script is to create a tidy dataset of the UCI HAR Dataset. It performs the following steps:

#### **A) Loading the raw UCI HAR Dataset**

If the raw data set is not already present in the working directory, the script downloads the data from the given URL: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

#### **B) Accessing the relevant raw data stored in `.txt` files and saving them into data tables**

For the test data (30% of the whole dataset) :

-   `X_test` (from `./test/X_test.txt`) : Data table of size (2947, 561). Contains the 561 different features for each of the 2947 samples in the test set. The features include 3-axial linear acceleration and 3-axial angular velocity measurements, taken with the help of the accelerometer and gyroscope of a smartphone. The column names for the features are set and taken from `features$variables`.

-   `y_test` (from `./test/y_test.txt`) : Data table of size (2947, 1). Contains the activity integer label for each of the 2947 samples in the test set. It describes which physical activity the subject was doing when the corresponding measurements were taken.

-   `subject_test` (from `./test/subject_test.txt`) : Data table of size (2947, 1). Contains the subject label for each of the 2947 samples in the test set. The total group of subjects is made of 30 volunteers.

For the training data (70% of the whole dataset) :

-   `X_train` (from `./train/X_train.txt`) : Data table of size (7352, 561). Contains the 561 features for each of the 7352 samples in the train set. The column names for the features are set and taken from `features$variables`.

-   `y_train` (from `./train/y_train.txt`) : Data table of size (7352, 1). Contains the activity integer label for each of the 7352 samples in the train set.

-   `subject_train` (from `./train/subject_train.txt`) : Data table of size (7352, 1). Contains the subject label for each of 7352 samples in the train set.

For the other data :

-   `features` (from `./features.txt`) : Data table of size (561, 2). Contains the list of names of the 561 different features measured for each sample and their corresponding index.

-   `activity_labels` (from `./activity_labels.txt`) : Data table of size (6, 2). Contains the name list of activities performed when taking the measurements and their corresponding integer label. There are a total of 6 different activities.

#### **C) Merging the data together into one unique data table**

First, two separate data tables are created, one for the train set and another for the test set. The final merged data set is created by merging the two previous ones.

-   `test_set` : Data table of size (2947, 563). Created by merging `X_test`, `y_test` and `subject_test` with `cbound()`.

-   `train_set` : Data table of size (7352, 563). Created by merging `X_train`, `y_train` and `subject_train` with `cbound()`.

-   `merged_data` : Data table of size (10299, 563). Created by merging `test_set` and `train_set` with `rbound()`.

#### **D) Selecting specific features from `merged_data`**

Only the features containing specific strings in their name are kept in the new tidy dataset.

-   `var_keep` : chr list of size (1, 2). Contains the strings to look up for in the features names of `merged_data`. In this case, only the mean and standard deviation of the measurements are wanted. As per the the `features_info.txt` file that comes with the dataset, those features have `"mean()"` and `"std()"` in their name.

-   `sub_data` : Data table of size (10299, 68). Tidy data table that contains the `Subject`, `integer_label` and the feature columns kept after filtering out their names (i.e. only keeping the mean and standard deviation of the measurements).

#### **E) Changing the activity names to be more descriptive**

The values in the `integer_label` column in `sub_data` are replaced with the corresponding activity names saved in the second column of `activity_labels`. The column is renamed `Activity` (instead of `integer_label`).

#### **F) Changing the feature column names to be more descriptive**

Some strings in the feature column names in `sub_data` are replaced with fuller descriptive strings to make the column names more explanatory.

1.  Any `t` localized at the start of a column name is replaced by `TimeDomain-`.

2.  Any `f` localized at the start of a column name is replaced by `FrequencyDomain-`.

3.  Any `Acc` is replaced by `Accelerometer`.

4.  Any `Gyro` is replaced by `Gyroscope`.

5.  Any `Mag` is replaced by `Magnitude`.

6.  Any `BodyBody` is replaced by `Body`.

7.  Any `mean()` is replaced by `Mean`.

8.  Any `std()` is replaced by `STD`.

9.  Any `gravity` is replaced by `Gravity`.

10. Any `angle` is replaced by `Angle`.

11. Any `X` is replaced by `XComponent`.

12. Any `Y` is replaced by `YComponent`.

13. Any `Z` is replaced by `ZComponent`.

#### **G) Creating a separate dataset containing the average of each feature per activity and subject**

From `sub_data`, a second independent tidy dataset is created which contains the average of each feature for each activity and each subject. This new dataset is then saved as a `.txt` file.

-   `final_data_average` : Data table of size (180, 68). Contains the average of every feature in `sub_data`, per activity and per subject.

-   `FinalDataAverage.txt` : Final `.txt` file in which the `final_data` tidy dataset is saved in the working directory.
