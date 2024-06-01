CC = gcc
FC = gfortran
FCFLAGS = -Wall -Wextra -std=f2018 -pedantic -fcheck=all

OBJS = mod_dill.o libdill.a modhttp.o

.PHONY: all cleans
.SUFFIXES: .f90 .o

all: server

server: server.f90 $(OBJS)
	$(FC) $(FCFLAGS) $< -o $@ modhttp.o libdill.a -pthread
	# gfortran -Wall -Wextra -std=f2018 -pedantic -fcheck=all server.f90 -o server modhttp.o libdill.a -pthread

libdill:
	git clone https://github.com/sustrik/libdill

libdill.a: libdill
	cd libdill && ./autogen.sh && ./configure && $(MAKE) && cp .libs/libdill.a ..

.f90.o:
	$(FC) $(FCFLAGS) -c $<

%.o: %.mod

mod_dill.o: mod_dill.f90

modhttp.o: modhttp.f90

clean:
	$(RM) -rf server *.o *.mod
