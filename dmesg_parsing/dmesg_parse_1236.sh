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
	"1to3"
	"2to3"
	"2to6"
	"3to1"
	"3to2"
	"6to2"
)

LIST_2HOP=(
	"1to2"
	"1to6"
	"2to1"
	"3to6"
	"6to1"
	"6to3"
	)

LIST_LOCAL=(
	"1to1"
	"2to2"
	"3to3"
	"6to6"
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


