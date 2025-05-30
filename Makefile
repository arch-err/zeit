#!CMD: make container-build && make container-run
#!CMD: make TAG=test container-build
IMAGE_NAME := ghcr.io/arch-err/zeit
TAGDEFAULT := dev
TAG := $(TAGDEFAULT)

container-build:
	docker build -t $(IMAGE_NAME):$(TAG) . --label "org.opencontainers.image.version=$(TAG)" --label "org.opencontainers.image.revision=$$(git rev-parse --short HEAD)"
ifneq ("$(TAG)","$(TAGDEFAULT)")
	@sed -i "s/image: \(.*\):.*/image: \1:$(TAG)/" compose.yml
endif

container-push:
	docker push $(IMAGE_NAME):$(TAG)

container-run:
	docker run -p 8080:8080 $(IMAGE_NAME):$(TAG)

container-inspect:
	docker inspect $(IMAGE_NAME):$(TAG)

dev:
	pushd ./webserver/ >/dev/null ;\
	APP_DIR="../app" air ;\
	popd >/dev/null

container-clean:
	docker rmi -f $(IMAGE_NAME):$(TAG) || true

.PHONY: container-build container-run container-push container-clean container-inspect dev
