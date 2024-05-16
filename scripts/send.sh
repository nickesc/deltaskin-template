#!/usr/bin/env bash

source skin.env   # read in skin variables from skin.env
source build.env  # read in build variables from build.env

successful=true   # starts as successful; if something goes wrong, will be set to unsuccessful

if [[ -d "$ICLOUD_DELTASKIN_DIR" ]]; then  # check if the target directory (designed for iCloud) exists
    echo "Sending to iCloud..."
    for skin in "$BUILD_DIR/"*; do  # for each skin in the build directory
        dirSlash="$BUILD_DIR/"
        skinFile="${skin//${dirSlash}}"  # get the name of the .deltaskin file
        icloudSkinDir="$ICLOUD_DELTASKIN_DIR/$DELTASKIN_ABR"  # set the name of the folder for this skin family

        echo "Copying $skin to $icloudSkinDir/$skinFile..."

        mkdir -p "$icloudSkinDir"  # create the folder for this skin family in the icloud directory if it does not already exist

        cp "$skin" "$icloudSkinDir/$skinFile"  # copy the skin file from the build directory to icloud
        if [ $? -eq 0 ]; then  # check if copy was successful
            echo "Copied $skinFile to $icloudSkinDir/$skinFile"
        else
            echo "Failed to copy $skinFile"
            successful=false  # flag as failed because the copy was not completed successfully
        fi
        echo ""
    done
else
    echo "Unable to locate the iCloud Deltaskin folder -- no folder at $ICLOUD_DELTASKIN_DIR"
    successful=false  # flag as unsuccessful because the folder in iCloud was not deetected
fi



if [[ $successful = false ]]; then  # check if build was flagged as unsuccessful
    exit 1  # set unsuccessful exit code
else
    exit 0  # set successful exit code
fi
