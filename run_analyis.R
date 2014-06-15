## Read data file from working directory


DataFolder <- "UCI HAR Dataset"
DataFolderPath <- file.path(getwd(),DataFolder)

if (! file.exists(DataFolderPath)) {
    
    print (paste(DataFolder, " not found in working directory."))
    print ("Processing aborted. Please follow instructions in ReadMe.txt")
    
} else {
    
    # get main data sets
    data_test <- read.table(file.path(DataFolderPath,"test","X_test.txt"), header = FALSE)
    data_train <- read.table(file.path(DataFolderPath,"train","X_train.txt"), header = FALSE)
    
    # list of all measurements
    feat <- read.table(file.path(DataFolderPath,"features.txt"))
    # selected (ie mean and std dev measurements)
    feat_ismean <- sapply(feat$V2,function(x) grepl("mean",x))
    feat_isstd <- sapply(feat$V2,function(x) grepl("std",x))
    feat_isfreqmean <- sapply(feat$V2,function(x) grepl("meanFreq",x))
    #all selected measurment fields, excluding meanFreq
    feat_sel <- (feat_ismean & ! feat_isfreqmean)  | feat_isstd
    
    
    #rename columns in each data set
    names(data_test)<-feat$V2
    names(data_train)<-feat$V2
    
    
    #extract selected mean and std fields from data sets
    sel_data_test <- data_test[,feat_sel]
    sel_data_train <- data_train[,feat_sel]
    
    
    # subject id for each window (record) in main data sets
    sub_test <- read.table(file.path(DataFolderPath,"test","subject_test.txt"))
    sub_test <- as.factor(sub_test$V1)
    
    sub_train <- read.table(file.path(DataFolderPath,"train","subject_train.txt"))
    sub_train <- as.factor(sub_train$V1)
    
    # activity labels for data sets
    lab_test <- read.table(file.path(DataFolderPath,"test","y_test.txt"), header = FALSE)
    lab_train <- read.table(file.path(DataFolderPath,"train","y_train.txt"), header = FALSE)
    
     
    #add subject ids and activity labels to each main data sets
    data_test_add <- cbind(lab_test,sub_test,sel_data_test)
    data_train_add <- cbind(lab_train,sub_train,sel_data_train)
    
  
    
    #rename first two columns
    names(data_test_add)[1:2] <- c("Activity_ID","Subject_ID")
    names(data_train_add)[1:2] <- c("Activity_ID","Subject_ID")
    
    #merge main data sets
    data_main <- rbind(data_test_add,data_train_add)
    
    #coerce subject_Id to factor     
    
    # table mapping  numeric labels to text labels for six activities
    act_lab <- read.table(file.path(DataFolderPath,"activity_labels.txt"))
    
    
    
    
    
   
    
    
}
