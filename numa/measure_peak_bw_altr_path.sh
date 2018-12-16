#!/bin/bash


RTCTL=/home/hans7taiji/Scripts/rtctl.sh
if [ ! -f ${RT_CTL} ];then
	echo "${RT_CTL} not exit"
	exit;
fi

BW_MONITOR=/home/hans7taiji/BW_201017/qwer_stream_peak_ld
LOG=/home/${USER}/Results/BW_180726/2hop_altr_bw/
if [ ! -f ${BW_MONITOR} ]; then
	echo "${BW_MONITOR} not exist"
	exit;
fi
if [ ! -d ${LOG} ];then
	mkdir -p ${LOG}
fi

CHECK_RT=/home/hans7taiji/Scripts/check_routing_table.sh
if [ ! -f ${CHECK_RT} ];then
	echo "${CHECK_RT} not exist"
	exit;
fi;
RT_STATUS=`${CHECK_RT}|awk -F":" '{print $2}'`
if [ "${RT_STATUS}" == "1" ];then
	echo "Corrupted routing table!"
	exit;
fi

function restore_rt {
	TARGET_NODE=$1
	${RTCTL} ${TARGET_NODE} r
	RT_STATUS=`${CHECK_RT}|awk -F":" '{print $2}'`
	if [ "${RT_STATUS}" == "1" ];then
		echo "routing table did not restored"
		exit;
	fi
}

cp $0 ${LOG}/


#/****************************************************************************
#	NODE 0
#****************************************************************************/ 

#0->1->3
SRC=0
MID=1
DEST=3
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

exit;

#0->4->3
SRC=0
MID=4
DEST=3
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#0->2->5
SRC=0
MID=2
DEST=5
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#/****************************************************************************
#	NODE 1
#****************************************************************************/ 
#1->0->2
SRC=1
MID=0
DEST=2
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#1->4->2
SRC=1
MID=4
DEST=2
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}



#1->7->2
SRC=1
MID=7
DEST=2
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#1->3->5
SRC=1
MID=3
DEST=5
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#1->7->5
SRC=1
MID=7
DEST=5
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#/****************************************************************************
#	NODE 2
#****************************************************************************/ 
#2->3->1
SRC=2
MID=3
DEST=1
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}



#2->4->1
SRC=2
MID=4
DEST=1
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}



#2->4->1
SRC=2
MID=4
DEST=1
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#2->7->1
SRC=2
MID=7
DEST=1
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#/****************************************************************************
#	NODE 3
#****************************************************************************/ 
#3->2->0
SRC=3
MID=2
DEST=0
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#3->4->0
SRC=3
MID=4
DEST=0
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#3->1->7
SRC=3
MID=1
DEST=7
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#3->5->7
SRC=3
MID=5
DEST=7
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#3->4->6
SRC=3
MID=4
DEST=6
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#/****************************************************************************
#	NODE 4
#****************************************************************************/ 
#4->1->7
SRC=4
MID=1
DEST=7
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#4->2->7
SRC=4
MID=2
DEST=7
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#4->5->7
SRC=4
MID=5
DEST=7
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}



#/****************************************************************************
#	NODE 5
#****************************************************************************/ 
#5->2->0
SRC=5
MID=2
DEST=0
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}



#5->3->1
SRC=5
MID=3
DEST=1
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#5->7->1
SRC=5
MID=7
DEST=1
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#5->2->6
SRC=5
MID=2
DEST=6
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}



#5->4->6
SRC=5
MID=4
DEST=6
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#/****************************************************************************
#	NODE 6
#****************************************************************************/ 
#6->4->3
SRC=6
MID=4
DEST=3
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#6->2->5
SRC=6
MID=2
DEST=5
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


#6->7->5
SRC=6
MID=7
DEST=5
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}



#/****************************************************************************
#	NODE 7
#****************************************************************************/ 
#7->1->3
SRC=7
MID=1
DEST=3
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#7->5->3
SRC=7
MID=5
DEST=3
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#7->1->4
SRC=7
MID=1
DEST=4
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#7->2->4
SRC=7
MID=2
DEST=4
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}

#7->6->4
SRC=7
MID=6
DEST=4
TARGET_NODE=${SRC}
TARGET_ENTRY=${DEST}
REF_NODE=${SRC}
REF_ENTRY=${MID}
${RTCTL} ${TARGET_NODE} ${TARGET_ENTRY} ${REF_NODE} ${REF_ENTRY}
for ((ii=0;ii<20;ii++))
do
	free && sync  && sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches' && free
	numactl --cpunodebind=${DEST} --membind=${SRC} ${BW_MONITOR}  100 4 >>  ${LOG}/${SRC}_${MID}_${DEST}_${ii}_trials.log
done
restore_rt ${SRC}


