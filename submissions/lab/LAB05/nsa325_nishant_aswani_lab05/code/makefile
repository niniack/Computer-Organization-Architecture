#  File: makefile
#  Name: Nishant Aswani
#  Instructor: Cristoforos Vasilatos
#  Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
#  Due: Oct 02 2019

PROG = mydesign
CC = iverilog
SO = vvp

all: generate simulate

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
