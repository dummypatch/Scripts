# -*- coding: utf-8 -*-
""" sum_up.py """
import sys


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
			if len(elems) == 10:
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
# 1 hop
		max_val = 0
		max_idx = 0
		for idx,line in enumerate(array):
			elems = line.split()
			if (str(elems[-5]) == '1') and (max_val < int(elems[-1])):
				max_val = int(elems[-1])
				max_idx = idx
		print "1 hop max --> " + array[max_idx]
			
# 2 hop
		max_val = 0
		max_idx = 0
		for idx,line in enumerate(array):
			elems = line.split()
			if (str(elems[-5]) == '2') and (max_val < int(elems[-1])):
				max_val = int(elems[-1])
				max_idx = idx
		print "2 hop max --> " + array[max_idx]



if __name__ == "__main__":
	if len(sys.argv) == 2 :
		sum_up(sys.argv[1], 0 )
	elif len(sys.argv) == 3 :
		sum_up(sys.argv[1], sys.argv[2])
