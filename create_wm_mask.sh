#!/bin/bash

## Create white matter mask and move rois to diffusion space for tracking

dtiinit=`jq -r '.dtiinit' config.json`
fsurfer=`jq -r '.freesurfer' config.json`
export input_nii_gz=$dtiinit/`jq -r '.files.alignedDwRaw' $dtiinit/dt6.json`

source $FREESURFER_HOME/SetUpFreeSurfer.sh

mri_label2vol --seg $fsurfer/mri/aparc+aseg.mgz --temp $input_nii_gz --regheader $fsurfer/mri/aparc+aseg.mgz --o aparc+aseg.nii.gz
    
mri_binarize --i aparc+aseg.nii.gz --min 1 --o mask_anat.nii.gz 
mri_binarize --i aparc+aseg.nii.gz --o wm_anat.nii.gz --match 2 41 16 17 28 60 51 53 12 52 13 18 54 50 11 251 252 253 254 255 10 49 46 7
