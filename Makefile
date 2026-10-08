.PHONY: all

# Reproducible build: U-Boot stamps its version/FIT timestamps from this.
SOURCE_DATE_EPOCH ?= $(shell git log -1 --format=%ct)

# platform flags maybe unnecessary, but left in for maybe
# arm mac builders???
all:
	docker build --platform linux/amd64 -t chip-uboot-amd64 .
	docker run --rm --platform linux/amd64 -e HOST_UID=$$(id -u) -e HOST_GID=$$(id -g) -e SOURCE_DATE_EPOCH=$(SOURCE_DATE_EPOCH) -v $$PWD:/build -w /build chip-uboot-amd64 ./uboot-build.sh
