cd /Users/ccri/Desktop/Data_Analysis/MotorLearning

#Subject ID# ### Patients 6 dropped out and 18 does not have complete DTI data ### take out 6, 13, 18, 25
for i in 001 002 003 004 005 007 008 009 010 011 012 014 015 016 017 019 020 021 022 023 024 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 
do

echo ${i}

dwi2response dhollander ./${i}/DTIPrep/dwi_denoised_degibbs_preproc_unbiased.mif ./${i}/DTIPrep/wm_response.txt ./${i}/DTIPrep/gm_response.txt ./${i}/DTIPrep/csf_response.txt 

    wm_response_files="${wm_response_files} ./${i}/DTIPrep/wm_response.txt"
    gm_response_files="${gm_response_files} ./${i}/DTIPrep/gm_response.txt"
    csf_response_files="${csf_response_files} ./${i}/DTIPrep/csf_response.txt"

done


# After processing all subjects, calculate group averages by passing all response files as inputs
echo "Averaging white matter response functions..."
responsemean $wm_response_files ./group_average_response_wm.txt

echo "Averaging grey matter response functions..."
responsemean $gm_response_files ./group_average_response_gm.txt

echo "Averaging CSF response functions..."
responsemean $csf_response_files ./group_average_response_csf.txt
