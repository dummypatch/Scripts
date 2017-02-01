#!/bin/bash
TEMP_FILE="qawsedrefsqwqsadfzxchvj.txt"



#for ((ii=0;ii<100;ii++))
for ((ii=0;ii<15;ii++))
#for ((ii=0;ii<10;ii++))
do
	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal_fluidanimate_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal_canneal_${ii}_trial_on_7.log"

	#CUR_FILE="dmesg_output_0167_alternative_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_alternative_16threads_PARSEC_bal_fluidanimate_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_alternative_16threads_PARSEC_bal_canneal_${ii}_trial_on_7.log"

	#CUR_FILE="dmesg_output_FaceRec_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_PCA_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_LDA_0167_4node_default_ALP_${ii}_trial_on_7.log"

	#CUR_FILE="dmesg_output_FaceRec_0167_4node_alternative_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_PCA_0167_4node_alternative_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_LDA_0167_4node_alternative_ALP_${ii}_trial_on_7.log"

	#CUR_FILE="dmesg_output_0167_default_16threads_nas_bal_ft.C.16_${ii}_trial_on_0.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_nas_bal_lu.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_nas_bal_cg.C.16_${ii}_trial_on_6.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_nas_bal_is.C.16_${ii}_trial_on_0.log"


	#CUR_FILE="dmesg_output_0167_alternative_16threads_nas_bal_ft.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_alternative_16threads_nas_bal_lu.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_alternative_16threads_nas_bal_cg.C.16_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_alternative_16threads_nas_bal_is.C.16_${ii}_trial_on_7.log"

	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal_streamcluster_${ii}_trial_on_6.log"	
	#CUR_FILE="dmesg_output_0145_default_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_0.log"
	#CUR_FILE="dmesg_output_FaceRec_0167_4node_default_ALP_${ii}_trial_on_0.log"
	
	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal_alternative_1_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal_alternative_2_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_FaceRec_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_LDA_0167_4node_alternative_ALP_${ii}_trial_on_7.log"

	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal_streamcluster_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_FaceRec_0167_4node_default_ALP_${ii}_trial_on_0.log"
	#CUR_FILE="dmesg_output_PCA_0167_4node_default_ALP_${ii}_trial_on_7.log"
	#CUR_FILE="dmesg_output_LDA_0167_4node_default_ALP_${ii}_trial_on_7.log"

	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal_alternative_2_streamcluster_${ii}_trial_on_0.log"

	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_6.log"
	#CUR_FILE="dmesg_output_0167_alternative_16threads_PARSEC_bal_streamcluster_${ii}_trial_on_6.log"
	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal__streamcluster_${ii}_trial_on_6.log"

	#CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_bal_alternative_2_streamcluster_${ii}_trial_on_7.log"
	CUR_FILE="dmesg_output_0167_default_16threads_PARSEC_no_bal_default_streamcluster_${ii}_trial_on_1.log"

	if [ -f ./${CUR_FILE} ] ; then
		~/Scripts/dmesg_parsing/extract_dmesg_log.sh ./${CUR_FILE}
		#~/Scripts/dmesg_parsing//dmesg_parse_0145.sh ./${CUR_FILE} > ${TEMP_FILE}
		~/Scripts/dmesg_parsing//dmesg_parse_0167.sh ./${CUR_FILE} > ${TEMP_FILE}
		#~/Results/dmesg_parse_0123.sh ./${CUR_FILE} > ${TEMP_FILE}
		#echo -ne "${ii}_trial :"
		printf "%3s_trial : " ${ii}
		#python ~/Scripts/dmesg_parsing/dict_sum_up_2hop.py ${TEMP_FILE}
		python ~/Scripts/dmesg_parsing/dict_sum_up.py ${TEMP_FILE}
		#python ~/Scripts/dmesg_parsing/sum_up.py ${TEMP_FILE}
	else
		echo "[error] ${CUR_FILE} not exist"
	fi


done
echo $CUR_FILE
