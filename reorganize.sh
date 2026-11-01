#!/bin/bash
#Moreblessing and Maxi

for file in Chapter*Data\ Set*.sav
do
    if [ -f "$file" ] #checks that a file exists
    then
        chapter=$(echo "$file" | cut -d ' ' -f 2)
        dataset=$(echo "$file" | cut -d ' ' -f 5)
        dataset=${dataset%.sav}
        mkdir -p "Chapter$chapter"
        cp "$file" "Chapter$chapter/DataSet$dataset.sav"
    fi
done

echo "Reorganised the files"
