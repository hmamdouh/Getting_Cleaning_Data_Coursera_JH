# Getting_Cleaning_Data_Coursera_JH
This is for the Getting and cleaning data course from John Hopkins Coursera.
The repo contains 3 main files:
* This readme file to contain the introduction for the repo
* The specbook to introduce anyone to the variables in the dataset provided by Samsung devices
* The run file which runs the code to output a tidy output data


The runfile works in the below sequence:
* Reads the colnames from the features.txt in the working directory
* Reading the training set, subject_train and y_train
* joins the training set with the subject IDs and the activity labels
* Reading the test set, subject_test and y_test
* joins the test set with the subject IDs and the activity labels
* Now Data is ready to be merged
* Select only the participant_id,activity_name and all columns with mean() and std()
* Rename the 1-6 values in the activity_name column to the correspondant values in activity_labels.txt
* Renaming the column variables names for better readability 
* Group the merged data with participant_id then activity_name and summarize each column in each group by mean
