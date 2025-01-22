#!/bin/bash

input_file="cidr4.txt"
output_file="wg_allowips.txt"

tr '\n' ',' < "$input_file" | sed 's/,/, /g; s/, $/\n/' > "$output_file"