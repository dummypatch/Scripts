#!/bin/bash
#/****************************************************************************
# only applied to default routing table for node placement 0167
#****************************************************************************/ 


if [ $# -eq 0 ]
then
echo "[ERROR] no arguments"
exit
fi


LIST_1HOP=(
	"0to1"
	"1to0"
	"0to6"
	"6to0"
	"1to7"
	"7to1"
	"6to7"
	"7to6"

	"0to2"
	"2to0"
	"6to4"
	"4to6"
	"1to4"
	"4to1"
	"2to7"
	"7to2"
)

#LIST_2HOP=(
#	"0to7"
#	"7to0"
#	"1to6"
#	"6to1"
#	)
#
#LIST_LOCAL=(
#	"0to0"
#	"1to1"
#	"6to6"
#	"7to7"
#	)


FILENAME=$1


for (( ii=0 ; ii<${#LIST_1HOP[*]} ; ii++))
do
	echo " 1 HOP PATH "
	SRC=`echo ${LIST_1HOP[${ii}]}| tr to " "|awk -F" " '{print $1}'`
	DEST=`echo  ${LIST_1HOP[${ii}]}| tr to " "|awk -F" " '{print $2}'`
	cat $FILENAME |grep "src(${SRC})->dest(${DEST})"|grep -i without_nop_traffic
	echo -e ""
done

for (( ii=0 ; ii<${#LIST_2HOP[*]} ; ii++))
do
	echo " 2 HOP PATH "
	SRC=`echo ${LIST_2HOP[${ii}]}| tr to " "|awk -F" " '{print $1}'`
	DEST=`echo  ${LIST_2HOP[${ii}]}| tr to " "|awk -F" " '{print $2}'`
	cat $FILENAME |grep "src(${SRC})->dest(${DEST})"|grep -i without_nop_traffic
	echo -e ""
done


for (( ii=0 ; ii<${#LIST_LOCAL[*]} ; ii++))
do
	echo " LOCAL PATH "
	SRC=`echo ${LIST_LOCAL[${ii}]}| tr to " "|awk -F" " '{print $1}'`
	DEST=`echo  ${LIST_LOCAL[${ii}]}| tr to " "|awk -F" " '{print $2}'`
	cat $FILENAME |grep "src(${SRC})->dest(${DEST})"|grep -i without_nop_traffic
	echo -e ""
done


