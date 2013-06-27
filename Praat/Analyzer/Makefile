CC = g++
CFLAGS = -g -Wall
PROG = analyzer
SRCS = analyzer.cpp
OBJS = $(SRCS:.c=.o)

all: $(PROG)

$(PROG): $(SRCS)
	$(CC) $(CFLAGS) -o $(PROG) $(SRCS)

clean:
	rm *~ $(PROG)