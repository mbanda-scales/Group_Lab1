#!/usr/bin/env bash

if [[ -d "file_renaming" ]]; then
    cd "file_renaming"
fi

for dir in Chapter*/; do
    for filepath in "${dir}"DataSet*; do
        # Ensure the file exists
        if [[ -f "$filepath" ]]; then
            
            dirpath=$(dirname "$filepath")
            filename=$(basename "$filepath")
            currentDate=$(date +"%d%b%Y")
            chapterNum="${dirpath#*Chapter}"
            chapterNum="${chapterNum%/}"
            temp="${filename#DataSet}"
            datasetNum="${temp%.*}"
            extension="${filename##*.}"
            newName="CH${chapterNum}_DS${datasetNum}_${currentDate}.${extension}"
            mv "$filepath" "${dirpath}/${newName}"
            echo "Renamed: $filepath -> ${dirpath}/${newName}"
        fi
    done
done

echo "Renamed successfully"