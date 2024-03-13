This repository contains the R code and files necessary for the Getting and Cleaning Data assignment of lavender-cherimoya. The purpose of the assignment is to demonstrate the ability to collect, work with, and clean a given dataset.

**Dataset**

The raw data comes from the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones) database available online, which is built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a wait-mounted smartphone with embedded inertial sensors. [1]

```         
[1] Reyes-Ortiz,Jorge, Anguita,Davide, Ghio,Alessandro, Oneto,Luca, and Parra,Xavier. (2012). Human Activity Recognition Using Smartphones. UCI Machine Learning Repository. https://doi.org/10.24432/C54S4K.
```

**Files**

This GitHub repository contains the following files:

-   `run_analysis.R` : The R script which contains the code that imports the UCI HAR Dataset and prepares a tidy data set from it, that can then be used for later analysis.

-   `FinalTidyDatasetAverage.txt` : The `.txt` file in which the output of the `run_analysis.R` script is saved, containing the final tidy dataset.

-   `CobeBook.md` : This code book describes in more detail the different variables encountered in `run_analysis.R`, as well as the steps and transformations performed to clean the UCI HAR Dataset into the tidy dataset `FinalTidyDatasetAverage.txt`.
