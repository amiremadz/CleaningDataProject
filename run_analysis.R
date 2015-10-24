



########### Part 1 #############


activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = F)
features <- read.table("./UCI HAR Dataset/features.txt")



X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")




data_test <- cbind(subject_test,X_test,y_test)
data_train <- cbind(subject_train,X_train,y_train)

data_all <- rbind(data_test,data_train)



library(dplyr)
library(stringr)


names(data_all) <- str_trim ( make.names( c("subject",tolower( as.character(features[,2]) ),"activity") , unique=TRUE, allow_ = TRUE) )

data_all <- arrange(data_all,subject)


glimpse(data_all)

sub_data <- select(data_all,matches("mean|std|subject|activity"))
#grep("mean|std", names(data_all))


#library(plyr)
sub_data$activity <- plyr::mapvalues(sub_data$activity,from = 1:6,to = tolower( as.character( activity_labels[,2] ) ) )


head(sub_data)


summary_subj_activity <- summarize_each(group_by(sub_data,subject,activity),funs(mean))



names(sub_data) <- lapply(names(sub_data), function(x){ gsub("\\.\\.\\.|\\.\\.","\\.",x)})

glimpse(sub_data)


write.table(sub_data,file = "data_sub.txt", row.names = FALSE)






























