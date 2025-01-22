#!/bin/bash

aria2c -o youtubeparsed --allow-overwrite \
  'https://raw.githubusercontent.com/nickspaargaren/no-google/master/categories/youtubeparsed'

aria2c -o facebook --allow-overwrite \
   'https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/facebook/all'

echo "$(grep -oP '^([\w\d.-]+\.)+([\w\d.-]+)?' youtubeparsed)" > parsed
echo "$(grep -oP '(?<=0\.0\.0\.0 ).*' facebook)" >> parsed
cat myblock.txt >> parsed

parallel -P "$(nproc)" -j0 -a parsed '\
line="{}"
dig +short A $line | grep -v "\.$" >> ipv4_list.txt
dig +short AAAA $line | grep -v "\.$" >> ipv6_list.txt
echo "dig complete for $line ..."
'

sort -u -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n ipv4_list.txt -o ipv4_list.txt
sort -u ipv6_list.txt -o ipv6_list.txt # for now
