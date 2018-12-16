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
	"0to2"
	"0to4"
	"0to6"
	"1to0"
	"1to3"
	"1to4"
	"1to7"
	"2to0"
	"2to3"
	"2to4"
	"2to5"
	"2to6"
	"2to7"
	"3to1"
	"3to2"
	"3to4"
	"3to5"
	"4to0"
	"4to1"
	"4to2"
	"4to3"
	"4to5"
	"4to6"
	"5to2"
	"5to3"
	"5to4"
	"5to7"
	"6to0"
	"6to2"
	"6to4"
	"6to7"
	"7to1"
	"7to2"
	"7to5"
	"7to6"
)

LIST_2HOP=(
	"0to3"
	"0to5"
	"0to7"
	"1to3"
	"1to5"
	"1to6"
	"2to1"
	"3to0"
	"3to6"
	"3to7"
	"4to7"
	"5to0"
	"5to1"
	"5to6"
	"6to1"
	"6to3"
	"6to5"
	"7to0"
	"7to3"
	"7to4"
	)

LIST_LOCAL=(
	"0to0"
	"1to1"
	"2to2"
	"3to3"
	"4to4"
	"5to5"
	"6to6"
	"7to7"
	)


FILENAME=$1


for (( ii=0 ; ii<${#LIST_1HOP[*]} ; ii++))
do
	echo " 1 HOP PATH "
	SRC=`echo ${LIST_1HOP[${ii}]}| tr to " "|awk -F" " '{print $1}'`
	DEST=`echo  ${LIST_1HOP[${ii}]}| tr to " "|awk -F" " '{print $2}'`
	cat $FILENAME |grep "src(${SRC})->dest(${DEST})"|grep -i dram
	echo -e ""
done

for (( ii=0 ; ii<${#LIST_2HOP[*]} ; ii++))
do
	echo " 2 HOP PATH "
	SRC=`echo ${LIST_2HOP[${ii}]}| tr to " "|awk -F" " '{print $1}'`
	DEST=`echo  ${LIST_2HOP[${ii}]}| tr to " "|awk -F" " '{print $2}'`
	cat $FILENAME |grep "src(${SRC})->dest(${DEST})"|grep -i dram
	echo -e ""
done


for (( ii=0 ; ii<${#LIST_LOCAL[*]} ; ii++))
do
	echo " LOCAL PATH "
	SRC=`echo ${LIST_LOCAL[${ii}]}| tr to " "|awk -F" " '{print $1}'`
	DEST=`echo  ${LIST_LOCAL[${ii}]}| tr to " "|awk -F" " '{print $2}'`
	cat $FILENAME |grep "src(${SRC})->dest(${DEST})"|grep -i dram
	echo -e ""
done


