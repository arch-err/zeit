#!CMD: make container-build && make container-run
IMAGE_NAME := ghcr.io/arch-err/zeit/zeit
TAG := dev

container-build:
	docker build --build-arg VERSION=$(TAG) -t $(IMAGE_NAME):$(TAG) .

container-push:
	docker push $(IMAGE_NAME):$(TAG)

container-run:
	docker run -p 8080:8080 $(IMAGE_NAME):$(TAG)

dev:
	pushd ./webserver/ >/dev/null ;\
	APP_DIR="../app" air ;\
	popd >/dev/null

container-clean:
	docker rmi -f $(IMAGE_NAME):$(TAG) || true

.PHONY: container-build container-run container-push container-clean
