#!/bin/bash

# Set the path to your folder containing the mask files
folder_path="/Volumes/exhale/MRI/Motorlearning/mask_input"

# Iterate through all the files with .nii.gz or .mif extensions in the folder
for mask in "$folder_path"/*.nii.gz "$folder_path"/*.mif
do
    # Check if the file exists (in case there are no .nii.gz or .mif files)
    if [ -e "$mask" ]; then
        echo "Opening $mask in mrview..."
        
        # Open the mask in mrview and wait until it's closed before moving to the next one
        mrview "$mask"
        
        echo "Closed $mask, moving to the next one..."
    else
        echo "No valid mask files found in $folder_path"
    fi
done
