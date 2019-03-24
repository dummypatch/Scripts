#!/bin/bash

if [ $# -ne 1 ] || [ ! -f $1 ]; then
	echo "[ERROR] $0 <filename>"
	exit
fi

FILENAME=$1
echo filename : $FILENAME

LIST_NODE_ID=(
	"0"
	"1"
	#"2"
	#"3"
	#"4"
	#"5"
	"6"
	"7"
)

TEMP_FILENAME="qjweqhwiejbrfnjksdb.txt"
DEBUG=0
PREV_MSEC=0

echo -e "EPOCH\tCUR_TWO_HOP_PATH\tTIMESTAMP\tMSEC\tINTERVAL\tCUR_TWO_HOP_BW\tCUR_TWO_HOP_PEAK_BW\tBW_RATIO"
NR_EPOCH=`cat ${FILENAME}|grep EPOCH|tail -n 1|awk -F" " '{print $8}'`
for (( src_idx=0;src_idx<${#LIST_NODE_ID[*]};src_idx++))
do
	for (( dest_idx=0;dest_idx<${#LIST_NODE_ID[*]};dest_idx++))
	do
		#cat ${FILENAME} | grep ${TWO_HOP_PATH}|wc -l

		TWO_HOP_PATH=`echo ".*BW(${LIST_NODE_ID[${src_idx}]}->.*->${LIST_NODE_ID[${dest_idx}]}).*"`
		cat ${FILENAME} | grep ${TWO_HOP_PATH} > ${TEMP_FILENAME}
		IS_EMPTY=`file ${TEMP_FILENAME}|awk -F" " '{print $2}'`
		if [ ${IS_EMPTY} == "empty" ];then
			continue;
		fi;

		if [ ${NR_EPOCH} -gt 0   ] ;then
			for (( line_idx=1;line_idx <= ${NR_EPOCH} ; line_idx++))
			do
				LINE_DATA=`sed -n ${line_idx}p ${TEMP_FILENAME}`
				#LINE_DATA=`cat ${FILENAME} | grep ${TWO_HOP_PATH} | awk -F" " 'NR=='${line_idx}'{print $0}'`
				#CUR_TWO_HOP_PATH="${LIST_NODE_ID[${src_idx}]}->${LIST_NODE_ID[${mid_idx}]}->${LIST_NODE_ID[${dest_idx}]}"
				CUR_TWO_HOP_PATH=`echo ${LINE_DATA}|awk -F" " '{print $12}'|tr -d 'BW()'`
				TIMESTAMP=`echo ${LINE_DATA}|awk -F" " '{print $2}'|tr -d '[]'|bc `
				EPOCH=`echo ${LINE_DATA}|awk -F" " '{print $8}'`
				MSEC=`echo ${LINE_DATA}|awk -F" " '{print $10}'`
				INTERVAL=`bc <<< "${MSEC}-${PREV_MSEC}"`
				PREV_MSEC=${MSEC}
				CUR_TWO_HOP_BW=`echo ${LINE_DATA}|awk -F" " '{print $18}'`
				CUR_TWO_HOP_PEAK_BW=`echo ${LINE_DATA}|awk -F" " '{print $20}'`
				BW_RATIO=`bc <<< "scale=2;${CUR_TWO_HOP_BW}/${CUR_TWO_HOP_PEAK_BW}"`
				echo -e "${EPOCH}\t${CUR_TWO_HOP_PATH}\t${TIMESTAMP}\t${MSEC}\t${INTERVAL}\t${CUR_TWO_HOP_BW}\t${CUR_TWO_HOP_PEAK_BW}\t${BW_RATIO}"
				if [ ${DEBUG} -eq 1 ];then
					for ((ii=0;ii<30;ii++))
					do
						echo "${ii} : " `echo ${LINE_DATA}|awk -F" " '{print $'${ii}'}'`
					done
					exit;
				fi

			done
			echo -e "\n\n"
		fi
	done
done


