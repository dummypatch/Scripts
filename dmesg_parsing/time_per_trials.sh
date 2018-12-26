#!/bin/bash

TRIALS=(
"0_trial"
"1_trial"
"2_trial"
"3_trial"
"4_trial"
"5_trial"
"6_trial"
"7_trial"
"8_trial"
"9_trial"
"10_trial"
"11_trial"
"12_trial"
"13_trial"
"14_trial"
"15_trial"
"16_trial"
"17_trial"
"18_trial"
"19_trial"
"20_trial"
"21_trial"
"22_trial"
"23_trial"
"24_trial"
"25_trial"
"26_trial"
"27_trial"
"28_trial"
"29_trial"
"30_trial"
"31_trial"
"32_trial"
"33_trial"
"34_trial"
"35_trial"
"36_trial"
"37_trial"
"38_trial"
"39_trial"
"40_trial"
"41_trial"
"42_trial"
"43_trial"
"44_trial"
"45_trial"
"46_trial"
"47_trial"
"48_trial"
"49_trial"
"50_trial"
"51_trial"
"52_trial"
"53_trial"
"54_trial"
"55_trial"
"56_trial"
"57_trial"
"58_trial"
"59_trial"
)

SCRIPT_ROOT="/home/${USER}/Scripts/"
#for((ii=0;ii<${#TRIALS[*]};ii++))
for((ii=0;ii<10;ii++))
#for((ii=15;ii<25;ii++))
#for((ii=0;ii<10;ii++))
do
	CUR_TRIAL=${TRIALS[${ii}]}

	# ASPLOS 2019
	#CUR_FILE="FaceRec_FaceRec_0167_4node_default_ALP_${ii}_trial.log"
	#CUR_FILE="PCA_PCA_0167_4node_default_ALP_${ii}_trial.log"
	#CUR_FILE="LDA_LDA_0167_4node_default_ALP_${ii}_trial.log"
	#CUR_FILE="FaceRec_FaceRec_0145_4node_default_ALP_${ii}_trial.log"
	#CUR_FILE="PCA_PCA_0145_4node_default_ALP_${ii}_trial.log"
	#CUR_FILE="LDA_LDA_0145_4node_default_ALP_${ii}_trial.log"
	#CUR_FILE="4node_wonjun_0167_parsec_no_dyn_streamcluster_${ii}_trial.log"
	#CUR_FILE="0167_default_16threads_PARSEC_NEW_streamcluster_${ii}_trial_on_0.log"
	#CUR_FILE="0167_default_16threads_PARSEC_on_0167_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="0167_default_16threads_PARSEC_on_0167_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="0167_default_16threads_PARSEC_on_0167_abstract_monitor_streamcluster_${ii}_trial_on_0.log"
	#CUR_FILE="0167_default_16threads_PARSEC_on_0167_abstract_monitor_test_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="0167_default_16threads_PARSEC_on_0167_abstract_monitor_test_on_r1_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="0167_default_16threads_PARSEC_on_0167_abstract_monitor_test_on_sort_bw_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="0167_16threads_PARSEC_abstract_monitor_test_on_sort_bw_first_one_decision_DBW_FIRST_streamcluster_${ii}_trial_on_0.log"
	CUR_FILE="0167_16threads_PARSEC_abstract_monitor_test_on_sort_bw_first_one_decision_DBW_FIRST_streamcluster_${ii}_trial_on_7.log"
	
	

	if [ -f ./${CUR_FILE} ] ;then
		printf "%s :\t" $CUR_FILE
		sh ${SCRIPT_ROOT}/extract_time_log.sh ./${CUR_FILE}
	else 
		echo ${CUR_FILE} not exist
	fi
done
echo LAST FILE : ${CUR_FILE}
