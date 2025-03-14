PROJECT_NAME=bolt
VERSION=$(shell git log --oneline | wc -l)
FILENAME=dist/$(PROJECT_NAME)-v$(VERSION).stl

.PHONY: preview
preview:
	openscad --hardwarnings main.scad

.PHONY: build
build: $(FILENAME)

.PHONY: $(FILENAME)
$(FILENAME): main.scad
	mkdir -p dist
	openscad --hardwarnings -o $(FILENAME) main.scad

.PHONY: version
version:
	@echo $(VERSION)

