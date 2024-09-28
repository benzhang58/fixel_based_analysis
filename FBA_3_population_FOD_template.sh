cd /Users/ccri/Desktop/Data_Analysis/MotorLearning

# Define directories for FOD and mask inputs
mkdir -p ./template/fod_input
mkdir -p ./template/mask_input

#Subject ID# ### Patients 6 dropped out and 18 does not have complete DTI data ###
for i in 001 002 003 004 005 007 008 009 010 011 012 014 015 016 017 019 020 021 022 023 024 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 
do
	  echo "Processing Participant ${i}"
	  echo "Moving wmfod_norm and mask for ${i}"
  
	  # Copy the wmfod_norm and mask files into the respective template directories
	  cp ./${i}/wmfod_norm.mif ./template/fod_input/${i}_wmfod_norm.mif
	  cp ./${i}/DTIPrep/dwi_upsampled_mask.mif ./template/mask_input/${i}_dwi_upsampled_mask.mif
	 
  done


# Step 3: Build the population template with specified voxel size
echo "Building population template..."
population_template ./template/fod_input -mask_dir ./template/mask_input ./template/wmfod_template.mif -voxel_size 1.25
