.PHONY: all
all:
	$(MAKE) minimal


.PHONY: minimal
minimal:
	cd racket && $(MAKE) unix-style PREFIX=/tmp/config-tethered/minimal PKGS="base"
