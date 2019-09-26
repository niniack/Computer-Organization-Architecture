**PLEASE BUILD THE FILE**

Notes:
--  the code folder holds all .v files, including the top-level-tb
--  the report folder holds the pdf of the report


Build Instructions:
1. Change to the directory with the testbenches (./code/tests)

2. Run the following command:
--  make

3. Run: 
-- gtkwave *.vcd

This should open gtkwave with all the signals ready to be imported

4. Run the following command for clean-up:
-- make clean
