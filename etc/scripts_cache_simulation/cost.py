#!/usr/bin/env python3

#######################################
#	policy options = "l", "r", "f"
#	l1_assoc options = 1,2,4,8
#	l2_assoc options = 1,2,4,8
# 	boolean for unified.
#######################################

policy = "l"
l1_assoc = 2
l2_assoc = 2
unified = True

cost = 0

base_assoc_cost = 5
base_policy_cost = 5


if (l1_assoc == 1):
	cost += base_assoc_cost
elif (l1_assoc == 2):
	cost += base_assoc_cost*1.06
elif (l1_assoc == 4):
	cost += base_assoc_cost*1.18
elif (l1_assoc == 8):
	cost += base_assoc_cost*1.42

if (l2_assoc == 1):
	cost += base_assoc_cost
elif (l2_assoc == 2):
	cost += base_assoc_cost*1.03
elif (l2_assoc == 4):
	cost += base_assoc_cost*1.09
elif (l2_assoc == 8):
	cost += base_assoc_cost*1.21

if (policy == "r"):
	cost += base_policy_cost
elif (policy == "f"):
	cost += base_policy_cost*1.04
elif (policy == "l"):
	cost += base_policy_cost*1.08

if (unified):
	cost += 2
else:
	cost += 4

print("cost: " + str(cost))
