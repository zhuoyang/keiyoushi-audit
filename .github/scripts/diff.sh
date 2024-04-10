#!/bin/bash
set -e

dir1=$1
dir2=$2

# Find APK files in the first directory and its subdirectories
find "$dir1" -name "*.apk" -print0 | while IFS= read -r -d '' apk1
do
  # Extract the base name of the APK file
  base_apk=$(basename "$apk1")

  # Find the corresponding APK file in the second directory and its subdirectories
  apk2=$(find "$dir2" -name "$base_apk" -print -quit)
  
  echo "### Result" >> $GITHUB_STEP_SUMMARY
  # Check if the APK file exists in the second directory
  if [ -n "$apk2" ]; then
    # Run the apkdiff.py script
    python main/.github/scripts/apkdiff.py "$apk1" "$apk2"
    if [ $? -ne 0 ]; then
        echo "$base_apk is different from source" >> $GITHUB_STEP_SUMMARY
    fi
  else
    echo "File $base_apk does not exist in the second directory."
  fi
done