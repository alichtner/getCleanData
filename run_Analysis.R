# ------------------------------------------------------------------------------------ 
# Code to read in accelerometer data, merge files into one large dataset,
# cross-reference by subject and activity then extract only the mean and std
# values for each variable. These are then summarized into "cleanData" where each 
# row is the average value for one test subject and one activity
# ------------------------------------------------------------------------------------ 

library(plyr) 

# ------------------------------------------------------------------------------------ 
# Read in necessary files and create dataframes that merge testing and training data
# ------------------------------------------------------------------------------------ 

columns <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

listOfFiles <- c("test/X_test.txt", "train/X_train.txt", "train/subject_train.txt", 
                 "test/subject_test.txt", "test/y_test.txt", "train/y_train.txt")

d <- do.call(rbind, lapply(listOfFiles[1:2], read.table, col.names = columns[,2])) 
p <- do.call(rbind, lapply(listOfFiles[3:4], read.table, col.names = "Subject")) 
a <- do.call(rbind, lapply(listOfFiles[5:6], read.table, col.names = "Activity")) 

# ------------------------------------------------------------------------------------ 
# Merge subject, activity and measurements datasets 
# ------------------------------------------------------------------------------------ 

data <- cbind(p, a, d)    

# ------------------------------------------------------------------------------------ 
# Create binary vector of "mean" and "std" columns. Include the first two columns also.
# Subset dataframe so that only the desired columns are kept
# ------------------------------------------------------------------------------------ 

extract <- c(TRUE, TRUE, grepl("mean", colnames(data)) | grepl("std", colnames(data)))
data <- data[, extract]

# ------------------------------------------------------------------------------------ 
# Loop through to match Activity number of label. Set this vector to be "Activity".
# ------------------------------------------------------------------------------------ 

for (i in 1:length(data$Activity)) {
        actMatches[i] <- activities[data[i,2],2]  
}

data$Activity <- actMatches

# ------------------------------------------------------------------------------------ 
# Create clean dataset with averages of each variable grouped by Subject and Activity
# ------------------------------------------------------------------------------------ 

cleanData <- aggregate(data[,c(-1,-2)], by = list(Subject = data$Subject, 
                        Activity = data$Activity), mean)


