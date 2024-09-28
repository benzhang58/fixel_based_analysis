#!/bin/bash

# Define the base directory where the participants' data is stored
base_dir="/Users/ccri/Desktop/Data_Analysis/MotorLearning"

# Define the path to the population template FOD map
template_fod="${base_dir}/template_fod.mif"

# List of participant IDs
participants=(001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050)

# Loop through each participant to perform registration and warp to template space
for i in "${participants[@]}"
do
    echo "Processing participant ${i}..."

    # Define paths to the participant's FOD map and output warp files
    fod_file="${base_dir}/fod_input_dir/subj${i}_fod_wm.mif"
    warp_file="${base_dir}/${i}/DTIPrep/subj${i}_to_template_warp.mif"
    warped_fod_file="${base_dir}/${i}/DTIPrep/subj${i}_warped_fod_wm_NOT_REORIENTED.mif"

    # Check if the FOD file exists before proceeding
    if [[ -f "${fod_file}" ]]; then

        # Step 1: Perform non-linear registration (calculate the warp)
        echo "Registering FOD map for participant ${i} to template..."
       mrregister "${fod_file}" "${template_fod}" -nl_warp "${warp_file}" "${base_dir}/${i}/DTIPrep/template_to_subj${i}_warp.mif"

        # Step 2: Apply the warp to move the participant's FOD to template space, DON'T reorient
        echo "Warping FOD map for participant ${i} to template space..."
        mrtransform "${fod_file}" -warp "${warp_file}" -reorient_fod no "${warped_fod_file}"

        echo "Finished processing participant ${i}."

    else
        echo "FOD file for participant ${i} not found, skipping..."
    fi
done
