MAKE_FILE_DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.PHONY: all image package dist clean

all: package

image:
	docker build --tag amazonlinux:nodejs .

package: image
	mkdir -p dist/build && cp -r app index.js config.js package.json dist/build/
	docker run --rm --volume ${MAKE_FILE_DIR}/dist/build:/build amazonlinux:nodejs npm install --production

dist: package
	cd dist/build && zip -FS -q -r ../../lambda-package.zip *

clean_dist: dist
	rm -r dist

clean: clean_dist
	docker rmi --force amazonlinux:nodejs
