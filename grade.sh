#!/bin/bash
#Moreblessing and Maxi

#build the list of student IDs 
ids=()
for dir in */
do
    id=$(basename "$dir")
    if [ "$id" != "GRADING" ]
    then
        ids+=("$id")
    fi
done

#function to find a student's name 
get_name() {
    while read sid names || [ -n "$sid" ]
    do
        if [ "$sid" = "$1" ]
        then
            last=${names##* }
            first=${names% *}
            echo "$last, $first"
        fi
    done < students.txt
}
 
#set up filenames and write header
for id in "${ids[@]}"
do
    gradefile="$id/dcs211_lab1_$id.txt"
    graded="$id/graded_$id.py"
    rm -f "$graded" #makes sure this deletes any old copies
 
    printf "==============================\n" > "$gradefile"
    printf "DCS 211: Lab 1\n" >> "$gradefile"
    printf "Name: STUDENT_NAME\n" >> "$gradefile"
    printf "Score: STUDENT_SCORE\n" >> "$gradefile"
    printf "==============================\n" >> "$gradefile"
 
#fill in the name
    name=$(get_name "$id")
    sed -i.bak "s/STUDENT_NAME/$name/" "$gradefile"
 
#copy student's submission
    for submission in "$id"/*.py
    do
        cp "$submission" "$graded"
    done
 
#prepares copy for grading
    sed -i.bak 's/^print/#print/' "$graded"
    sed -i.bak 's/^main(/#main(/' "$graded"
    cat GRADING/APPEND.py >> "$graded"

 #run and save output
    python3 "$graded" >> "$gradefile" 2>&1

#extract score and fill in 
    score=$(grep "Total tests passed" "$gradefile" | cut -d ' ' -f 4-)
    sed -i.bak "s|STUDENT_SCORE|$score|" "$gradefile"
 
#deletes any backup files created by i.bak
    rm -f "$gradefile.bak" "$graded.bak"
done
