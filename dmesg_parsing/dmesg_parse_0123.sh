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
	"0to2"
	"2to0"
	"1to3"
	"3to1"
	"2to3"
	"3to2"
)

LIST_2HOP=(
	"0to3"
	"3to0"
	"1to2"
	"2to1"
	)

LIST_LOCAL=(
	"0to0"
	"1to1"
	"2to2"
	"3to3"
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


