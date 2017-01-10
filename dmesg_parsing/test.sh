#!/bin/bash

echo "dest(0)|wc -l : " `~/Scripts/dmesg_parsing/total_dmesg_parser_exp.sh |grep "dest(0)" |wc -l`
echo "dest(1)|wc -l : " `~/Scripts/dmesg_parsing/total_dmesg_parser_exp.sh |grep "dest(1)" |wc -l`
echo "dest(4)|wc -l : " `~/Scripts/dmesg_parsing/total_dmesg_parser_exp.sh |grep "dest(4)" |wc -l`
echo "dest(5)|wc -l  : " `~/Scripts/dmesg_parsing/total_dmesg_parser_exp.sh |grep "dest(5)" |wc -l`
~/Scripts/dmesg_parsing/total_dmesg_parser_exp.sh
