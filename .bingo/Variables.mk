# Auto generated binary variables helper managed by https://github.com/bwplotka/bingo v0.8. DO NOT EDIT.
# All tools are designed to be build inside $GOBIN.
BINGO_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
GOPATH ?= $(shell go env GOPATH)
GOBIN  ?= $(firstword $(subst :, ,${GOPATH}))/bin
GO     ?= $(shell which go)

# Below generated variables ensure that every time a tool under each variable is invoked, the correct version
# will be used; reinstalling only if needed.
# For example for bingo variable:
#
# In your main Makefile (for non array binaries):
#
#include .bingo/Variables.mk # Assuming -dir was set to .bingo .
#
#command: $(BINGO)
#	@echo "Running bingo"
#	@$(BINGO) <flags/args..>
#
BINGO := $(GOBIN)/bingo-v0.8.0
$(BINGO): $(BINGO_DIR)/bingo.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/bingo-v0.8.0"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=bingo.mod -o=$(GOBIN)/bingo-v0.8.0 "github.com/bwplotka/bingo"

GINKGO := $(GOBIN)/ginkgo-v2.9.1
$(GINKGO): $(BINGO_DIR)/ginkgo.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/ginkgo-v2.9.1"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=ginkgo.mod -o=$(GOBIN)/ginkgo-v2.9.1 "github.com/onsi/ginkgo/v2/ginkgo"

GO_ENUM := $(GOBIN)/go-enum-v0.5.5
$(GO_ENUM): $(BINGO_DIR)/go-enum.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/go-enum-v0.5.5"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=go-enum.mod -o=$(GOBIN)/go-enum-v0.5.5 "github.com/abice/go-enum"

GOFUMPT := $(GOBIN)/gofumpt-v0.4.0
$(GOFUMPT): $(BINGO_DIR)/gofumpt.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/gofumpt-v0.4.0"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=gofumpt.mod -o=$(GOBIN)/gofumpt-v0.4.0 "mvdan.cc/gofumpt"

GOIMPORTS := $(GOBIN)/goimports-v0.7.0
$(GOIMPORTS): $(BINGO_DIR)/goimports.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/goimports-v0.7.0"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=goimports.mod -o=$(GOBIN)/goimports-v0.7.0 "golang.org/x/tools/cmd/goimports"

GOLANGCI_LINT := $(GOBIN)/golangci-lint-v1.51.2
$(GOLANGCI_LINT): $(BINGO_DIR)/golangci-lint.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/golangci-lint-v1.51.2"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=golangci-lint.mod -o=$(GOBIN)/golangci-lint-v1.51.2 "github.com/golangci/golangci-lint/cmd/golangci-lint"

SWAG := $(GOBIN)/swag-v1.8.10
$(SWAG): $(BINGO_DIR)/swag.mod
	@# Install binary/ries using Go 1.14+ build command. This is using bwplotka/bingo-controlled, separate go module with pinned dependencies.
	@echo "(re)installing $(GOBIN)/swag-v1.8.10"
	@cd $(BINGO_DIR) && GOWORK=off $(GO) build -mod=mod -modfile=swag.mod -o=$(GOBIN)/swag-v1.8.10 "github.com/swaggo/swag/cmd/swag"

