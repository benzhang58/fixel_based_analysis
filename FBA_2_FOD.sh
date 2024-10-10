cd /Users/ccri/Desktop/Data_Analysis/MotorLearning

for i in 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 
do

echo "Participant ${i}"

echo "Upsampling DWI Data"
# Upsample DWI data to isotropic voxel size of 1.25 mm 
mrgrid ./${i}/Fixel_analysis/dwi_denoised_degibbs_preproc_unbiased.mif regrid -vox 1.25 ./${i}/Fixel_analysis/dwi_denoised_degibbs_preproc_unbiased_upsampled.mif

echo "Computing brain mask"
# Compute brain mask from upsampled data 
dwi2mask ./${i}/Fixel_analysis/dwi_denoised_degibbs_preproc_unbiased_upsampled.mif ./${i}/Fixel_analysis/dwi_upsampled_mask.mif

echo "Estimating FOD"
# Fibre Orientation Distribution estimation (multi-tissue spherical deconvolution) with brain mask --> only get WM and CSF, since we only have two bvals (0 and 1000)
dwi2fod msmt_csd ./${i}/Fixel_analysis/dwi_denoised_degibbs_preproc_unbiased_upsampled.mif ./group_average_response_wm.txt ./${i}/wmfod.mif ./group_average_response_csf.txt ./${i}/csf.mif -mask ./${i}/DTIPrep/dwi_upsampled_mask.mif

echo "Bias field correction and intensity normalization"
# Joint bias field correction and intensity normalisation
mtnormalise ./${i}/wmfod.mif ./${i}/wmfod_norm.mif ./${i}/csf.mif ./${i}/csf_norm.mif -mask ./${i}/DTIPrep/dwi_upsampled_mask.mif

done

