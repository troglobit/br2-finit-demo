# Wrapper makefile to check for a .config and verify submodules
# This BR2_EXTERNAL extends Buildroot with the Finit init system
# Buildroot still handles everything about the build itself.

export BR2_EXTERNAL := $(CURDIR)/br2-ext-finit:$(CURDIR)

ARCH   ?= $(shell uname -m)
O      ?= $(CURDIR)/output

config := $(O)/.config
bmake   = $(MAKE) -C buildroot O=$(O) $1

.PHONY: all
all: $(config) buildroot/Makefile
	@+$(call bmake,$@)

$(config):
	@+$(call bmake,list-defconfigs)
	@echo "ERROR: No configuration selected."
	@echo "Please choose a configuration from the list above by running"
	@echo "'make <board>_defconfig' before building an image."
	@exit 1

%: buildroot/Makefile
	@+$(call bmake,$@)

buildroot/Makefile:
	@git submodule update --init --recursive
