features <- read.table("E:/DS_C/R_projects/3/UCI_data/features.txt")

activityLabels <- read.table("E:/DS_C/R_projects/3/UCI_data/activity_labels.txt", col.names = c('activityId','activityType'))

x_train <- read.table("E:/DS_C/R_projects/3/UCI_data/train/X_train.txt", col.names = features[ , 2])
y_train <- read.table("E:/DS_C/R_projects/3/UCI_data/train/y_train.txt", col.names = "activityId")
subject_train <- read.table("E:/DS_C/R_projects/3/UCI_data/train/subject_train.txt", col.names = "subjectId")

x_test <- read.table("E:/DS_C/R_projects/3/UCI_data/test/X_test.txt", col.names = features[ , 2])
y_test <- read.table("E:/DS_C/R_projects/3/UCI_data/test/y_test.txt", col.names = "activityId")
subject_test <- read.table("E:/DS_C/R_projects/3/UCI_data/test/subject_test.txt", col.names = "subjectId")

total_train <- cbind(y_train, subject_train, x_train)
total_test <- cbind(y_test, subject_test, x_test)
total_data <- rbind(total_train, total_test)

colNames <- colnames(total_data)

sdmu_colNames <- (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))

sdmu_data <- total_train[ , sdmu_colNames == TRUE]

activitynames_data <- merge(sdmu_data, activityLabels, by = 'activityId', all.x = TRUE)

tidyset <- aggregate(. ~subjectId + activityId, activitynames_data, mean)
tidyset <- tidyset[order(tidyset$subjectId, tidyset$activityId), ]

write.table(tidyset, "tidyset.txt", row.name=FALSE)
