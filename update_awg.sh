#!/bin/bash

input_file="cidr4.txt"
output_file="awg.json"

echo "[" > $output_file

first_entry=true
while IFS= read -r ip; do
    if [[ -n "$ip" ]]; then
        if $first_entry; then
            first_entry=false
        else
            echo "," >> $output_file
        fi
        echo "    {" >> $output_file
        echo "        \"hostname\": \"$ip\"," >> $output_file
        echo "        \"ip\": \"\"" >> $output_file
        echo "    }" >> $output_file
    fi
done < $input_file

echo "]" >> $output_file