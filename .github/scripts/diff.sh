#!/bin/bash
set -e

dir1=$1
dir2=$2
export fail=0
echo "### Result" >> $GITHUB_STEP_SUMMARY
# Find APK files in the first directory and its subdirectories
find "$dir1" -name "*.apk" -print0 | while IFS= read -r -d '' apk1
do
  # Extract the base name of the APK file
  base_apk=$(basename "$apk1")

  # Find the corresponding APK file in the second directory and its subdirectories
  apk2=$(find "$dir2" -name "$base_apk" -print -quit)
  
  # Check if the APK file exists in the second directory
  if [ -n "$apk2" ]; then
    # Run the apkdiff.py script
    python main/.github/scripts/apkdiff.py "$apk1" "$apk2"
    if [ $? -ne 0 ]; then
        echo " - $base_apk is different from source." >> $GITHUB_STEP_SUMMARY
        export fail=1
    fi
  else
    echo " - $base_apk does not exist in the source code." >> $GITHUB_STEP_SUMMARY
    export fail=1
  fi
done

if [ $fail -eq 1 ]; then
  echo "### :x: APK files are different." >> $GITHUB_STEP_SUMMARY
  exit 1
else
  echo "### :white_check_mark: APK files are the same." >> $GITHUB_STEP_SUMMARY
fi