#!/bin/bash

#/****************************************************************************
# 아래껀 seconds 로 알려줘서,, 나한텐 ns 로 알려주는게 필요.
#****************************************************************************/ 
#if [ $# -eq 1 ]  && [ -f $1 ]; then
#	FORMAT="%a %b %d %H:%M:%S %Y"
#
#	now=$(date +%s)
#	cputime_line=$(grep -m1 "\.clock" /proc/sched_debug)
#
#	if [[ $cputime_line =~ [^0-9]*([0-9]*).* ]]; then
#		cputime=$((BASH_REMATCH[1] / 1000))
#	fi
#
#	cat $1 | while IFS= read -r line; do
#		if [[ $line =~ ^\[\ *([0-9]+)\.[0-9]+\]\ (.*) ]]; then
#			stamp=$((now-cputime+BASH_REMATCH[1]))
#			echo "[$(date +"${FORMAT}" --date=@${stamp})] ${BASH_REMATCH[2]}"
#		else
#			echo "$line"
#		fi
#	done
#fi


# Define date format (similar to syslog)
date_format="%b %d %T %Y"

# Get the uptime in seconds from /proc/uptime
uptime=$(cut -d " " -f 1 /proc/uptime)

# Read dmesg and convert date with date_format defined above
#dmesg | sed "s/^\[[ ]*\?\([0-9.]*\)\] \(.*\)/\\1 \\2/" | while read timestamp message; do
#	printf "[%s] %s\n" "$(date --rfc-3339=ns --date "now - $uptime seconds + $timestamp seconds" +"${date_format}")" "$message"
#done

function human_dmesg {
	if [ $# -eq 1 ] && [ -f $1 ]; then
		cat $1 | sed "s/^\[[ ]*\?\([0-9.]*\)\] \(.*\)/\\1 \\2/" | while read timestamp message; do
			#python -c "print ( \"$uptime - $timestamp \" + \"$message\")"
			timestamp_temp=
			timestamp_temp=`printf "%s" "$(date --rfc-3339=ns --date "now - $uptime seconds + $timestamp seconds "  )"|awk -F" " '{print $2}'|awk -F"+" '{print $1}'`
			printf "%s %s\n" "$timestamp_temp" "$message"

			#printf "%s %s\n" "$(date --rfc-3339=ns --date "now - $uptime seconds + $timestamp seconds "  )"  "$message"
		done
	else
		echo "USAGE : $0 dmesg_log.txt"
	fi
}

TEMP_FILE="qwernjkabsdfhuhjqwerhj.txt"
if [ $# -eq 1 ] && [ -f $1 ];then
	FILENAME=$1
	human_dmesg $FILENAME | grep "TIME_PERF " 
	#NR_OPS_START=`human_dmesg $FILENAME | grep "TIME_PERF oprofile)ops() start"`
	#human_dmesg $FILENAME | grep "TIME_PERF oprofile)ops() start"|awk -F" " '{print $1}'|awk -F":" '{print $3}'
	#tempstamp_acc=0
	#human_dmesg $FILENAME | grep "TIME_PERF " > tee ${TEMP_FILE}
	#human_dmesg $FILENAME | grep "TIME_PERF oprofile)ops() start"|awk -F" " '{print $1}'|awk -F":" '{print $3}'|while read timestamp_start ;do
	#NR_OPS_END=`cat ${TEMP_FILE} |grep "TIME_PERF oprofile)ops() end"|wc -l`
	#for((ii=0;ii<${NR_OPS_END};ii++))
	#do
	#	TIMESTAMP_START=`cat ${TEMP_FILE}|grep "TIME_PERF oprofile)ops() start"|awk -F" " '{print $1}'|awk -F":" 'NR=='${ii}'{print $3}'`
	#	TIMESTAMP_END=`cat ${TEMP_FILE}|grep "TIME_PERF oprofile)ops() end"|awk -F" " '{print $1}'|awk -F":" 'NR=='${ii}'{print $3}'`
	#	python -c "print (${TIMESTAMP_END} - ${TIMESTAMP_START})"
	#done

	#	human_dmesg $FILENAME | grep "TIME_PERF oprofile)ops() end"|awk -F" " '{print $1}'|awk -F":" '{print $3}'|while read timestamp_end ;do
	#		timestamp_diff=`python -c "print(${timestamp_end} - ${timestamp_start})"`
	#		printf "%s\n" "${timestamp_diff}"
	#	done
else
	echo "USAGE : $0 dmesg_log.txt"
fi

