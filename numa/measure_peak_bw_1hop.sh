
#Benchmarks to run:


PROGRAM=/home/hans7taiji/BW_201017/qwer_stream_peak_ld

TEMP_FILE=qwerjqhwejlrnjkha.txt

SRC=$1
DEST=$2

if [ $# -eq 2 ] && [ $SRC -ge 0 ] && [ $SRC -le 7 ] && [ $DEST -ge 0 ] && [ $DEST -le 7 ];then
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	cd /home/hans7taiji/BW_201017
	numactl --cpunodebind=$DEST --membind=$SRC ${PROGRAM} 100 4 > ${TEMP_FILE}
	BW_1=`cat ${TEMP_FILE}|grep ^BW|awk -F' ' 'NR==1{print $3}'`
	BW_2=`cat ${TEMP_FILE}|grep ^BW|awk -F' ' 'NR==2{print $3}'`
	BW_3=`cat ${TEMP_FILE}|grep ^BW|awk -F' ' 'NR==3{print $3}'`
	BW_4=`cat ${TEMP_FILE}|grep ^BW|awk -F' ' 'NR==4{print $3}'`
	if [ ${BW_1} != "" ] && [ ${BW_2} != "" ] && [ ${BW_3} != "" ] && [ ! ${BW_4} ==  "" ] ;then
		SUM=`python -c 'print '${BW_1}' + '${BW_2}' + '${BW_3}' + '${BW_4}`
		echo "$FILE $ii->$jj->$kk $SUM"
	fi
else
	echo "USAGE: $0 SRC_ID DEST_ID"
fi


