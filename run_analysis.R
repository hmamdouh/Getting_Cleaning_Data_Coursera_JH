###Reads the colnames from the features.txt in the working directory
trainingset_colnames <- readLines("features.txt")
### readlines give back 2 columns in the same column so to clean that out, we remove the first unneeded row number
### Maybe I should have used read.table here but that worked 
trainingset_colnames <- gsub("^[0-9]+ ","",trainingset_colnames)

### Reading the training set, subject_train and y_train
train_set <- read.table("train/X_train.txt",col.names = trainingset_colnames)
subject_train <- read.table("train/subject_train.txt",col.names = "participant_id")
y_train <- read.table("train/y_train.txt",col.names = "activity_name")

## joins the training set with the subject IDs and the activity labels
train_set <- bind_cols(subject_train,y_train,train_set)

### Reading the test set, subject_test and y_test
test_set <- read.table("test/X_test.txt",col.names = trainingset_colnames)
subject_test <- read.table("test/subject_test.txt",col.names = "participant_id")
y_test <- read.table("test/y_test.txt",col.names = "activity_name")

## joins the test set with the subject IDs and the activity labels
test_set <- bind_cols(subject_test,y_test,test_set)

## Now Data is ready to be merged
merged_train_test_set <- merge(train_set,test_set,all=TRUE)

## Select only the participant_id,activity_name and all columns with mean() and std()
selected_merged_train_test_set <- select(merged_train_test_set,matches("mean()|std()|participant_id|activity_name"))

## Rename the 1-6 values in the activity_name column to the correspondant values in activity_labels.txt
selected_merged_train_test_set$activity_name[selected_merged_train_test_set$activity_name==1] <- c("WALKING")
selected_merged_train_test_set$activity_name[selected_merged_train_test_set$activity_name==2] <- c("WALKING_UPSTAIRS")
selected_merged_train_test_set$activity_name[selected_merged_train_test_set$activity_name==3] <- c("WALKING_DOWNSTAIRS")
selected_merged_train_test_set$activity_name[selected_merged_train_test_set$activity_name==4] <- c("SITTING")
selected_merged_train_test_set$activity_name[selected_merged_train_test_set$activity_name==5] <- c("STANDING")
selected_merged_train_test_set$activity_name[selected_merged_train_test_set$activity_name==6] <- c("LAYING")

###Renaming the column variables names for better readability 
x <- names(selected_merged_train_test_set)
x <- gsub("^t","TimeDomain",x)
x <- gsub("^f","FreqDomain",x)
x <- gsub("^angle","AngularVelocity",x)
colnames(selected_merged_train_test_set) <- x

## Group the merged data with participant_id then activity_name and summarize each column in each group by mean
grouped_selected_merged_sets <- selected_merged_train_test_set %>%
  group_by(participant_id,activity_name) %>%
  summarize_each(funs(mean))

