# Data Preprocessing: Step 3. remove gene with extremely low expression
# Input: normalized count data from step 2
# Output: new normalized count data with only informative genes (normalized_counts2)

cat("Create a matrix of averaged gene count by tissues")
tissues=c("Hypothalamus","Liver","Muscle")
mean_all_tissue = c()

for (i in tissues) {
  col_index = which(tissue_name==i)
  nor_count_tissue = normalized_counts[,col_index]
  cat("calculate gene mean expression over",length(col_index) ,"samples of tissue",i,"\n")
  
  # calculate mean count
  mean_tissue = rowMeans(nor_count_tissue)
  mean_all_tissue = cbind(mean_all_tissue,mean_tissue)
}

colnames(mean_all_tissue)=tissues

threshold = 10 #from experience, gene with expression < 10 is not likely to become DE, not informative
gene_index = which(mean_all_tissue[,1]>threshold | mean_all_tissue[,2]>threshold | mean_all_tissue[,3]>threshold)
cat("retain",length(gene_index), "gene with more than",threshold,"normalized reads in at least one tissue")

# remove those low expression genes
normalized_counts2 = normalized_counts[gene_index,]


#save the gene_index of selected genes
write.table(gene_index,"D:/Huaijun_rna/HTSeq_heat_FL_2group_acute/normalized_count/gene_index_16477.txt",sep=" ",col.names = FALSE,row.names = FALSE)

#save the gene_name of selected genes
all_name = read.table("D:/Huaijun_rna/HTSeq_heat_FL_2group_acute/raw_count/gene_name_raw_24356.txt",stringsAsFactors=FALSE)
all_name = all_name$V1
new_name = all_name[gene_index]
write.table(new_name,"D:/Huaijun_rna/HTSeq_heat_FL_2group_acute/normalized_count/gene_name_16477.txt",sep=" ",col.names = FALSE,row.names = FALSE,quote = FALSE)



