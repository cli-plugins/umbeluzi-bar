BINARY_NAME=umbeluzi-bar
VERSION=$(shell git describe --tags --always)
WASM_FILE=dist/$(BINARY_NAME)-v$(VERSION).wasm
TARBALL=dist/$(BINARY_NAME)-v$(VERSION).tar.gz

# Add directory creation
$(shell mkdir -p dist)

.PHONY: build
build:
	tinygo build -o $(WASM_FILE) -target wasi -no-debug .
	tar -czf $(TARBALL) -C dist $(BINARY_NAME)-v$(VERSION).wasm

# Add dev build with debug symbols
.PHONY: build-debug
build-debug:
	tinygo build -o $(WASM_FILE) -target wasi .

# Add verification step
.PHONY: verify
verify: test lint

# Add linting
.PHONY: lint
lint:
	golangci-lint run

.PHONY: test
test:
	go test ./... -v -race -cover

.PHONY: clean
clean:
	rm -rf bin/ dist/

.PHONY: install
install:
	go install .

# Add a watch target for development
.PHONY: watch
watch:
	watchexec -e go -- make build