IMAGE_TAG ?= latest

.PHONY: clean test build

BIN = ChatWeb

all: clean go-build

clean:
	rm $(BIN)

local-test: go-fmt go-lint go-test go-build
	@echo 'Run local-test success!'

go-fmt:
	goimports -l -w -local "envoyauth/" .

go-lint:
	golangci-lint run

go-test:  # -race
	go test -v -cover -race envoyauth/...

go-test-with-musl:  # -race
	go test -tags 'musl' -v -cover -race envoyauth/...

go-build:
	go build -ldflags="-s -w" -gcflags='-l -l' -o $(BIN) main.go



