#!/bin/bash
if [ $# -eq 0 ]
then
	echo "[ERROR] no arguments"
	exit
fi
target=$1
line=`ps aux|grep -i $target|wc -l`
#line=`ps aux|grep -i $target`

echo $line
echo 
echo
echo
if [ $line -eq 1 ] 
then
	echo "keke"
	exit 1
fi
echo "keke2"
line=`expr $line - 1`
ps aux|grep -i $target|awk '{print $2}'|head -n $line|xargs kill -9
