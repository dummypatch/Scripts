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
		count = 0
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
			if len(elems) == 9 or len(elems) == 10:		# sometimes, it can be 10
			# print index
				if sum == 0:
					temp1 = str(hop) + " hop path " + str(elems[-4]) 
				sum = sum + int(elems[-1])
				count += 1
			elif len(elems) == 0: # line break
				#temp2 = " " + str(sum)
				if count == 0 :
					temp2 = " " + str(float(sum)*4.0/0.1/1000000) + "\tMB/s"
					#temp2 = " " + str(int(sum))
				else :
					temp2 = " " + str(int((float(sum)/float(count))*4.0/0.1/1000000)) + "\tMB/s"
					#temp2 = " " + str(int(float(sum)/float(count)))
				array.append(temp1 + temp2)
				sum = 0
				count = 0
		if int(arg) == 1 :
			for line in array:
				print line

		dict_map = dict()	
		remote_accesses = 0
		local_accesses = 0
		for idx,line in enumerate(array):
			elems = line.split()
			if (str(elems[-6]) == '1') or (str(elems[-6]) == '2') :
				dest = str(elems[-3])
				if dest.split('->')[1] in dict_map.keys():
					dict_map[dest.split('->')[1]] += int(elems[-2])
				else:
					dict_map[dest.split('->')[1]] = int(elems[-2])
				remote_accesses += int(elems[-2])
			else :
				local_accesses += int(elems[-2])

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
					print line, '\t\t({0:.2f}% among all remotes traffic'.format(float(elems[-1]) / float(remote_accesses) *100), ')'
		
		max_key =  max(dict_map.iteritems(), key=operator.itemgetter(1))[0] 
		print 'most remotely accessed node : ', max_key , int(dict_map[max_key]) , ' ( {0:.2f}% among all remote accesses)'.format(dict_map_percentage[max_key]) 			

		sorted_dict_map = sorted(dict_map.items(), key=operator.itemgetter(1))
		sorted_dict_map.reverse()
		for key,value in  sorted_dict_map:
			print key , value, '\t( {0:.2f} % )'.format(dict_map_percentage[key])

if __name__ == "__main__":
	if len(sys.argv) == 2 :
		sum_up(sys.argv[1], 0 )
	elif len(sys.argv) == 3 :
		sum_up(sys.argv[1], sys.argv[2])
