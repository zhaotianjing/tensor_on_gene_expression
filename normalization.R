# Data Preprocessing: Step 2. normalize the raw count data
# Input: raw count matrix exactly from step 1. 
# Output: normalized counts (normalized_counts)

# Tutorial: https://hbctraining.github.io/DGE_workshop/lessons/02_DGE_count_normalization.html


library(DESeq2)  #->normalization estimateSizeFactors()

# normalization
dds <- DESeqDataSetFromMatrix(raw_count, DataFrame(condition), ~ condition) #raw_count is from step1 
dds <- estimateSizeFactors(dds)

cat("The size factors for each sample:")
print(sizeFactors(dds))

normalized_counts <- counts(dds, normalized=TRUE)

cat("The dimension of normalized count matrix is",nrow(normalized_counts),"genes by",ncol(normalized_counts),"individuals.")
cat("The first 2 columns and rows of normalized count matrix is:")
print(normalized_counts[1:2,1:2])




# # save normalized count data seperatly
# # transpose the count matrix
# datExpr0 = as.data.frame(t(normalized_counts)) #sample*gene 48*24356
# save_path="D:/Huaijun_rna/HTSeq_heat_FL_2group_acute/normalized_count_24356/"
# cat("Normalized count is saved at:",save_path)
# for (i in 1:length(rownames(datExpr0)))
# {
#   file_name = paste(save_path,rownames(datExpr0)[i],".txt", sep = "")
#   cat("saving:",rownames(datExpr0)[i],"\n")
#   data = t(datExpr0[i,])
#   cat("number of gene is",nrow(data),"\n")
#   write.table(data,file_name,sep=" ",col.names = FALSE,row.names = FALSE)
# }






