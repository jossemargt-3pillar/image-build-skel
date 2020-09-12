GO     ?= go
DOCKER ?= docker

BINDIR = bin
BINARY = image-build-skel

VERSION = v0.1.0
PREFIX  = /usr/local

$(BINDIR)/$(BINARY): $(BINDIR) clean
	$(GO) build -v -o $@

$(BINDIR):
	mkdir -p $@

.PHONY: install
install: $(BINDIR)/$(BINARY)
	sudo install -C $< $(PREFIX)/bin

.PHONY: uninstall
uninstall:
	sudo rm -f $(PREFIX)/$(BINDIR)/$(BINARY)

.PHONY: image-build
image-build:
	$(DOCKER) build -t rancher/hardened-$(BINARY):$(VERSION) .

.PHONY: image-push
image-push:
	$(DOCKER) push rancher/hardened-$(BINARY):$(VERSION)

.PHONY: scan
image-scan:
	trivy --severity $(SEVERITIES) --no-progress --skip-update --ignore-unfixed rancher/hardened-$(BINARY):$(VERSION)

.PHONY: image-manifest
image-manifest:
	docker image inspect rancher/hardened-$(BINARY):$(VERSION)
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create rancher/hardened-$(BINARY):$(VERSION) \
		$(shell docker image inspect rancher/hardened-$(BINARY):$(VERSION) | jq -r '.[] | .RepoDigests[0]')

.PHONY: clean
clean:
	$(GO) clean
	rm -f $(BINDIR)/*
	rm -rf tmp/* tmp/.drone.yml
	rm -f *.out

