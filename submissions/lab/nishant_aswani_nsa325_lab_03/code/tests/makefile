#  File: makefile
#  Name: Nishant Aswani
#  Instructor: Cristoforos Vasilatos
#  Assignment: Prelab 4
#  Course: Data Structures and Algorithms (ENGR-UH 3510) Fall 2019
#  Due: Sep 16 2019

PROG = mydesign
OUT = prelab4_output
CC = iverilog
SO = vvp

all: generate simulate wave

generate :
	@echo "Compiling object..."
	${CC} *.v -o $(PROG)

simulate :
	@echo "Simulating object..."
	$(SO) $(PROG)

wave:
	gtkwave *.vcd

clean:
	@echo "Cleaning up..."
	rm -f core $(PROG) $(OBJS) *.vcd
