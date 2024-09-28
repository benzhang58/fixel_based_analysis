cd /Users/ccri/Desktop/Data_Analysis/MotorLearning
source /Users/ccri/miniconda3/bin/activate


for i in 001 #002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 

do
 
	# Convert dwi.nrrd to dwi.nifti so that it can be input into mrconvert to get a .mif file
 echo "${i} converting nrrd to nifti"
 
# nifti_write.py -i ${i}/DTIPrep/dwi.nrrd
 
 echo "${i} Converting to .mif"
 
 #mrconvert ./${i}/DTIPrep/dwi.nii.gz ./${i}/DTIPrep/dwi.mif -fslgrad ./${i}/DTIPrep/bvec ./${i}/DTIPrep/bval
 
 echo "${i} Denoising"
 
 #dwidenoise ./${i}/DTIPrep/dwi.mif ./${i}/DTIPrep/dwi_denoised.mif
 
 
 echo "${i} Degibbsing"
 
# mrdegibbs ./${i}/DTIPrep/dwi_denoised.mif ./${i}/DTIPrep/dwi_denoised_degibbs.mif -axes 0,1
 
 
 
 dwifslpreproc ./${i}/DTIPrep/dwi_denoised_degibbs.mif ./${i}/DTIPrep/dwi_denoised_degibbs_preproc.mif -rpe_none -pe_dir AP
 
 dwibiascorrect ant ./${i}/DTIPrep/dwi_denoised_degibbs_preproc.mif ./${i}/DTIPrep/dwi_denoised_degibbs_preproc_unbiased.mif
 
 done