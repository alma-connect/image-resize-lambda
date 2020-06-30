MAKE_FILE_DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.PHONY: all image package dist clean

all: package

image:
	docker build --tag amazonlinux:nodejs .

package: image
	mkdir -p dist/build && cp -r app index.js config.js package.json package-lock.json dist/build/
	ls ${MAKE_FILE_DIR}/dist/build
	docker run --rm --volume ${MAKE_FILE_DIR}/dist/build:/build amazonlinux:nodejs npm install --production
	ls ${MAKE_FILE_DIR}/dist/build

dist: package
	mkdir -p dist/lambda-package
	cd dist/build && zip -FS -q -r ../lambda-package/lambda-package.zip *

clean_dist:
	rm -r dist

clean: clean_dist
	docker rmi --force amazonlinux:nodejs
