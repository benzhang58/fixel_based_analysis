cd /Users/ccri/Desktop/Raw_Data/MRI/MotorLearning


for i in  045 #042 043 044 045 046 047 048 049 050 #001 skip  because already done 002 003 004 005 007 008 009 010 011 012 014 015 016 017 019 020 021 022 023 024 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 

do
	
	mkdir -p ./${i}/Fixel_Analysis
 
# Convert dwi.nrrd to dwi.nifti so that it can be input into mrconvert to get a .mif file
 #echo "${i} converting nrrd to nifti"
 
# nifti_write.py -i ${i}/DTIPrep/dwi.nrrd
 
 
 
# Iterate through 003, 004, and 005 files in that order and use the first one that exists
for filename in ./${i}/*64DIFF*003a001.nii.gz ./${i}/*64DIFF*004a001.nii.gz ./${i}/*64DIFF*005a001.nii.gz
do
    if [ -f "$filename" ]; then  # Check if the file exists
        #echo "Using file: $filename"

       # echo "${i} Converting to .mif"
        # mrconvert "$filename" ./${i}/Fixel_Analysis/dwi.mif -fslgrad ./${i}/*64DIFF1000RESEARCH2s*.bvec ./${i}/*64DIFF1000RESEARCH2s*.bval

        break  # Break the loop after finding the first valid file
    fi
done


 
 echo "${i} Denoising"
 
# dwidenoise ./${i}/Fixel_Analysis/dwi.mif ./${i}/Fixel_Analysis/dwi_denoised.mif -force
 
 
 echo "${i} Degibbsing"
 
mrdegibbs ./${i}/Fixel_Analysis/dwi_denoised.mif ./${i}/Fixel_Analysis/dwi_denoised_degibbs.mif -axes 0,1
 
 
# dwifslpreproc ./${i}/DTIPrep/dwi_denoised_degibbs.mif ./${i}/DTIPrep/dwi_denoised_degibbs_preproc.mif -rpe_none -pe_dir AP
 
# dwibiascorrect ant ./${i}/DTIPrep/dwi_denoised_degibbs_preproc.mif ./${i}/DTIPrep/dwi_denoised_degibbs_preproc_unbiased.



# Break the loop after finding the first valid file
        
		
	
 done
 
 
