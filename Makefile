.PHONY: run build test check

ENV := set -a; [ -f .env ] && . ./.env; set +a;
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)
LDFLAGS := -s -w -X main.version=$(VERSION)

run:
	$(ENV) go run ./cmd/reconciler

build:
	go build -ldflags "$(LDFLAGS)" -o bin/reconciler ./cmd/reconciler

test:
	go test ./...

check:
	gofmt -l .
	go vet ./...
	go test ./...

