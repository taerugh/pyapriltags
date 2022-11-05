ROOT=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))

build:
	# create build environment
	docker build \
		-t dt_apriltags:wheel-python3 \
		${ROOT}
	# create wheel destination directory
	mkdir -p ${ROOT}/dist
	# build wheel
	docker run \
		-it --rm \
		-v ${ROOT}:/apriltag \
		-v ${ROOT}/dist:/out \
		dt_apriltags:wheel-python3

upload:
	twine upload ${ROOT}/dist/*

clean:
	rm -rf ${ROOT}/dist/*

release-all:
	# build wheels
	make build
	# push wheels
	make upload
