#!/bin/bash


SCRIPT_ROOT="/home/${USER}/Scripts/dmesg_parsing"

for (( ii=0;ii<10;ii++))
do
	CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_on_0167_abstract_monitor_test_on_sort_bw_first_one_decision_DBW_FIRST_streamcluster_${ii}_trial_on_1.log"

	if [ -f ./${CUR_FILE} ] ; then
		printf "%s :\t" $CUR_FILE
		sh ${SCRIPT_ROOT}/extract_dmesg_log.sh ./${CUR_FILE}
		echo ""
	else
		echo ${CUR_FILE} not exist
	fi

done
echo LAST FILE : ${CUR_FILE}
