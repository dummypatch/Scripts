#!/bin/bash

if [ "$1" == "" ];then
	echo "USAGE : $0 file"
	exit;
fi

export IFS='%'
CUR_FILE=$1
TEMP_FILE="qawsedrftg_aqswdefrgt.txt"

#START="`grep -i "input is  2" $CUR_FILE |tail -n 1`"		# 0145
START="`grep -i "input is  4" $CUR_FILE |tail -n 1`"		# 0167
END="`grep -i "input is  5" $CUR_FILE |tail -n 1`"

START=$(printf '%s'  "${START}" |awk '{ gsub(/\[/,"\\["); print $0}' |awk '{ gsub(/\]/,"\\]"); print $0}' )
END=$(printf '%s'  "${END}" |awk '{ gsub(/\[/,"\\["); print $0}' |awk '{ gsub(/\]/,"\\]"); print $0}')
#printf '%s\n' "${START}"
#printf '%s\n' "${END}"
cat $CUR_FILE |sed -r '/'${START}'/,/'${END}'/!d' >> ${TEMP_FILE}
mv ${TEMP_FILE} ${CUR_FILE}
#echo ${CUR_FILE} is done.
