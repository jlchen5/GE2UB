# GE2UB

R script for predicting the ubiquitin by gene expression matrix


An example code of a machine learning based model for gene expression prediction of protein ubiquitination is provided here, written in R. This model can help to predict which genes play important roles in protein ubiquitination.

First, we need to prepare data, including gene expression data and known protein ubiquitination data. We will use the publicly available dataset [GSE76005](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE76005), which includes gene expression data and protein ubiquitination data from `human breast cancer` tissue and normal tissue.


The file format is as follows.

- The first row is the table header, including the sample number and gene name. 
- The first column is the sample number. 
- Subsequent columns contain the gene name, and each column contains the expression level of that gene in each sample. 


| Sample | GeneA | GeneB |
| :-----| :----: | :----: |
| Sample1 | 0.9 | 1.1 |
| Sample2 | 1.0 | 0.5 |

- The first row is the table header, including the sample number and protein name. 
- The first column is the sample number. 
- Subsequent columns contain the protein name and each column contains the level of ubiquitination for that protein in each sample. 

| Sample | ProteinA | ProteinB |
| :-----| :----: | :----: |
| Sample1 | 0.9 | 1.1 |
| Sample2 | 1.0 | 0.5 |

- Note that the sample data given here is for demonstration purposes only, and the actual data format may be slightly different, depending on the data source and the data type to be confirmed.

