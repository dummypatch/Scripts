#!/bin/bash

function backup_sources {
	DIR_ARG=$1
	TARGET_DIR=$2
	echo $DIR_ARG
	echo $TARGET_DIR
	SRC_DIR="/home/rootfriend/${DIR_ARG}"
	ls ${SRC_DIR}

	if [ ! -d ${SRC_DIR} ];then
		echo "${SRC_DIR} not exist"
		exit;
	fi;

	if [ ! -d ${TARGET_DIR} ];then
		echo "${TARGET_DIR} not exist"
		exit;
	fi;
	cp ${SRC_DIR}/clustering.c  ${TARGET_DIR}
	cp ${SRC_DIR}/my_config.h	${TARGET_DIR}
	cp ${SRC_DIR}/cluster_config.h	${TARGET_DIR}
	cp ${SRC_DIR}/Makefile 	${TARGET_DIR}

}
