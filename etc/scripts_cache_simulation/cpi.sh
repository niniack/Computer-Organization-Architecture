# Test 1 
sim-cache  \
-cache:il1 il1:1024:64:2:l \
-cache:dl1 dl1:1024:64:2:l \
-cache:dl2 ul2:2048:64:8:l  \
cc1.alpha -O 1stmt.i  >& ./tests/cpi.txt 

grep "ul2.miss_rate" ./tests/cpi.txt >  ./tests/test1.txt
grep "il1.miss_rate" ./tests/cpi.txt >> ./tests/test1.txt
grep "dl1.miss_rate" ./tests/cpi.txt >> ./tests/test1.txt
grep "sim_num_insn"  ./tests/cpi.txt >> ./tests/test1.txt
grep "sim_num_refs"  ./tests/cpi.txt >> ./tests/test1.txt




# Test 2