#!/bin/bash

# Define the base directory where participants' data is stored
cd /Users/ccri/Desktop/Data_Analysis/MotorLearning

# List of participant IDs
participants=(001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050)

# Loop through each participant and run fod2fixel
for i in "${participants[@]}"
do
    echo "Processing participant ${i}..."

  
    # Step 1: Extract fixels and compute AFD for each participant, making sure to include the template mask 
    echo "Running fod2fixel for participant ${i}..."
    fod2fixel -mask ./template/template_mask.mif ./${i}/DTIPrep/subj${i}_warped_fod_wm_NOT_REORIENTED.mif ./${i}/DTIPrep/fod2fixel_NOT_REORIENTED -afd fd.mif

    echo "Finished processing participant ${i}."
done

echo "Fixel extraction and AFD calculation complete for all participants."
