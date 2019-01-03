# -*- coding: utf-8 -*-
""" sum_up.py """
import sys
import operator
import copy


"""
sums up data for all indices
"""
def sum_up(filepath,arg):
	with open(filepath) as f:
		sum = 0
		hop = 0
		array = []
		for line in f:
			# split up each line into a list
			elems = line.split()
			if len(elems) == 3:
				if int(elems[-3]) == 1:
					hop = 1
				elif int(elems[-3]) == 2:
					hop = 2
			elif len(elems) == 2:
				if elems[-2] == "LOCAL":
					hop = "LOCAL"
			# valid data line => 10 elements
			# break point => 0 elements
			# headers => no pattern
			#temp1 = ""
			if len(elems) == 10 or len(elems) == 11 :		# sometimes the length is 11 
			# print index
				if sum == 0:
					temp1 = str(hop) + " hop path " + str(elems[-5])
				sum = sum + int(elems[-1])
			elif len(elems) == 0: # line break
				temp2 = " " + str(sum)
				array.append(temp1 + temp2)
				sum = 0
		if int(arg) == 1 :
			for line in array:
				print line

		dict_map = dict()	
		remote_accesses = 0
		local_accesses = 0
		twohop_remote_accesses = 0
		# /****************************************************************************
		#  ['LOCAL', 'hop', 'path', 'src(0)->dest(0)', '1605152046']
		#	-5		 -4		  -3			-2				-1
		#****************************************************************************/ 
		for idx,line in enumerate(array):
			elems = line.split()
			if (str(elems[-5]) == '1') or (str(elems[-5]) == '2') :
				dest = str(elems[-2])
				if dest.split('->')[1] in dict_map.keys():
					#/****************************************************************************
					# [0]  의 경우 src node 로 카운트값을 매핑하는것이고
					# [1] 의 경우는 dest node 로 카운트 값을 매핑하는것
					# monitor_dram_cbw_v2.c  에서 cpu_dram_req[src][dest] 를 cpu_dram_req[dest][src]
					# 으로 바꾸었기때문에 [0] 을 사용하게되었다.  src node 에서 다른 노드로
					# 전달되는 트래픽의 양을 추측하기위한 방법 2018.12.29 17:12:49 
					#****************************************************************************/ 
					dict_map[dest.split('->')[0]] += int(elems[-1])		#2018.12.29 17:10:21 
					#dict_map[dest.split('->')[1]] += int(elems[-1])	2018.12.29 17:10:14 
				else:
					dict_map[dest.split('->')[0]] = int(elems[-1])		# 2018.12.29 17:10:43 
					#dict_map[dest.split('->')[1]] = int(elems[-1])		2018.12.29 17:10:29 
				remote_accesses += int(elems[-1])
				if str(elems[-5]) == '2' :
					twohop_remote_accesses +=  int(elems[-1])
			else :
				local_accesses += int(elems[-1])

#		for key, value in dict_map.items() :
#			print (key, value)
		dict_map_percentage = dict()
		dict_map_percentage = copy.deepcopy(dict_map)
		total_acc = 0
		for v in dict_map.values():
			total_acc += v
		for k in dict_map.keys():
			dict_map_percentage[k] = float(dict_map[k]) / float(total_acc) * float(100)

		if int(arg) == 1 :
			for line in array:
				elems = line.split()
				if str(elems[-5]) == '2' :
					print line, '\t\t({0:.2f}% among all remotes traffic'.format(float(elems[-1]) / float(remote_accesses) *100), ', {0:.2f}% among all 2hop traffic'.format(float(elems[-1]) / float(twohop_remote_accesses)*100),')'
		
		max_key =  max(dict_map.iteritems(), key=operator.itemgetter(1))[0] 
		local_accesses_ratio = float(local_accesses) / float(local_accesses + remote_accesses) * 100
		remote_accesses_ratio = float(remote_accesses) / float(local_accesses + remote_accesses) * 100
		print 'most remotely accessed node : ', max_key , int(dict_map[max_key]) , ' ( {0:.2f}% among all remote accesses)'.format(dict_map_percentage[max_key]), ' (total local accesses ratio : {0:.2f}%'.format(local_accesses_ratio), ', total remote accesses ratio : {0:.2f}%)'.format(remote_accesses_ratio)

			

if __name__ == "__main__":
	if len(sys.argv) == 2 :
		sum_up(sys.argv[1], 0 )		
	elif len(sys.argv) == 3 :
		sum_up(sys.argv[1], sys.argv[2])
