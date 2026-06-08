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