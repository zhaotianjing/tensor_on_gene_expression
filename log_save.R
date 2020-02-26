# Data Preprocessing: Step 4. log transformation and save finale normalized data
# Input: normalized count data from step 2
# Output: saved log counts

cat("The dimension of input normalized count is",nrow(normalized_counts2),"genes by",ncol(normalized_counts2),"samples \n")

normalized_counts3=log(normalized_counts2+1)

tissues=c("Hypothalamus","Liver","Muscle")
file_name = paste(save_path,rownames(datExpr0)[i],".txt", sep = "")

all_sample=c()
for (i in tissues){
  col_index = which(tissue_name==i)
  nor_count_tissue = normalized_counts3[,col_index]
  cat("normalized count of",i,"is",nrow(nor_count_tissue),"genes by",ncol(nor_count_tissue),"samples \n")
  sample_i = colnames(nor_count_tissue)
  all_sample = cbind(all_sample,sample_i)
  save_path = paste("D:/Huaijun_rna/HTSeq_heat_FL_2group_acute/normalized_count/",i,".txt", sep = "")
  write.table(nor_count_tissue,save_path,sep=" ",col.names = FALSE,row.names = FALSE)
}

#double-check whether sample order are same
colnames(all_sample)=tissues
print(all_sample)
sum(substr(all_sample[,1],1,4)==substr(all_sample[,2],1,4))==nrow(all_sample) #sample in tissue1=sample in tissue2
sum(substr(all_sample[,2],1,4)==substr(all_sample[,3],1,4))==nrow(all_sample) #sample in tissue2=sample in tissue3

#save sample info
write.table(sample_i,"D:/Huaijun_rna/HTSeq_heat_FL_2group_acute/normalized_count/sample_16.txt",sep=" ",col.names = FALSE,row.names = FALSE,quote = FALSE)
