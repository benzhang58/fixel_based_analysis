#!/bin/bash

# Define the base directory where the participants' data is stored
cd "/Users/ccri/Desktop/Data_Analysis/MotorLearning"


# List of participant IDs

# Loop through each participant
for i in 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050
do
    echo "Processing participant ${i}..."

    
    echo "Computing FC for participant ${i}..."
	warp2metric ./${i}/DTIPrep/FA2template_warp.mif -fc ./template/template_fixel_mask ./${i}/FC_directory FC.mif -force

    # Step 2: Compute log(FC)
    echo "Computing log(FC) for participant ${i}..."
    mrcalc ./${i}/FC_directory/FC.mif -log ./${i}/FC_directory/log_FC.mif -force

    mkdir ./${i}/FDC_directory
    cp ./${i}/FC_directory_FINAL/index.mif ./${i}/FDC_directory
    cp ./${i}/FC_directory_FINAL/directions.mif ./${i}/FDC_directory 

    # Step 3: Compute FDC (combined measure of fiber density and fiber cross section)
    echo "Computing FDC"
    mrcalc ./${i}/DTIPrep/fixel_masked_FINAL/fd_masked.mif ./${i}/FC_directory_FINAL/FC.mif -mult ./${i}/FC_directory_FINAL/FDC.mif
   

   

    echo "Finished processing participant ${i}."
done

echo "FC and log(FC) computation complete for all participants."
