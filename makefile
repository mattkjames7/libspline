

ifndef BUILDDIR 
	export BUILDDIR=$(shell pwd)/build
endif

ifeq ($(OS),Windows_NT)
#windows stuff here
	MD=mkdir
else
#linux and mac here
	OS=$(shell uname -s)
	MD=mkdir -p
endif

ifeq ($(PREFIX),)
#install path
	PREFIX=/usr/local
endif


.PHONY: all lib obj clean header test install uninstall

all: obj lib

windows: winobj winlib

obj:
	$(MD) $(BUILDDIR)
	cd src; make obj

lib:
	$(MD) lib/libspline
	cd src; make lib

winobj:
	$(MD) $(BUILDDIR)
	cd src; make winobj

winlib: 
	$(MD) lib/libspline
	cd src; make winlib

header:
ifneq (,$(shell which python3))
	python3 generateheader.py
else
	@echo "python3 command doesn't appear to exist - skipping header regeneration..."
endif

clean:
	cd test; make clean
	-rm -v lib/libspline/libspline.so
	-rm -v lib/libspline/libspline.dll
	-rmdir -v lib/libspline
	-rm -v build/*.o
	-rmdir -v build

install:
	cp -v include/spline.h $(PREFIX)/include
	cp -v include/splinec.h $(PREFIX)/include

ifeq ($(OS),Linux)
	cp -v lib/libspline/libspline.so $(PREFIX)/lib
	chmod 0775 $(PREFIX)/lib/libspline.so
	ldconfig
else
	cp -v lib/libspline/libspline.dylib $(PREFIX)/lib
	chmod 0775 $(PREFIX)/lib/libspline.dylib
endif


uninstall:
	rm -v $(PREFIX)/include/spline.h
	rm -v $(PREFIX)/include/splinec.h
ifeq ($(OS),Linux)
	rm -v $(PREFIX)/lib/libspline.so
	ldconfig
else
	rm -v $(PREFIX)/lib/libspline.dylib
endif

test:
	cd test; make all