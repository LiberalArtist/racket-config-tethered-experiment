.PHONY: all
all:
	$(MAKE) minimal
	$(MAKE) layer-a
	$(MAKE) layer-b
	$(MAKE) main-distribution

INIT_LAYER := bin/racket --config /tmp/config-tethered
LAYER_CONFIG := etc/racket -l- raco setup
RACO_PKG_INSTALL := raco pkg install -i --skip-installed --batch --static-link

.PHONY: layer-b
layer-b:
	./layer-a/$(INIT_LAYER)/layer-b/$(LAYER_CONFIG)
	./layer-b/bin/$(RACO_PKG_INSTALL) /tmp/config-tethered/program-b
	./layer-b/bin/program-a
	./layer-b/bin/program-b


.PHONY: layer-a
layer-a:
	./minimal/$(INIT_LAYER)/layer-a/$(LAYER_CONFIG)
	./layer-a/bin/$(RACO_PKG_INSTALL) /tmp/config-tethered/program-a
	./layer-a/bin/program-a


.PHONY: main-distribution
main-distribution:
	./minimal/$(INIT_LAYER)/main-distribution/$(LAYER_CONFIG)


.PHONY: minimal
XONX := $(if $(findstring Darwin,$(shell uname -v)),"--enable-xonx","")
minimal:
	make -C racket unix-style \
	  PKGS="base" \
	  PREFIX="/tmp/config-tethered/minimal" \
	  CONFIGURE_ARGS=$(XONX)
