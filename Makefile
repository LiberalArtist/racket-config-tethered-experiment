.PHONY: all
all:
	$(MAKE) minimal


.PHONY: minimal
MINIMAL := /tmp/config-tethered/minimal
XONX := $(if $(findstring Darwin,$(shell uname -v)),--enable-xonx)
minimal: | build
	cd build && ../racket/racket/src/configure --prefix $(MINIMAL) $(XONX)
	cd build && $(MAKE)
	cd build && $(MAKE) install

build:
	mkdir build
