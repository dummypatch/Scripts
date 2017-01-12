#!/bin/bash
TEMP_FILE="qawsedrefsqwqsadfzxchvj.txt"


if [ ! $# -eq 1 ]; then
	echo "USAGE : $0 text_file"
	exit ;
fi

CUR_FILE=$1

if [ -f ./${CUR_FILE} ] ; then
	~/Scripts/dmesg_parsing/extract_dmesg_log.sh ./${CUR_FILE}
	~/Scripts/dmesg_parsing//dmesg_parse_0145.sh ./${CUR_FILE} > ${TEMP_FILE}
	python ~/Scripts/dmesg_parsing/dict_sum_up.py ${TEMP_FILE} 1
else
	echo "[error] ${CUR_FILE} not exist"
fi


echo $CUR_FILE
