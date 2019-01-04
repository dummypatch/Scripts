#!/bin/bash


SCRIPT_ROOT="/home/${USER}/Scripts/dmesg_parsing"
LIST_NODE_ID=(
	"0"
	"1"
	"6"
	"7"
	)

for (( ii=0;ii<10;ii++))
do
	for (( jj=0; jj< ${#LIST_NODE_ID[*]} ; jj++))
	do
		#CUR_FILE="dmesg_output_0167_16threads_PARSEC_abstract_monitor_test_on_sort_bw_first_one_decision_DBW_FIRST_streamcluster_${ii}_trial_on_${LIST_NODE_ID[$jj]}.log"
		CUR_FILE="dmesg_output_0167_16threads_PARSEC_abstract_monitor_test_on_sort_bw_first_one_decision_DBW_FIRST_streamcluster_${ii}_trial_on_${LIST_NODE_ID[$jj]}.log"

		if [ -f ./${CUR_FILE} ] ; then
			printf "%s :\t" $CUR_FILE
			sh ${SCRIPT_ROOT}/extract_dmesg_log.sh ./${CUR_FILE}
			echo ""
		else
			echo ${CUR_FILE} not exist
		fi
	done

done
echo LAST FILE : ${CUR_FILE}
