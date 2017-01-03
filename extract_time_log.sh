#!/bin/bash

if [ "$1" == "" ];then
	echo "USAGE : $0 file"
	exit;
fi


CUR_FILE=$1
MIN=`cat ${CUR_FILE}|grep "^real"|awk -F" " '{print $2}'|awk -F"m" '{print $1}'`
SEC=`cat ${CUR_FILE}|grep "^real"|awk -F" " '{print $2}'|awk -F"m" '{print $2}'|awk -F"." '{print $1}'`
SEC2=`cat ${CUR_FILE}|grep "^real"|awk -F" " '{print $2}'|awk -F"m" '{print $2}'|awk -F"." '{print $2}'|awk -F's' '{print $1}'`
MIN=$(( $MIN * 60 ))
if [ ${SEC2} -gt 500 ];then
	echo $(( ${MIN} + ${SEC} + 1)) seconds
else
	echo $(( ${MIN} + ${SEC} )) seconds 
fi
		

