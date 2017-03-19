#!/bin/bash

cat ~/friends/* ~/himym/* |
grep -v '^[0-9]' |
sed 's/[?!.|]/ /g' |
sed 's/ * / /g' |
sed "s/[^A-Za-z\' ]//g" |
sed 's/^ //g' |
sed 's/ /\n/g' |
sed '/^$/d' |
sed -e 's/\(.*\)/\L\1/' |
sort |
uniq -c |
sort -rn |
sed -e 's/^[ \t]*//' > all_data.csv

cat all_data.csv |head -1000 > 1000.csv

cat all_data.csv |head -1000 |awk '{sum += $1} END {print sum}'

cat all_data.csv |awk '{sum += $1} END {print sum}'
