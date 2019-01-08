#!/bin/bash

if [  $# -ne 1 ] ||  [ ! -f $1   ]; then
	echo "[ERROR] $0 <filename>"
	exit
fi


FILENAME=$1
echo filename : $FILENAME

LIST_NODE_ID=(
	"0"
	"1"
	"2"
	"3"
	"4"
	"5"
	"6"
	"7"
)


for (( src_idx =0; src_idx < ${#LIST_NODE_ID[*]} ; src_idx++))
do
	for (( mid_idx=0; mid_idx < ${#LIST_NODE_ID[*]} ; mid_idx++))
	do
		for (( dest_idx=0; dest_idx < ${#LIST_NODE_ID[*]} ; dest_idx++))
		do
			ALT_PATH=`echo "src(${LIST_NODE_ID[${src_idx}]})->after_mid(${LIST_NODE_ID[${mid_idx}]})->dest(${LIST_NODE_ID[${dest_idx}]}).*after.*"`
			#echo ${ALT_PATH}
			COUNT=0
			COUNT=`cat ${FILENAME} |grep ${ALT_PATH}|wc -l`
			if [ ${COUNT} -gt 0 ];then
				echo -e "${ALT_PATH}\t${COUNT}"
			fi
		done
	done
done
