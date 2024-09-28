# Fixel-based Analysis Pipeline

### 1. Preprocess DWI data : Denoising, Gibbs ringings removal, motion and distortion correction, bias field correction

### 2. Calculate 3-tissue response functions, representing white matter, grey matter, CSF; then compute group averages of the response functions

### 3. Upsample DWI data to 1.25 mm voxel size before computing fiber orientation distributions 

### 4. Compute brain masks from upsampled DWI data

### 5. Estimate Fiber orientation distributions (FOD) with multi-tissue spherical deconvolution

### 6. Perform joint bias correction and intensity normalization

### 7. Generate study population-specific FOD template 

### 8. Register and warp all participant FOD maps to population template

### 9. Compute template mask by warping all DWI masks into template space, then intersect all of them. NOTE : need to make sure all brain masks are not missing any regions, since a single missing region will cause brain mask to be missing that region

### 10. Compute white matter template fixel mask by using fod2fixel on population FOD map while applying template mask

### 11. Segment FOD images for each participant to estimate fixels and apparent fiber density (AFD), then reorient to template space

### 12. Assign participant fixel maps to template fixel mask 

### 13. Compute Fiber cross section metric 

### 14. Can use TractSeg to generate tract segmentations to study specific regions of interest (ROI) and compute average fiber density or cross section in each tract 
