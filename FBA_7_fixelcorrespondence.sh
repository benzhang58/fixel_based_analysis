#!/bin/bash

# Define the base directory where the participants' data is stored
base_dir="/Users/ccri/Desktop/Data_Analysis/MotorLearning"

# Define the path to the population template fixel mask
template_fixel_mask="${base_dir}/template/fixel_mask/"

# List of participant IDs
participants=(001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050)

# Loop through each participant
for i in "${participants[@]}"
do
    echo "Processing participant ${i}..."

    # Define paths to participant's fixel directory and output directories
    participant_fixel_dir="${base_dir}/${i}/DTIPrep/fod2fixel_NOT_REORIENTED"
    reoriented_fixel_dir="${base_dir}/${i}/DTIPrep/fixel_in_templatespace_REORIENTED"

    # Step 1: Reorient the entire fixel directory
    echo "Reorienting fixels for participant ${i}..."
    fixelreorient "${participant_fixel_dir}" "${base_dir}/${i}/DTIPrep/subj${i}_to_template_warp.mif" "${reoriented_fixel_dir}"

    # Step 2: Define the subject fixel data file (e.g., AFD)
    subject_fixel_data="${reoriented_fixel_dir}/fd_NOT_REORIENTED.mif"  # Adjust this file name as needed

    # Create output directory for correspondence
    correspondence_output_dir="${base_dir}/${i}/DTIPrep/fixel_masked"
    mkdir -p "${correspondence_output_dir}"

    # Step 3: Run fixel correspondence; you don't have to reorient the fixel mask itself because it is binary 
    echo "Computing fixel correspondence for participant ${i}..."
    fixelcorrespondence "${subject_fixel_data}" "${template_fixel_mask}" "${correspondence_output_dir}" "fd_masked.mif"

    echo "Finished processing participant ${i}."
done

echo "Fixel correspondence complete for all participants."
