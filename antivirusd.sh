#!/bin/bash

folder_to_scan="$1"
quarantine_folder="$2"
interval="$3"
mkdir -p "$quarantine_folder"
ls -l "$folder_to_scan" > directory-info.last

scan_files() {
for file in "$folder_to_scan"/*
 do
    [ -f "$file" ] || continue
    is_malicious=0
    case "$file" in
        *.exe|*.bat|*.vbs|*.scr|*.ps1)
           is_malicious=1  
          ;;
        *)
            ;;
    esac
if grep -Eiq 'virus|trojan|malware|worm|ransomware' "$file"
then
      is_malicious=1
fi

if [ "$is_malicious" -eq 1 ]
then
    if cp "$file" "$quarantine_folder/"
    then
        echo "$file is malicious and it is DELETED"
        rm -- "$file"
    else
        echo "Could not quarantine $file; original kept"
    fi
else
    echo "$file is safe"
fi
done
}
scan_files
ls -l "$folder_to_scan" > directory-info.last

while true
do
    sleep "$interval"
    ls -l "$folder_to_scan" > directory-info.new
    if ! diff -q directory-info.last directory-info.new > /dev/null
    then
         scan_files
        cp directory-info.new directory-info.last
    fi
done
