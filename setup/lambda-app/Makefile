ECR_REPO := 541216676946.dkr.ecr.us-west-2.amazonaws.com/datadog-demo/lambda-app

.PHONY: push-image
push-image:
ifndef VERSION
	$(error VERSION is required. Usage: make push-image VERSION=x.y.z)
endif
	docker buildx build \
		--platform linux/amd64 \
		--provenance=false \
		--build-arg VERSION=$(VERSION) \
		-t $(ECR_REPO):$(VERSION) \
		--push \
		.
