cd /Users/ccri/Desktop/Data_Analysis/MotorLearning/template


mrconvert wmfod_template.mif wmfod_template_badStrides.nii.gz
mrconvert wmfod_template_badStrides.nii.gz wmfod_template_goodStrides.nii.gz -strides -1,2,3,4
mrconvert wmfod_template_goodStrides.nii.gz l0.nii.gz -coord 3 0


fslmaths l0.nii.gz -nan l0image_noNaN.nii.gz

flirt -ref FMRIB58_FA_125mm.nii.gz -in l0image_noNaN.nii.gz -out l02MNI_FA.nii.gz -omat template2MNI.mat -dof 12
fnirt --ref=FMRIB58_FA_125mm.nii.gz --in=l0image_noNaN.nii.gz --aff=template2MNI.mat --cout=warp_template2MNI

warpinit l0image_noNaN.nii.gz identity_warp_wmFOD_template.nii.gz

applywarp --ref=FMRIB58_FA_125mm.nii.gz --in=identity_warp_wmFOD_template.nii.gz --warp=warp_template2MNI.nii.gz --out=mrtrix_warp_template2MNI.nii.gz


mrconvert identity_warp_wmFOD_template.nii.gz -coord 3 0 - | mrcalc - 0 -mult 1 -add identity_warp_wmFOD_template_mask.nii.gz

applywarp --ref=FMRIB58_FA_125mm.nii.gz --in=identity_warp_wmFOD_template_mask.nii.gz --warp=warp_template2MNI.nii.gz --out=mrtrix_warp_template2MNI_mask.nii.gz

mrcalc mrtrix_warp_template2MNI_mask.nii.gz 1 nan -if mrtrix_warp_template2MNI.nii.gz -mult mrtrix_warp_template2MNI_valid.nii.gz

mrtransform wmfod_template_goodStrides.nii.gz -warp mrtrix_warp_template2MNI_valid.nii.gz -template FMRIB58_FA_125MM.nii.gz wmfod_template_MNIspace.nii.gz -reorient_fod yes

mrconvert wmfod_template_MNIspace.nii.gz wmfod_template_MNI.mif
