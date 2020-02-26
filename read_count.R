# Data Preprocessing: Step 1. read count data
# Input: path of file of raw count 
# Output: raw_count matrix with size of nGene-by-nSample

print("Data Preprocessing: Step 1. read count data")

library(stringr)

root_path_raw_count = "D:/Huaijun_rna/HTSeq_heat_FL_2group_acute/raw_count/"
tissue_names=c("Hypothalamus","Liver","Muscle")

raw_count = c()
condition = c()
tissue_name=c()
all_file_name=c()
for (tissue in tissue_names) {
  file_names = list.files(path = root_path_raw_count,pattern = tissue)
  all_file_name = append(all_file_name,file_names)
  cat("Loaded",length(file_names),"raw count files of",tissue,"\n")
  cat("The names of files are: \n")
  for (i in file_names) {cat(i,"\n")}
  
  # read raw count
  for (file_name in file_names){
    raw_count_tmp = read.table(paste(root_path_raw_count,file_name, sep = ""))[1:24356,2] #the rest of rows are not needed
    condition_tmp = substr(str_remove(file_name, ".txt"),6,100)
    raw_count = cbind(raw_count, raw_count_tmp)
    condition = append(condition, condition_tmp)
    tissue_name = append(tissue_name,tissue)
  }
}

raw_count = as.matrix(raw_count) #gene*sample
colnames(raw_count) = str_remove(all_file_name, ".txt")
cat("The dimension of raw count matrix is",nrow(raw_count),"genes by",ncol(raw_count),"individuals.")
cat("The first 2 columns and rows of raw count matrix is:")
print(raw_count[1:2,1:2])


condition = factor(condition)
cat("The different treatment groups are:")
for (i in levels(condition)) {cat(i,"\n")}



# # input path
# root_path_raw_count = "D:/Huaijun_rna/HTSeq_heat_FL_2group_acute/raw_count/"
# file_names = list.files(path = root_path_raw_count,pattern = "\\Acute[.]txt$")
# 
# # print files info
# cat("The names of files are:")
# for (i in file_names) {cat(i,"\n")}
# cat("The number of files is",length(file_names))
# 
# # read raw count
# raw_count = c()
# condition = c()
# for (file_name in file_names){
#   raw_count_tmp = read.table(paste(root_path_raw_count,file_name, sep = ""))[1:24356,2] #the rest of rows are not needed
#   condition_tmp = substr(str_remove(file_name, ".txt"),6,100)
#   raw_count = cbind(raw_count, raw_count_tmp)
#   condition = cbind(condition, condition_tmp)
# }
# raw_count = as.matrix(raw_count) #gene*sample
# colnames(raw_count) = str_remove(file_names, ".txt")
# cat("The dimension of raw count matrix is",nrow(raw_count),"genes by",ncol(raw_count),"individuals.")
# cat("The first 2 columns and rows of raw count matrix is:")
# print(raw_count[1:2,1:2])
# 
# 
# condition = factor(condition)
# cat("The different treatment groups are:")
# for (i in levels(condition)) {cat(i,"\n")}

