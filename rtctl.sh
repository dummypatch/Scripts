#!/bin/bash
#/usr/bin/python

NR_NODE=8
NR_SRC_NODE=${NR_NODE}
NR_DEST_NODE=${NR_NODE}

# idx for node ID
NODE_REG=(
	"00:18"
	"00:19"
	"00:1A"
	"00:1B"
	"00:1C"
	"00:1D"
	"00:1E"
	"00:1F"
)

# idx for destination node ID 
ROUTING_REG=(	 
	"0x40"
	"0x44"
	"0x48"
	"0x4C"
	"0x50"
	"0x54"
	"0x58"
	"0x5C"
)

FUNC_0="0"
FUNC_1="1"
FUNC_2="2"
FUNC_3="3"
FUNC_4="4"
FUNC_5="5"
ORIGINAL_ROUTING_TABLE_NODE_0=(
	"201"
	"1008"
	"402"
	"402"
	"2010"
	"2010"
	"20100"
	"20100"
)
ORIGINAL_ROUTING_TABLE_NODE_1=(
	"804"
	"201"
	"2010"
	"2010"
	"4020"
	"4020"
	"402"
	"402"
)
ORIGINAL_ROUTING_TABLE_NODE_2=(
	"804"
	"804"
	"201"
	"1008"
	"2010"
	"402"
	"8040"
	"20100"
)

ORIGINAL_ROUTING_TABLE_NODE_3=(
	"402"
	"402"
	"804"
	"201"
	"4020"
	"2010"
	"804"
	"804"
)
ORIGINAL_ROUTING_TABLE_NODE_4=(
	"804"
	"20100"
	"2010"
	"8040"
	"201"
	"1008"
	"402"
	"402"
)
ORIGINAL_ROUTING_TABLE_NODE_5=(
	"804"
	"804"
	"2010"
	"4020"
	"804"
	"201"
	"402"
	"402"
)
ORIGINAL_ROUTING_TABLE_NODE_6=(
	"402"
	"402"
	"20100"
	"20100"
	"2010"
	"2010"
	"201"
	"1008"
)
ORIGINAL_ROUTING_TABLE_NODE_7=(
	"402"
	"402"
	"2010"
	"2010"
	"4020"
	"4020"
	"804"
	"201"
)

declare -A ROUTING_TABLE

for (( jj=0;jj<${NR_DEST_NODE};jj++))
do
	ROUTING_TABLE[0,${jj}]=${ORIGINAL_ROUTING_TABLE_NODE_0[${jj}]}
	ROUTING_TABLE[1,${jj}]=${ORIGINAL_ROUTING_TABLE_NODE_1[${jj}]}
	ROUTING_TABLE[2,${jj}]=${ORIGINAL_ROUTING_TABLE_NODE_2[${jj}]}
	ROUTING_TABLE[3,${jj}]=${ORIGINAL_ROUTING_TABLE_NODE_3[${jj}]}
	ROUTING_TABLE[4,${jj}]=${ORIGINAL_ROUTING_TABLE_NODE_4[${jj}]}
	ROUTING_TABLE[5,${jj}]=${ORIGINAL_ROUTING_TABLE_NODE_5[${jj}]}
	ROUTING_TABLE[6,${jj}]=${ORIGINAL_ROUTING_TABLE_NODE_6[${jj}]}
	ROUTING_TABLE[7,${jj}]=${ORIGINAL_ROUTING_TABLE_NODE_7[${jj}]}
done


echo $@ $# $1
if [ $# -eq 1 ] && [ $1 -ge 0 ] && [ $1 -le 7 ]; then
	CUR_NODE_ID=${1}
	#/****************************************************************************
	# Read "Original" Routing Table
	#****************************************************************************/
	echo "CUR_NODE : ${CUR_NODE_ID}"
	echo "Original Routing Table"
	for (( ii=0;ii<${NR_DEST_NODE};ii++))
	do
		echo -en "\tDest to Node ${ii} :\t${ROUTING_TABLE[${CUR_NODE_ID},${ii}]}\n"
	done
	#/****************************************************************************
	# Read "Current" Routing Table
	#****************************************************************************/
	echo "CurrentRouting Table"
	for (( ii=0;ii<${NR_DEST_NODE};ii++))
	do
		VAL=`~/Scripts/setpci -s "${NODE_REG[${CUR_NODE_ID}]}.${FUNC_0}" ${ROUTING_REG[${ii}]}.L`
		LOW_VAL=`python -c "print hex(int('${VAL}',16) & int('3FFFF',16))[2:]"`
		echo -en "\tDest to Node ${ii} :\t${LOW_VAL}\t${VAL}\n"
	done

elif [ $# -eq 2 ] && [ $1 -ge 0 ] && [ $1 -le 7 ] && [ "${2}" == "r" ]; then
	CUR_NODE_ID=${1}
	echo "CUR_NODE : ${CUR_NODE_ID}"
	echo "Current Routing Table"
	#/****************************************************************************
	# Restore to original routing table
	#****************************************************************************/
	for ((ii=0;ii<${NR_DEST_NODE};ii++))
	do
		VAL=`~/Scripts/setpci -s "${NODE_REG[${CUR_NODE_ID}]}.${FUNC_0}" ${ROUTING_REG[${ii}]}.L`
		HIGH_VAL=`python -c "print hex(int('${VAL}',16) & ~int('3FFFF',16))[2:]"`
		MODI_VAL=`python -c "print  hex(int('${HIGH_VAL}',16) | int('${ROUTING_TABLE[${CUR_NODE_ID},${ii}]}',16))"`
		~/Scripts/setpci -s "${NODE_REG[${CUR_NODE_ID}]}.${FUNC_0}" ${ROUTING_REG[${ii}]}.L=${MODI_VAL}
	done
#else [ $# -eq 0 ]; then
elif [ $# -eq 4 ] && [ $1 -ge 0 ] && [ $1 -le 7 ] && [ $2 -ge 0 ] && [ $2 -le 7 ] &&  [ $3 -ge 0 ] && [ $3 -le 7 ] && [ $4 -ge 0 ] && [ $4 -le 7 ] ;then
	TARGET_NODE=$1
	TARGET_ENTRY=$2
	REF_NODE=$3
	REF_ENTRY=$4
	VAL=`~/Scripts/setpci -s "${NODE_REG[${TARGET_NODE}]}.${FUNC_0}" ${ROUTING_REG[${TARGET_ENTRY}]}.L`
	HIGH_VAL=`python -c "print hex(int('${VAL}',16) & ~int('3FFFF',16))[2:]"`
	MODI_VAL=`python -c "print  hex(int('${HIGH_VAL}',16) | int('${ROUTING_TABLE[${REF_NODE},${REF_ENTRY}]}',16))"`
	~/Scripts/setpci -s "${NODE_REG[${TARGET_NODE}]}.${FUNC_0}" ${ROUTING_REG[${TARGET_ENTRY}]}.L=${MODI_VAL}

else 
	echo "Show Original : USAGE : $0 CUR_NODE"
	echo "Restore : USAGE : $0 CUR_NODE r"
fi
exit



#/****************************************************************************
# Read Current RT
#****************************************************************************/
		
echo "Current Routing Table"
for (( ii=0;ii<${NR_DEST_NODE};ii++))
do
	VAL=`~/Scripts/setpci -s "${NODE_REG[${CUR_NODE_ID}]}.${FUNC_0}" ${ROUTING_REG[${ii}]}.L`
	LOW_VAL=`python -c "print hex(int('${VAL}',16) & int('3FFFF',16))"`
	HIGH_VAL=`python -c "print hex(int('${VAL}',16) & ~int('3FFFF',16))"`
	#echo -en "\tDest to Node ${ii} :\t$VAL\t$HIGH_VAL\t\t$LOW_VAL\t\t"		# All(Raw) + High + Low
	echo -en "\tDest to Node ${ii} :\t${LOW_VAL:2}\t\t"		# only Low
	echo -e "print \"0b\"+bin("0x${VAL}")[2:].zfill(32)"|python
done
echo -e "\n\n"
exit;

for (( ii=0;ii<${NR_DEST_NODE};ii++))
do
	VAL=`~/Scripts/setpci -s "${NODE_REG[${CUR_NODE_ID}]}.${FUNC_0}" ${ROUTING_REG[${ii}]}.L`
	LOW_VAL=`python -c "print hex(int('${VAL}',16) & int('3FFFF',16))"`
	HIGH_VAL=`python -c "print hex(int('${VAL}',16) & ~int('3FFFF',16))"`
	echo -en "Node ${ii} $VAL\t$HIGH_VAL\t\t$LOW_VAL\t\t"
	echo -e "print \"0b\"+bin("0x${VAL}")[2:].zfill(32)"|python
done
echo -e "\n\n"
exit;
#~/Scripts/setpci -s "${NODE_REG[2]}.${FUNC_0}" ${ROUTING_REG[1]}.L=00040804
##~/Scripts/setpci -s "${NODE_REG[1]}.${FUNC_0}" ${ROUTING_REG[6]}.L=00044020
##~/Scripts/setpci -s "${NODE_REG[1]}.${FUNC_0}" ${ROUTING_REG[6]}.L=00040402
#~/Scripts/setpci -s "${NODE_REG[2]}.${FUNC_0}" ${ROUTING_REG[1]}.L=05041008
for (( ii=0;ii<${NR_DEST_NODE};ii++))
do
	~/Scripts/setpci -s "${NODE_REG[0]}.${FUNC_0}" ${ROUTING_REG[${ii}]}.L=${ORIGINAL_ROUTING_TABLE_NODE_0[${ii}]}
	VAL=`~/Scripts/setpci -s "${NODE_REG[0]}.${FUNC_0}" ${ROUTING_REG[${ii}]}.L`
	echo -en "Node ${ii} $VAL\t"
	echo -e "print \"0b\"+bin("0x${VAL}")[2:].zfill(32)"|python
done

