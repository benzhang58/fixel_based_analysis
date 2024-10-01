#!/bin/bash

# Define the base directory where the participants' data is stored
base_dir="/Users/ccri/Desktop/Data_Analysis/MotorLearning"
output_dir="/Users/ccri/Desktop/Data_Analysis/MotorLearning"
roi_dir="${base_dir}/template/tractseg_output/bundle_segmentations"

# Define output files for each metric (AFD, logFC, and FDC)
fd_output="${output_dir}/fd_averages.txt"
logfc_output="${output_dir}/logFC_averages.txt"
fdc_output="${output_dir}/fdc_averages.txt"

# Initialize header rows in the output files
echo -n "Participant" > "${fd_output}"
echo -n "Participant" > "${logfc_output}"
echo -n "Participant" > "${fdc_output}"

# Collect all the ROI files (assuming *.nii.gz or *.mif format in the tractseg_output directory)
roi_files=($(ls ${roi_dir}/*))

# Create the header with ROI names in each output file
for roi_file in "${roi_files[@]}"; do
    roi_name=$(basename "${roi_file}" | cut -d'.' -f 1)  # Extract ROI name from filename
    echo -n ",${roi_name}" >> "${fd_output}"
    echo -n ",${roi_name}" >> "${logfc_output}"
    echo -n ",${roi_name}" >> "${fdc_output}"
done

# Add a newline after the header
echo "" >> "${fd_output}"
echo "" >> "${logfc_output}"
echo "" >> "${fdc_output}"

# List of participant IDs
participants=(001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050)

# Loop through each participant
for participant in "${participants[@]}"
do
    echo "Processing participant ${participant}..."
    	
	
    # Define paths to the participant's metric files
    fd_file="${base_dir}/${participant}/DTIPrep/fixel_masked_FINAL/fd_masked.mif"
    logfc_file="${base_dir}/${participant}/FC_directory_FINAL/log_fc.mif"
    fdc_file="${base_dir}/${participant}/FC_directory_FINAL/FDC.mif"
	
	fd_voxel="${base_dir}/${participant}/DTIPrep/fixel_masked_FINAL/fd_masked_voxel.nii.gz"
	logfc_voxel="${base_dir}/${participant}/FC_directory_FINAL/log_fc_voxel.nii.gz"
	fdc_voxel="${base_dir}/${participant}/FC_directory_FINAL/FDC_voxel.nii.gz"
	
	
	fixel2voxel "${fd_file}" mean "${fd_voxel}"
	fixel2voxel "${logfc_file}" mean "${logfc_voxel}"
	fixel2voxel "${fdc_file}" mean "${fdc_voxel}"
	
    
    # Initialize the row for each participant with their ID
    echo -n "${participant}" >> "${fd_output}"
    echo -n "${participant}" >> "${logfc_output}"
    echo -n "${participant}" >> "${fdc_output}"

    # Loop through each ROI file
    for roi_file in "${roi_files[@]}"; do
        # Apply the ROI mask to each metric file and calculate the mean value within the ROI
        fd_mean=$(mrstats "${fd_voxel}" -mask "${roi_file}" -output mean)
        logfc_mean=$(mrstats "${logfc_voxel}" -mask "${roi_file}" -output mean)
        fdc_mean=$(mrstats "${fdc_voxel}" -mask "${roi_file}" -output mean)
        
        # Append the results to the participant's row in each output file
        echo -n ",${fd_mean}" >> "${fd_output}"
        echo -n ",${logfc_mean}" >> "${logfc_output}"
        echo -n ",${fdc_mean}" >> "${fdc_output}"
    done
    
    # Add a newline after each participant's row
    echo "" >> "${fd_output}"
    echo "" >> "${logfc_output}"
    echo "" >> "${fdc_output}"

done

echo "Processing complete for all participants."
