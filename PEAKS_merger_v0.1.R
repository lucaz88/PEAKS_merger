#!/usr/bin/env Rscript



# #___ dummy data for testing
# setwd("Seafile/CF-BINF/PROJECTs/inter_CFs/CF_MS-PEAKS_merger/")
# raw_dir <- "toy_data3"
# out_file <- "merged_toy3_tab.csv"
# #___ for testing



#! load libraries
required_libs <- c("optparse","tidyverse")
invisible(lapply(required_libs, library, character.only = TRUE))



#! parse command line argument - python style
option_list <- list(
  make_option(c("-r", "--raw_dir"), type="character", default=NULL, 
              help="path to a folder containing multiple CSV files to merge", metavar="character"),
  make_option(c("-o", "--out_file"), type="character", default=NULL, 
              help="name of merged file", metavar="character")
)
opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)



#! declare function
csv_merger <- function(raw_dir, out_file) {
  
  ##! read-in raw data
  tab_list <- list.files(path = raw_dir, pattern = ".csv$", full.names = T)
  smpl_names <- gsub("sample_|proteins_Output_|.csv", "", basename(tab_list))
  col_names <- c("Protein.Group","Protein.ID","Accession","neg10lgP",
                 "Coverage","Coverage.Sample","Area.Sample","X.Peptides",
                 "X.Unique","X.Spec.Sample","PTM","Avg.Mass",
                 "Description")
  
  ##! filter & parse raw tables
  tabs <- lapply(seq_along(tab_list), function(i) {
    i_full <- read.delim(tab_list[i], sep = ",")
    colnames(i_full) <- col_names
    i_filt <- i_full[, col_names[c(3,12,13,4,5,7,8,9,10,11)]]
    colnames(i_filt)[4:10] <- paste0(colnames(i_filt)[4:10], 
                                     "_", smpl_names[i])
    return(i_filt)
  })
  
  ##! merge tables
  merged_tabs <- tabs %>% 
    reduce(right_join, by = col_names[c(3,12,13)]) %>% 
    arrange(Accession) %>%
    mutate(across(everything(), ~replace(.x, .x == "", "no_PTM_detected")))

  ##! save merged table
  dir.create(dirname(out_file), recursive = T, showWarnings = F)
  write.table(merged_tabs, out_file, quote = F, sep = ",",
              col.names = T, row.names = F)
}



#! execute
csv_merger(raw_dir = opt$raw_dir, 
           out_file = opt$out_file)