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

#for((ii=0;ii<${#TRIALS[*]};ii++))
for((ii=0;ii<20;ii++))
do
	CUR_TRIAL=${TRIALS[${ii}]}
	#CUR_FILE="0167_default_16threads_nas_bal_ft.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="0167_default_16threads_nas_bal_lu.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="0167_default_16threads_nas_bal_cg.C.16_${ii}_trial_on_6.log"
	#CUR_FILE="0167_default_16threads_nas_bal_is.C.16_${ii}_trial_on_7.log"

	#CUR_FILE="0167_alternative_16threads_nas_bal_ft.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="0167_alternative_16threads_nas_bal_lu.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="0167_alternative_16threads_nas_bal_cg.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="0167_alternative_16threads_nas_bal_is.C.16_${ii}_trial_on_7.log"


	if [ -f ./${CUR_FILE} ] ;then
		printf "%s :\t" $CUR_FILE 
		cat ./${CUR_FILE}|grep "Time in seconds"
	else 
		echo ${CUR_FILE} not exist
	fi
done
echo LAST FILE : ${CUR_FILE}
