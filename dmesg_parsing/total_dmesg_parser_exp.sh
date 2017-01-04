#!/bin/bash
TEMP_FILE="qawsedrefsqwqsadfzxchvj.txt"
SCRIPT_DIR="~/Scripts2/dmesg_parsing"



#for ((ii=0;ii<100;ii++))
for ((ii=0;ii<20;ii++))
do
	#CUR_FILE="dmesg_output_161207_0167_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial_on_0.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial_on_1.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial_on_4.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_alternative_16threads_streamcluster_nobal_streamcluster_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_FaceRec_0145_4node_default_ALP_${ii}_trial_on_5.log"
	CUR_FILE="dmesg_output_FaceRec_0145_4node_alternative_ALP_${ii}_trial_on_0.log"
	if [ -f ./${CUR_FILE} ] ; then
		~/Scripts2/dmesg_parsing/extract_dmesg_log.sh ./${CUR_FILE}
		~/Scripts2/dmesg_parsing//dmesg_parse_0145.sh ./${CUR_FILE} > ${TEMP_FILE}
		#~/Results/dmesg_parse_0123.sh ./${CUR_FILE} > ${TEMP_FILE}
		echo -ne "${ii}_trial\t:\t"
		python ~/Scripts2/dmesg_parsing/sum_up.py ${TEMP_FILE}
	else
		echo "[error] ${CUR_FILE} not exist"
	fi


done
echo $CUR_FILE
