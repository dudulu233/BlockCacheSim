obj-m = cache-sim.o

all:
	g++ -w cache-sim.cpp -o cache-sim.o -std=c++0x
run:
	./cache-sim.o config
st:
	./cache-sim.o config 100
clean:
	rm cache-sim.o
