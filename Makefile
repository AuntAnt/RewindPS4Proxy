# Makefile for building macOS XCFramework using gomobile

# Default framework name
FRAMEWORK ?= ProxyServer

GO_DIR := go_sources
OUTPUT_DIR := Binary

# Target macOS version
MACOSX_DEPLOYMENT_TARGET = 13.0

# Output directory
OUTPUT = $(OUTPUT_DIR)/$(FRAMEWORK).xcframework
.ONESHELL:

.PHONY: all init build clean

# Default target
all: build

# Initialize gomobile
init:
	@echo "Installing gomobile..."
	go install golang.org/x/mobile/cmd/gomobile@latest
	export PATH=$$PATH:~./go/bin && \
	gomobile init
	@cd Sources/$(GO_DIR) && \
	go get golang.org/x/mobile/cmd/gomobile
	go clean -cache

# Build XCFramework
build:
	@echo "Building $(FRAMEWORK).framework..."
	@mkdir -p $(OUTPUT_DIR) # create directory if not exists
	@rm -rf $(OUTPUT) # delete old freamework
	@cd Sources/$(GO_DIR) && \
	export MACOSX_DEPLOYMENT_TARGET=$(MACOSX_DEPLOYMENT_TARGET) && \
	CGO_CFLAGS="-mmacosx-version-min=$(MACOSX_DEPLOYMENT_TARGET)" \
	CGO_LDFLAGS="-mmacosx-version-min=$(MACOSX_DEPLOYMENT_TARGET)" \
	gomobile bind -ldflags="-s -w" -o ../../$(OUTPUT) -target=macos
	
# Clean output
clean: rm -rf $(OUTPUT)
