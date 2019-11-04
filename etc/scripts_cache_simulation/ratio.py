#!/usr/bin/env python3


## these are the values you are comparing
cost = 1.0777
cpi = 18.75

## these are your benchmark values
## for example, you may set your benchmark value
## to be the results of your cheapest set up
base_cpi = 1.1811
base_cost = 17

perf = (cost*cpi)/(base_cpi*base_cost)

print("ratio: " + str(perf))
