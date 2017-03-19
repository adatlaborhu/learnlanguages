#!/bin/bash

cd ~/friends_sw/
aaa=$(ls -l |wc -l)

echo "" > ~/translated.csv

i=0
while [ $i -le $aaa ]
do
echo $i
(( i++ ))
echo debug1
episode=$(ls | cut -c1-14 |head -$i |tail -1)
echo debug2
char_code=$(chardet $episode* |cut -d':' -f2 |cut -d' ' -f2)
echo debug3
iconv $episode* -f $char_code -t UTF-8 >> ~/translated.csv
echo debug4
done

cat ~/translated.csv |
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
sort -n |
sed -e 's/^[ \t]*//' |
sed 's/ĺ/å/g' > ~/all_data_sw.csv

cat ~/all_data_sw.csv

cat ~/all_data_sw.csv |tail -1000 |awk '{sum += $1} END {print sum}'

cat ~/all_data_sw.csv |awk '{sum += $1} END {print sum}'
