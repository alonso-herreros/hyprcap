BIN_NAME  = hyprcap

VERSION   := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")

all: build

.PHONY: all build

build:
	@sed -i "s/^readonly VERSION=.*/readonly VERSION=\"$(VERSION)\"/" $(BIN_NAME)
	@echo "VERSION=$(VERSION)"
