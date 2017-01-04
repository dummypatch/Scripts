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
)


for((ii=0;ii<${#TRIALS[*]};ii++))
do
	CUR_TRIAL=${TRIALS[${ii}]}
	#CUR_FILE="161208_0145_default_16threads_nas_no_bal_ft.C.16_${CUR_TRIAL}.log"
	#CUR_FILE="161207_0123_default_16threads_streamcluster_nobal_streamcluster_${CUR_TRIAL}_trial.log"
	CUR_FILE="FaceRec_FaceRec_0145_4node_default_ALP_${CUR_TRIAL}_on_0.log"
	if [ -f ./${CUR_FILE} ] ;then
		cat ./${CUR_FILE}|grep "Time in seconds"
	else 
		echo ${CUR_FILE} not exist
	fi
done
echo ${CUR_FILE}
