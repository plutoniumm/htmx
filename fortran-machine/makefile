FLIBS=flibs-0.9/flibs/src
FORTRAN=gfortran
FORTRANFLAGS=-ldl -L/opt/homebrew/Cellar/fcgi/2.4.2/lib -lfcgi -pthread -Wl,-rpath -Wl,/usr/lib

OBJECTS = \
	jade.o \
	string_helpers.o \
	cgi_protocol.o \
	fcgi_protocol.o \

fortran_fcgi: fortran_fcgi.f90 $(OBJECTS)
	$(FORTRAN) -o $@ $^ $(FORTRANFLAGS)

jade.o: jade.f90 string_helpers.o
	$(FORTRAN) -c $<

string_helpers.o: string_helpers.f90
	$(FORTRAN) -c $<

cgi_protocol.o: $(FLIBS)/cgi/cgi_protocol.f90
	$(FORTRAN) -c $<

fcgi_protocol.o: $(FLIBS)/cgi/fcgi_protocol.f90
	$(FORTRAN) -c $<

clean:
	pkill -f fortran_fcgi
	rm -f -v fortran_fcgi *.o *.mod

.PHONY: clean
