#!/bin/bash

NODE_MAX=8

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


for(( ii=0; ii<${NODE_MAX};ii++))
do
	echo "NODE ${ii}"
	for(( jj=0; jj<${NODE_MAX}; jj++))
	do
		~/Scripts/setpci -s "${NODE_REG[${ii}]}.${FUNC_0}" ${ROUTING_REG[${jj}]}.L
	done
done
	

