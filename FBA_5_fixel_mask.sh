#!/bin/bash

# Define the base directory where the participants' data is stored
base_dir="/Users/ccri/Desktop/Data_Analysis/MotorLearning"

# Define the path to the population template FOD map
template_fod="${base_dir}/template_fod.mif"

# Define the output directory for the template mask
template_mask="${base_dir}/template/template_mask.mif"
mkdir -p "${base_dir}/template"

# List of participant IDs
participants=(001 002 003 004 005 007 008 009 010 011 012 014 015 016 017 019 020 021 022 023 024 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050)

# Step 1: Warp masks to template space (assuming this is done)

# Step 2: Collect warped masks and compute the template mask as the intersection
echo "Computing the template mask from participant masks..."
input_masks=()
for i in "${participants[@]}"; do
    input_masks+=("${base_dir}/${i}/DTIPrep/mask_in_template_space.mif")
done

# Use mrmath to compute the intersection of all warped masks
mrmath "${input_masks[@]}" min "${template_mask}" -datatype bit

# Step 3: Perform FOD to fixel segmentation for the template using the template mask
echo "Segmenting fixels from the template FOD map..."
fod2fixel -mask "${template_mask}" -fmls_peak_value 0.06 "${template_fod}" "${base_dir}/template/fixel_mask"

echo "Fixel mask creation complete."
