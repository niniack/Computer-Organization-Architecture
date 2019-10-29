**PLEASE BUILD THE FILE**

Notes:
--  the code_stalling and code_forwarding folders hold all .v files, including the top-level-tb.v
--  the report folder holds the pdf of the report


Build Instructions:
1. Change to the directory with the code

2. Run the following command:
--  make

3. Run:
-- gtkwave *.vcd

This should open gtkwave with all the signals ready to be imported

Alternatively, you may view the top-level-wave.gtkw file to see the signals from the report.

4. Run the following command for clean-up:
-- make clean
