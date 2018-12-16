#!/bin/bash

NR_NODE=8
NR_SRC_NODE=${NR_NODE}
NR_MID_NODE=${NR_NODE}
NR_DEST_NODE=${NR_NODE}

for((ii=0;ii<${NR_SRC_NODE};ii++))
do
	for((jj=0;jj<${NR_MID_NODE};jj++))
	do
		for((kk=0;kk<${NR_DEST_NODE};kk++))
		do
			for((ll=0;ll<20;ll++))
			do
				#FILE="${ii}_to_${jj}_${ll}_trials.log"
				FILE="${ii}_${jj}_${kk}_${ll}_trials.log"
				if [ -f  ${FILE}  ]; then
					#BW_1=`cat ${ii}_to_${jj}_${ll}_trials.log|grep ^BW|awk -F' ' 'NR==1{print $3}'`
					#BW_2=`cat ${ii}_to_${jj}_${ll}_trials.log|grep ^BW|awk -F' ' 'NR==2{print $3}'`
					#BW_3=`cat ${ii}_to_${jj}_${ll}_trials.log|grep ^BW|awk -F' ' 'NR==3{print $3}'`
					#BW_4=`cat ${ii}_to_${jj}_${ll}_trials.log|grep ^BW|awk -F' ' 'NR==4{print $3}'`

					#BW_1=`cat ${ii}_${jj}_${kk}_${ll}_trials.log|grep ^BW|awk -F' ' 'NR==1{print $3}'`
					#BW_2=`cat ${ii}_${jj}_${kk}_${ll}_trials.log|grep ^BW|awk -F' ' 'NR==2{print $3}'`
					#BW_3=`cat ${ii}_${jj}_${kk}_${ll}_trials.log|grep ^BW|awk -F' ' 'NR==3{print $3}'`
					#BW_4=`cat ${ii}_${jj}_${kk}_${ll}_trials.log|grep ^BW|awk -F' ' 'NR==4{print $3}'`

					BW_1=`cat ${FILE}|grep ^BW|awk -F' ' 'NR==1{print $3}'`
					BW_2=`cat ${FILE}|grep ^BW|awk -F' ' 'NR==2{print $3}'`
					BW_3=`cat ${FILE}|grep ^BW|awk -F' ' 'NR==3{print $3}'`
					BW_4=`cat ${FILE}|grep ^BW|awk -F' ' 'NR==4{print $3}'`
					if [ ${BW_1} != "" ] && [ ${BW_2} != "" ] && [ ${BW_3} != "" ] && [ ! ${BW_4} ==  "" ] ;then
						SUM=`python -c 'print '${BW_1}' + '${BW_2}' + '${BW_3}' + '${BW_4}`
						echo "$FILE $ii->$jj->$kk $SUM"
					fi
				fi
			done
		done
	done

done
