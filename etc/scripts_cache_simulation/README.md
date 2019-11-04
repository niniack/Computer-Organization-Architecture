# Set-up for scripts
It is assumed that you have a benchmarks folder within the simplesim-3.0 folder.
1. Copy the tests folder into the benchmarks folder
2. Copy the four scripts (cpi.py, cpi.sh, cost.py, ratio.py) into the benchmarks folder. NOT into the tests folder!
3. Refer to workspace.png to see an example of how you can work with these scripts

# CPI calculations
1. Edit the cache flags to reflect the cache you want to simulate and save the file
2. Run cpi.sh from the terminal. This should take a bit of time. If it ends immediately, cache flags were messed up.
3. cpi.sh should produce cpi.txt (all of the output of the benchmark) and test1.txt (only certain lines of raw data)
3. From terminal, run cpi.py. It should be able to parse the relevant information and spit out a CPI for that cache.
4. ###### IMPORTANT: There are some settings in cpi.py that must be edited. l1_mp refers to the miss penalty of level 1 cache. l2_mp refers to miss penalty of level 2 cache. The base_cpi is also a variable. Depending on your assumptions, these will change. This cpi script is set up to only calculate a separated L1 and unified L2 situation.

# Cost calculations
1. Make sure to edit the costs based on the associativity levels and policy. These are all assumptions and are individualized.

# Ratio (cost/performance) calculations
1. It simply automates some multiplication and division...nothing fancy. Basic idea comes from the cost/performance calculations we did in one of our homeworks.
