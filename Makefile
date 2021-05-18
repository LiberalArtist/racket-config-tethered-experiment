.PHONY: all
all:
	$(MAKE) minimal
	$(MAKE) layer-a
	$(MAKE) layer-b

INIT_LAYER := bin/racket --config /tmp/config-tethered
RACO_PKG_INSTALL := raco pkg install -i --skip-installed --batch --static-link

.PHONY: layer-b
layer-b:
	./layer-a/$(INIT_LAYER)/layer-b/etc/racket -l- raco setup
	./layer-b/bin/$(RACO_PKG_INSTALL) /tmp/config-tethered/program-b
	./layer-b/bin/program-a
	./layer-b/bin/program-b


.PHONY: layer-a
layer-a:
	./minimal/$(INIT_LAYER)/layer-a/etc/racket -l- raco setup
	./layer-a/bin/$(RACO_PKG_INSTALL) /tmp/config-tethered/program-a
	./layer-a/bin/program-a


.PHONY: minimal
XONX := $(if $(findstring Darwin,$(shell uname -v)),"--enable-xonx","")
minimal:
	make -C racket unix-style \
	  PKGS="base" \
	  PREFIX="/tmp/config-tethered/minimal" \
	  CONFIGURE_ARGS=$(XONX)
