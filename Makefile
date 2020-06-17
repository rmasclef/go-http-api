GIT_TAG_NAME ?= $(shell git describe --abbrev=1 --tags)
DOCKER_REPOSITORY ?= rmasclef/go-http-api

lint:
	@echo "> Launch linter..."
	docker run --rm -v $(PWD):/project -w /project golangci/golangci-lint:v1.24.0-alpine golangci-lint run -v

test:
	@echo "> running tests ..."
	go test --race -v ./... 2>&1

build-image:
	@echo "> start building docker image..."
	DOCKER_BUILDKIT=1 docker build --build-arg APP_VERSION="$(TAG)" -t $(DOCKER_REPOSITORY):$(TAG) .

push-image:
	@echo "> start pushing docker image..."
	docker push $(DOCKER_REPOSITORY):$(TAG)

#run:
#	@echo "> running fizz-buzz-api on port $(HTTP_PORT)"
#	go run ./cmd/... -HTTP_ADDR=:$(HTTP_PORT)

.PHONY: lint test build-image push-image run
