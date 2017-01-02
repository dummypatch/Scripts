#!/bin/bash

TRIALS=(
"29_trial"
"37_trial"
"40_trial"
"50_trial"
"60_trial"
"62_trial"
"64_trial"
"66_trial"
"69_trial"
"72_trial"
"77_trial"
"87_trial"
"98_trial"
"99_trial"
)


for((ii=0;ii<${#TRIALS[*]};ii++))
do
	CUR_TRIAL=${TRIALS[${ii}]}
	#CUR_FILE="161208_0145_default_16threads_nas_no_bal_ft.C.16_${CUR_TRIAL}.log"
	#CUR_FILE="161207_0123_default_16threads_streamcluster_nobal_streamcluster_${CUR_TRIAL}_trial.log"
	CUR_FILE="FaceRec_0123_4node_default_ALP_${CUR_TRIAL}_trial.log"
	if [ -f ./${CUR_FILE} ] ;then
		cat ./${CUR_FILE}|grep "Time in seconds"
	else 
		echo ${CUR_FILE} not exist
	fi
done
echo ${CUR_FILE}
