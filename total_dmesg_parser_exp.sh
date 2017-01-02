#!/bin/bash
TEMP_FILE="qawsedrefsqwqsadfzxchvj.txt"

for ((ii=0;ii<100;ii++))
do
	#CUR_FILE="dmesg_output_161207_0167_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial.log"
	#CUR_FILE="dmesg_output_161208_0145_default_16threads_nas_no_bal_ft.C.16_${ii}_trial.log"
	#CUR_FILE="dmesg_output_161207_0123_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial.log"
	#CUR_FILE="dmesg_output_PCA_0123_4node_default_ALP_${ii}_trial.log"
	#CUR_FILE="dmesg_output_161207_0123_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial.log"
	CUR_FILE="dmesg_output_0145_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial.log"
	if [ -f ./${CUR_FILE} ] ; then
		~/Results/extract_dmesg_log.sh ./${CUR_FILE}
		~/Results/dmesg_parse_0145.sh ./${CUR_FILE} > ${TEMP_FILE}
		#~/Results/dmesg_parse_0123.sh ./${CUR_FILE} > ${TEMP_FILE}
		echo -ne "${ii}_trial\t:\t"
		python ~/Results/sum_up.py ${TEMP_FILE}
	else
		echo "[error] ${CUR_FILE} not exist"
	fi


done
echo $CUR_FILE
