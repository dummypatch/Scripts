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
for((ii=0;ii<15;ii++))
#for((ii=0;ii<10;ii++))
do
	CUR_TRIAL=${TRIALS[${ii}]}
	#CUR_FILE="0167_default_16threads_PARSEC_no_bal_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="0167_default_16threads_PARSEC_no_bal_fluidanimate_${ii}_trial_on_7.log"
	#CUR_FILE="0167_default_16threads_PARSEC_no_bal_canneal_${ii}_trial_on_7.log"

	#CUR_FILE="0167_alternative_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="0167_alternative_16threads_PARSEC_bal_fluidanimate_${ii}_trial_on_7.log"
	#CUR_FILE="0167_alternative_16threads_PARSEC_bal_canneal_${ii}_trial_on_7.log"

	#CUR_FILE="FaceRec_FaceRec_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="PCA_PCA_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="LDA_LDA_0167_4node_default_ALP_${ii}_trial_on_7.log"

	#CUR_FILE="FaceRec_FaceRec_0167_4node_alternative_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="PCA_PCA_0167_4node_alternative_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="LDA_LDA_0167_4node_alternative_ALP_${ii}_trial_on_7.log"

	#CUR_FILE="0167_default_16threads_PARSEC_no_bal_streamcluster_${ii}_trial_on_6.log"
	#CUR_FILE="FaceRec_FaceRec_0167_4node_default_ALP_${ii}_trial_on_0.log"
	#CUR_FILE="0145_default_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_0.log"

	#CUR_FILE="0167_default_16threads_PARSEC_no_bal_alternative_1_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="0167_default_16threads_PARSEC_no_bal_alternative_2_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="FaceRec_FaceRec_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="PCA_PCA_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="LDA_LDA_0167_4node_default_ALP_${ii}_trial_on_7.log"

	#CUR_FILE="0167_default_16threads_PARSEC_no_bal_streamcluster_${ii}_trial_on_7.log"

	#CUR_FILE="0167_default_16threads_PARSEC_no_bal_alternative_2_streamcluster_${ii}_trial_on_0.log"

	#CUR_FILE="0167_default_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_6.log"
	#CUR_FILE="0167_alternative_16threads_PARSEC_bal_streamcluster_0_trial_on_6.log"
	#CUR_FILE="0167_default_16threads_PARSEC_no_bal__streamcluster_${ii}_trial_on_6.log"

	CUR_FILE="0167_default_16threads_PARSEC_no_bal_default_streamcluster_${ii}_trial_on_1.log"





	if [ -f ./${CUR_FILE} ] ;then
		printf "%s :\t" $CUR_FILE
		sh ${SCRIPT_ROOT}/extract_time_log.sh ./${CUR_FILE}
	else 
		echo ${CUR_FILE} not exist
	fi
done
echo LAST FILE : ${CUR_FILE}
