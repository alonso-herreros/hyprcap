PKGBASE ?= hyprcap
PREFIX  ?= /usr/local
DESTDIR ?=
BIN_NAME = hyprcap

BUILD_DIR    = bin
SOURCE_FILE  = hyprcap
LICENSE_FILE = LICENSE

INSTALL_BIN_DIR     = $(DESTDIR)$(PREFIX)/bin
INSTALL_LICENSE_DIR = $(DESTDIR)$(PREFIX)/share/licenses/$(PKGBASE)

HYPRCAP_VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null)
HYPRCAP_VERSION ?= dev


all: build

.PHONY: all build clean \
	install install-bin install-docs \
	remove  remove-bin  remove-docs

build: | $(BUILD_DIR)
	@sed "s/^readonly VERSION=.*/readonly VERSION=\"$(HYPRCAP_VERSION)\"/" \
		$(SOURCE_FILE) \
		> $(BUILD_DIR)/$(BIN_NAME)
	@echo "Hyprcap version: $(HYPRCAP_VERSION)"
	chmod +x "$(BUILD_DIR)/$(BIN_NAME)"


install: install-bin install-docs

install-bin: build
	install -Dm755 "$(BUILD_DIR)/$(BIN_NAME)" -t "$(INSTALL_BIN_DIR)"

install-docs:
	install -Dm644 "$(LICENSE_FILE)" "$(INSTALL_LICENSE_DIR)/LICENSE"


remove: remove-bin remove-docs

remove-bin:
	rm -f "$(INSTALL_BIN_DIR)/$(BIN_NAME)"

remove-docs:
	rm -rf "$(INSTALL_LICENSE_DIR)"


$(BUILD_DIR):
	mkdir -p "$(BUILD_DIR)"

clean:
	rm -rf "$(BUILD_DIR)"
