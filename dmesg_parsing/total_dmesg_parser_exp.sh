#!/bin/bash
TEMP_FILE="qawsedrefsqwqsadfzxchvj.txt"



#for ((ii=0;ii<100;ii++))
for ((ii=0;ii<5;ii++))
#for ((ii=15;ii<25;ii++))
#for ((ii=0;ii<10;ii++))
do
	CUR_FILE="dmesg_output_parsec_0145_dynamic_canneal_${ii}_trial_on_5.log"
	
	## below ATC 2019
	#CUR_FILE="dmesg_output_parsec_0167_dynamic_blackscholes_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_LDA_0167_4node_default_ALP_${ii}_trial_6.log"
	#CUR_FILE="dmesg_output_parsec_streamcluster_dyn_1decision_streamcluster_${ii}_trial.log"
	#CUR_FILE="dmesg_output_0167_16threads_PARSEC_abstract_monitor_two_hop_percent_first_and_new_algo_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_16threads_PARSEC_abstract_monitor_test_on_sort_bw_first_one_decision_DBW_FIRST_streamcluster_${ii}_trial_on_7.log"
	## ASPLOS 2019 
	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_streamcluster_${ii}_trial_on_0.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_6.log"
	#CUR_FILE="dmesg_output_LDA_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_PCA_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_FaceRec_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_nas_nobal_is.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_nobal_streamcluster_${ii}_trial_on_5.log"

	if [ -f ./${CUR_FILE} ] ; then
		## should be changed !!!! according to node placement
		~/Scripts/dmesg_parsing/extract_dmesg_log.sh ./${CUR_FILE}
		#/****************************************************************************
		# Select nodeplacement  for dmesg_parse_
		#****************************************************************************/ 
		~/Scripts/dmesg_parsing//dmesg_parse_0145.sh ./${CUR_FILE} > ${TEMP_FILE}		# 0145
		#~/Scripts/dmesg_parsing//dmesg_parse_0167.sh ./${CUR_FILE} > ${TEMP_FILE}		# 0167
		#~/Scripts/dmesg_parsing//dmesg_parse_1236.sh ./${CUR_FILE} > ${TEMP_FILE}		# 0167
		#~/Scripts/dmesg_parsing//dmesg_parse_all_nodes.sh ./${CUR_FILE} > ${TEMP_FILE}	# all nodes (0~7)
		#~/Results/dmesg_parse_0123.sh ./${CUR_FILE} > ${TEMP_FILE}
		#echo -ne "${ii}_trial :"
		printf "%3s_trial : " ${ii}
		#/****************************************************************************
		# Select dict_sum_up type
		#****************************************************************************/ 
		#python ~/Scripts/dmesg_parsing/dict_sum_up_2hop.py ${TEMP_FILE}
		#python ~/Scripts/dmesg_parsing/dict_sum_up.py ${TEMP_FILE} 1	# detail
		python ~/Scripts/dmesg_parsing/dict_sum_up.py ${TEMP_FILE}		# summary
		#python ~/Scripts/dmesg_parsing/sum_up.py ${TEMP_FILE}
	else
		echo "[error] ${CUR_FILE} not exist"
	fi


done
echo $CUR_FILE
