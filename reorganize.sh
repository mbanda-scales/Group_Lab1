#!/usr/bin/env bash

if [[ -d "file_renaming" ]]; then
    cd "file_renaming"
fi

for filepath in Chapter*; do

    if [[ -f "$filepath" ]]; then
        
        filename=$(basename "$filepath")
        temp1="${filename#Chapter }"
        chap="${temp1%% Data*}"
        temp2="${filename#*Set }"
        ds="${temp2%.*}"
        target_dir="Chapter${chap}"
        mkdir -p "$target_dir"

        cp "$filepath" "${target_dir}/DataSet${ds}.sav"
        echo "Copied: $filename -> ${target_dir}/DataSet${ds}.sav"
    fi
done

echo "Reorganised the files"