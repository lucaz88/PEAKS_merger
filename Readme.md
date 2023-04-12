# R function to merge CSV outputs of PEAKS Studio

## Required inputs:
* ***raw_dir***: path to a folder containing multiple CSV files. Note that the name of each file in the folder will be used (extension excluded) as sample identifier to name the columns in the merged table.
* ***out_file***: file name for the merged tables.

## Set-up the environment:
* R needs to be installed on the computer. Please follow the instruction provided under *Download and Install R* at https://cran.r-project.org/
* Install the necessary packages:
    * Start an R session
    * Type in the following code and follow the prompted instructions:

          required_libs <- c("optparse","tidyverse")
          missing_libs <- required_libs[!required_libs %in% rownames(installed.packages())]
          if (length(missing_libs) > 1) {
            cat("Installing missing packages: ", paste(missing_libs, collapse = ", "), "\n\n")
            sapply(missing_libs, function(i) install.packages(i))
          }
          invisible(lapply(required_libs, library, character.only = TRUE))

* Fetch the tool repository
    * in **Windows**:
        - Almost at the top of this GitHub page, click *"<> Code"*
        - Click on *"Download ZIP"*
        - Save and extract the file where you prefer (e.g. C:\Users\Luca\Tools)

    * in **Linux**:

        open a terminal and type:

          sudo apt update
          sudo apt install git
          cd /home/user/tools # or to whatever folder in which you want to save the tool
          git clone https://github.com/lucaz88/PEAKS_merger.git

## How to run:

For **Windows** system:

* Press the Windows Start button on the screen or keyboard
* Type in "Command Prompt"
* Left click on Command Prompt
* Move into the repository folder `cd C:\Users\Luca\Tools\PEAKS_merger-main` in which toy files are provided to test the tool
* Type `"C:\Program Files\R\R-4.2.2\bin\Rscript.exe" PEAKS_merger_v0.1.R -r toy_data -o merged_toy_tab.csv`
\# update the paths to where you actually installed R and downloaded the repo

For **Linux** system:

open a terminal and type:

    cd /home/user/tools/PEAKS_merger
    Rscript PEAKS_merger_v0.1.R -r toy_data -o merged_toy_tab.csv

**To run you own sample simply `cd` into the project folder with your data and provide the related values for `-r` and `-o` arguments.**
