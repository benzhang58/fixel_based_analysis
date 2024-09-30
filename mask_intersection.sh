#!/bin/bash


# Define the source and destination directories
base_dir="/Users/ccri/Desktop/Data_Analysis/MotorLearning"
output_dir="${base_dir}/template/mask_intersection_input"
template_mask="${base_dir}/template/dwi_template_mask.mif"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# List of participants (add or modify participant IDs as needed)
participants=(015 033 037 043 044)  #(001 002 003 004 007 008 010 011 012 013 014 015 016 018 019 020 021 023 024 025 026 028 029 031 033 035 036 037 038 042 043 044 046 048 049 050)

# Step 1: Collect the masks from each participant
for i in "${participants[@]}"; do
    src_file="${base_dir}/${i}/DTIPrep/dwi_upsampled_mask_in_template.mif"
    dest_file="${output_dir}/dwi_upsampled_mask_in_template_${i}.mif"

    # Check if the file exists before copying
    if [[ -f "$src_file" ]]; then
        echo "Copying mask for participant ${i}..."
        cp "$src_file" "$dest_file"
    else
        echo "Warning: Mask file for participant ${i} not found!"
    fi
done

# Step 2: Intersect all the collected masks to create a template mask
echo "Intersecting all masks to create a template mask..."
mask_files=(${output_dir}/*.mif)
mrmath "${mask_files[@]}" min "$template_mask" -datatype bit
echo "Template mask created at: $template_mask"
