.PHONY: all clean generate build swagger test e2e-test lint run fmt docker-build help tools
.DEFAULT_GOAL:=help

include .bingo/Variables.mk

VERSION?=$(shell git describe --always --tags)
BUILD_TIME?=$(shell date '+%Y%m%d-%H%M%S')
DOCKER_IMAGE_NAME=spx01/blocky

BINARY_NAME:=blocky
BIN_OUT_DIR?=bin

GOARCH?=$(shell go env GOARCH)
GOARM?=$(shell go env GOARM)

GO_BUILD_FLAGS?=-v
GO_BUILD_LD_FLAGS:=\
	-w \
	-s \
	-X github.com/0xERR0R/blocky/util.Version=${VERSION} \
	-X github.com/0xERR0R/blocky/util.BuildTime=${BUILD_TIME} \
	-X github.com/0xERR0R/blocky/util.Architecture=${GOARCH}${GOARM}

GO_BUILD_OUTPUT:=$(BIN_OUT_DIR)/$(BINARY_NAME)$(BINARY_SUFFIX)

export PATH=$(shell go env GOPATH)/bin:$(shell echo $$PATH)

all: build test lint ## Build binary (with tests)

tools: ## installs tools
	go install github.com/bwplotka/bingo@latest
	bingo get -l -v

clean: ## cleans output directory
	rm -rf $(BIN_OUT_DIR)/*

swagger: ## creates swagger documentation as html file
	npm install bootprint bootprint-openapi html-inline
	$(SWAG) init -g api/api.go
	$(shell) node_modules/bootprint/bin/bootprint.js openapi docs/swagger.json /tmp/swagger/
	$(shell) node_modules/html-inline/bin/cmd.js /tmp/swagger/index.html > docs/swagger.html

serve_docs: ## serves online docs
	pip install mkdocs-material
	mkdocs serve

generate: tools ## Go generate
ifdef GO_SKIP_GENERATE
	$(info skipping go generate)
else
	go generate ./...
endif

build: generate ## Build binary
	go build $(GO_BUILD_FLAGS) -ldflags="$(GO_BUILD_LD_FLAGS)" -o $(GO_BUILD_OUTPUT)
ifdef BIN_USER
	$(info setting owner of $(GO_BUILD_OUTPUT) to $(BIN_USER))
	chown $(BIN_USER) $(GO_BUILD_OUTPUT)
endif
ifdef BIN_AUTOCAB
	$(info setting cap_net_bind_service to $(GO_BUILD_OUTPUT))
	setcap 'cap_net_bind_service=+ep' $(GO_BUILD_OUTPUT)
endif

test: tools ## run tests
	$(GINKGO) --label-filter="!e2e" --coverprofile=coverage.txt --covermode=atomic -cover ./...

e2e-test: tools ## run e2e tests
	docker buildx build \
		--build-arg VERSION=blocky-e2e \
		--network=host \
		-o type=docker \
		-t blocky-e2e \
		.
	$(GINKGO) --label-filter="e2e" ./...

race: tools ## run tests with race detector
	$(GINKGO) --label-filter="!e2e" --race ./...

lint: tools ## run golangcli-lint checks
	$(GOLANGCI_LINT) run --timeout 5m

run: build ## Build and run binary
	./$(BIN_OUT_DIR)/$(BINARY_NAME)

fmt: tools ## gofmt and goimports all go files
	$(GOFUMPT) -l -w -extra .
	find . -name '*.go' -exec $(GOIMPORTS) -w {} +

docker-build: generate ## Build docker image 
	docker buildx build \
		--build-arg VERSION=${VERSION} \
		--build-arg BUILD_TIME=${BUILD_TIME} \
		--network=host \
		-o type=docker \
		-t ${DOCKER_IMAGE_NAME} \
		.

help:  ## Shows help
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
