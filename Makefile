.PHONY: build install clean test deps run help

# Variables
BINARY_NAME=orgmai
CMD_DIR=./cmd/orgmai

# Build orgmai binary to root directory
build:
	@echo "Building $(BINARY_NAME)..."
	@go build -o $(BINARY_NAME) $(CMD_DIR)
	@chmod +x $(BINARY_NAME)
	@echo "Build complete: ./$(BINARY_NAME)"

# Install: build and copy to ~/.local/bin
install: build
	@echo "Installing $(BINARY_NAME)..."
	@mkdir -p ~/.local/bin
	@cp $(BINARY_NAME) ~/.local/bin/$(BINARY_NAME)
	@chmod +x ~/.local/bin/$(BINARY_NAME)
	@echo "Installation complete: ~/.local/bin/$(BINARY_NAME)"

# Clean build artifacts
clean:
	@echo "Cleaning..."
	@go clean
	@rm -f $(BINARY_NAME)
	@rm -rf build/
	@echo "Clean complete"

# Run tests
test:
	@go test ./...

# Update dependencies
deps:
	@go mod tidy

# Run the application
run: build
	@./$(BINARY_NAME)

# Help
help:
	@echo "Available targets:"
	@echo "  build   - Build orgmai binary in root directory"
	@echo "  install - Build and install to ~/.local/bin"
	@echo "  clean   - Remove build artifacts"
	@echo "  test    - Run tests"
	@echo "  deps    - Update dependencies"
	@echo "  run     - Build and run orgmai"
	@echo "  help    - Show this help"
