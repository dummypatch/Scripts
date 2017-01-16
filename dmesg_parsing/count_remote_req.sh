#!/bin/bash
TEMP_FILE="qawsedrefsqwqsadfzxchvj.txt"

NODE_PLACEMENT=(
	"0"
	"1"
#	"4"
#	"5"
)

#for ((ii=0;ii<100;ii++))
for ((ii=0;ii<20;ii++))
#for ((ii=0;ii<40;ii++))
#for ((ii=40;ii<60;ii++))
do
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_bal_fluidanimate_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_bal_canneal_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"
	#CUR_FILE="dmesg_output_FaceRec_0145_4node_default_ALP_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"
	#CUR_FILE="dmesg_output_PCA_0145_4node_default_ALP_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"
	#CUR_FILE="dmesg_output_LDA_0145_4node_default_ALP_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_bal_ft.C.16_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_bal_lu.C.16_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_bal_cg.C.16_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_bal_is.C.16_${ii}_trial_on_${NODE_PLACEMENT[$kk]}.log"

	#CUR_FILE="dmesg_output_0145_default_16threads_streamcluster_nobal_streamcluster_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_nobal_fluidanimate_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_nobal_canneal_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_FaceRec_0145_4node_default_ALP_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_PCA_0145_4node_default_ALP_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_LDA_0145_4node_default_ALP_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_no_bal_ft.C.16_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_no_bal_lu.C.16_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_no_bal_cg.C.16_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_no_bal_is.C.16_${ii}_trial_on_4.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_nobal_canneal_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_no_bal_cg.C.16_${ii}_trial_on_1.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_bal_fluidanimate_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_bal_canneal_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_FaceRec_0145_4node_default_ALP_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_PCA_0145_4node_default_ALP_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_LDA_0145_4node_default_ALP_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_bal_ft.C.16_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_bal_lu.C.16_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_bal_cg.C.16_${ii}_trial_on_5.log"
	#CUR_FILE="dmesg_output_0145_default_16threads_nas_bal_is.C.16_${ii}_trial_on_5.log"
	CUR_FILE="dmesg_output_LDA_0145_4node_default_ALP_${ii}_trial_on_4.log"
		

	if [ -f ./${CUR_FILE} ] ; then
		~/Scripts/dmesg_parsing/extract_dmesg_log.sh ./${CUR_FILE}
		~/Scripts/dmesg_parsing//dmesg_parse_0145.sh ./${CUR_FILE} > ${TEMP_FILE}
		#~/Results/dmesg_parse_0123.sh ./${CUR_FILE} > ${TEMP_FILE}
		#echo -ne "${ii}_trial :"
		printf "%3s_trial : " ${ii}
		python ~/Scripts/dmesg_parsing/count_remote_req_core.py ${TEMP_FILE} 
	else
		echo "[error] ${CUR_FILE} not exist"
	fi


done
echo $CUR_FILE
