#!/bin/bash
#Moreblessing and Maxi

today=$(date +%d%b%Y)

build_name() {
    chapter=$1
    dataset=$2
    echo "CH${chapter}_DS${dataset}_${today}.sav"
}

for file in Chapter*/DataSet*.sav
do
    if [ -f "$file" ] #checks that a file exists
    then
        dir=$(dirname "$file")
        base=$(basename "$file")
        chapter=${dir#Chapter}
        dataset=${base#DataSet}
        dataset=${dataset%.sav}
        newname=$(build_name "$chapter" "$dataset")
        mv "$file" "$dir/$newname"
    fi
done



echo "Renamed successfully"
