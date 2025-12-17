BIN_NAME = hyprcap

BUILD_DIR    = bin
SOURCE_FILE  = hyprcap

VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")

all: build

.PHONY: all build

build: | $(BUILD_DIR)
	@sed "s/^readonly VERSION=.*/readonly VERSION=\"$(VERSION)\"/" $(SOURCE_FILE) \
		> $(BUILD_DIR)/$(BIN_NAME)
	@echo "Hyprcap version: $(VERSION)"
	chmod +x "$(BUILD_DIR)/$(BIN_NAME)"


$(BUILD_DIR):
	mkdir -p "$(BUILD_DIR)"
