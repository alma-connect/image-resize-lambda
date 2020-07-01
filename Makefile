MAKE_FILE_DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.PHONY: all image package dist clean

all: package

image:
	docker build --tag amazonlinux:nodejs .

package: image
	mkdir -p dist/lambda-package
	docker run --rm --entrypoint cat amazonlinux:nodejs  /build/lambda-package.zip > dist/lambda-package/lambda-package.zip

dist: package

clean_dist:
	rm -r dist

clean: clean_dist
	docker rmi --force amazonlinux:nodejs
