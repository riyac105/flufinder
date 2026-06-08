upload_fasta <- function(fasta_filename) {
  library(seqinr)
  
  read.fasta(fasta_filename,
             seqtype = "AA",
             as.string = TRUE,
             set.attributes = FALSE)
}

trypsinize <- function(proteins) {
  library(stringr)
  
  lapply(proteins, str_split_1, pattern = "(?<=R|K)")
}

split_peptides <- function(peptides) {
  library(stringr)
  
  lapply(peptides, str_split, pattern = "")
}

splitpeptides_to_masses <- function(aa) {
  
  aa_masses <- c(A=71.037, R=156.101, N=114.042, D=115.026, C=103.009, 
                 Q=128.058, E=129.042, G=57.021, H=137.058, I=113.084, 
                 L=113.084, K=128.094, M=131.040, F=147.068, P=97.052, 
                 S=87.032, T=101.047, W=186.079, Y=163.063, V=99.068)
  
  peptide_masses <- aa
  
  for(i in 1:length(aa)) {
    peptide_masses[[i]] <- lapply(aa[[i]], 
                                  function(x) sum(aa_masses[x]))
  }
  
  lapply(peptide_masses, unlist)
}

count_matching_masses <- function(protein_masses, sample) {
  
  df <- as.data.frame(sapply(protein_masses, function(x) 
    sum(as.character(sample) %in% as.character(x))))
  
  names(df) <- "peptide_counts"
  
  return(df)
}