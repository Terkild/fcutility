library(flowCore)

## Target folder containing fcs files to be modified.
source_folder <- file.path("path/to/fcs/folders")
source_files <- list.files(path=source_folder, pattern=".fcs$", recursive=TRUE, full.names=TRUE)
target_folder <- file.path("path/to/fcs/folders/edited")
target_files <- gsub(source_folder, target_folder, source_files)

## Create target dir if it does not exist
dir.create(target_folder[!dir.exists(dirname(target_files)], recursive=TRUE)

## What channels should be annotated?
annotate_channels <- c("APC-A"="test1",
                      "PE-A"="test2",
                      "FITC-A"="test3",
                      "BUV395-A"="test4")

## Loop through files to be edited
for(i in seq_along(source_files)){
  source_fcs_file <- source_files[i]
  target_fcs_file <- target_files[i]

  ## Read FCS file contents
  fcs1 <- flowCore::read.FCS(filename=source_fcs_file)

  ## Sets parameter description according to `annotate_channels`
  fcs1@parameters$desc[match(names(annotate_channels), fcs1@parameters$name)] <- annotate_channels

  ## Save FCS file
  cat("Saving ", target_fcs_file, "\r\n")
  flowCore::write.FCS(fcs1, filename=target_fcs_file)
}
