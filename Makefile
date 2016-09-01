GXX=g++-5 -std=c++11
OPTM=-O3 -msse2 -msse4 -fopenmp
CPFLAGS=$(OPTM) -Wall
LDFLAGS=$(OPTM) -Wall

INCLUDES=-I./ -I./algorithm -I./general

SAMPLES=$(patsubst %.cc, %, $(wildcard samples/*.cc))
SAMPLE_OBJS=$(foreach sample, $(SAMPLES), $(sample).o)

HEADERS=$(wildcard ./*.hpp ./*/*.hpp)

#EFNN is currently header only, so only samples will be compiled

#SHARED_LIB=libefnn.so
#OBJS=src/efnn.o

all: $(SHARED_LIB) $(SAMPLES)

#$(SHARED_LIB): $(OBJS)
#	$(GXX) $(LDFLAGS) $(LIBS) $(OBJS) -shared -o $(SHARED_LIB)

$(SAMPLES): %: %.o
	$(GXX) $(LDFLAGS) $(LIBS) $^ -o $@

%.o: %.cpp $(HEADERS)
	$(GXX) $(CPFLAGS) $(INCLUDES) -c $*.cpp -o $@

%.o: %.cc $(HEADERS)
	$(GXX) $(CPFLAGS) $(INCLUDES) -c $*.cc -o $@

clean:
	rm -rf $(OBJS)
	rm -rf $(SHARED_LIB)
	rm -rf $(SAMPLES)
	rm -rf $(SAMPLE_OBJS)
