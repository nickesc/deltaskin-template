#!/usr/bin/env bash


# Build Script - makes a backup of the current build folder if it exists, clears the build folder, zips the files in every console's deltaskin folder into the build folder as .deltaskin files

source skin.env   # read in skin variables from skin.env
source build.env  # read in build variables from build.env

buildReady=false  # start as not ready to build; need to verify it is ready before flag is set
successful=true   # starts as successful; if something goes wrong, will be set to unsuccessful

if [[ -d "$BUILD_DIR" && ! -z "$(ls -A $BUILD_DIR)" ]]; then  # check the build folder exists and is not empty

    echo "Build directory at $BUILD_DIRECTORY is not empty, making backup..."
    mkdir -p "$BACKUP_DIR"  # make the backup directory if it does not already exist

    temp="_build_backup_"
    \zip -0 -r "$BACKUP_DIR/${DELTASKIN_ABR}${temp}${EPOCHSECONDS}.zip" "$BUILD_DIR"  # zip the old build folder and put it in the backup directory
    if [ $? -eq 0 ]; then
        echo "Build directory backed up to $BACKUP_DIR"

        echo "Clearing build directory at $BUILD_DIRECTORY..."
        rm -r "$BUILD_DIR"  # delete and clear the old build directory
        buildReady=true  # flag as ready to build becuase old build directory has been backed up
    else
        echo "Failed to backup the build directory."
        successful=false  # flag as failing to zip the old build directory and failing to backup and remove it
    fi
else  # if the build folder is empty or does not exist
    echo "Build folder does not exist yet or is empty."
    buildReady=true  # flag as ready to build because there is nothing to back up
fi
echo "Setting up build folder..."
mkdir -p "$BUILD_DIR"  # remake the deleted build folder

echo ""

if [[ $buildReady = true ]]; then
    if [[ -d "$DELTASKIN_DIR" ]]; then
        for system in "${DELTASKINS[@]}"; do
            if [[ -e "$DELTASKIN_DIR/$system/info.json" ]]; then
                fileName="$BUILD_DIR/$ID_PREFIX.$system.$DELTASKIN_ABR.deltaskin"
                echo "Building $system..."
                \zip -0 -j "$fileName" "$DELTASKIN_DIR/$system/"*
                if [ $? -eq 0 ]; then
                    echo "${system^} built to $fileName"
                else
                    echo "Failed to build $system deltaskin."
                    successful=false  # flag as unsuccessful because it failed to build the skin
                fi
                echo ""
            else
                echo "Unable to verify that $DELTASKIN_DIR/$system is a is a deltaskin. Please check that the directory contains an info.json file."
                successful=false  # flag as unsuccessful because no info.json file was found in the skin folder
            fi
        done
    else
        echo "Unable to locate the DELTASKIN_DIR directory ($DELTASKIN_DIR) located in build.env."
        successful=false  # flag as unsuccessful because the listed directory with skins does not exist
    fi
else
    echo "Failed to build .deltaskin files. Please check for any error messages, missing folders or incorrect environment variables."
    successful=false  # flag as unsuccessful because the build was not flagged as ready, so it did not start
fi

if [[ $successful = false ]]; then  # check if build was flagged as unsuccessful
    exit 1  # set unsuccessful exit code
else
    exit 0  # set successful exit code
fi

