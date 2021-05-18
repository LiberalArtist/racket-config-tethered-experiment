.PHONY: all
all:
	$(MAKE) minimal
	$(MAKE) layer-a

INIT_LAYER := bin/racket --config /tmp/config-tethered
RACO_PKG_INSTALL := raco pkg install -i --skip-installed --batch --static-link

.PHONY: layer-a
layer-a:
	./minimal/$(INIT_LAYER)/layer-a/etc/racket -l- raco setup
	./layer-a/bin/$(RACO_PKG_INSTALL) /tmp/config-tethered/program-a
	./layer-a/bin/program-a


.PHONY: minimal
MINIMAL := /tmp/config-tethered/minimal
XONX := $(if $(findstring Darwin,$(shell uname -v)),--enable-xonx)
minimal: | build
	cd build && ../racket/racket/src/configure --prefix $(MINIMAL) $(XONX)
	cd build && $(MAKE)
	cd build && $(MAKE) install
	./minimal/bin/raco pkg install base

build:
	mkdir build
