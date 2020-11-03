IMAGE_NAME = myimage
SOURCE_DIR = $(shell pwd)/src
TARGET_DIR = /app/src

rebuild: clean build
	
run:
	docker run -it --rm -v "${SOURCE_DIR}:${TARGET_DIR}" ${IMAGE_NAME}

debug:
	@echo "Saving container. Make sure to delete later!"
	docker run -it -v "${SOURCE_DIR}:${TARGET_DIR}" ${IMAGE_NAME}

clean:
	@echo "Removing old image"
	docker system prune -f
	docker rmi ${IMAGE_NAME}

build:
	@echo "Building new image"
	docker build -t ${IMAGE_NAME} .

build_nc:
	@echo "Building new image without cache"
	docker build --no-cache -t ${IMAGE_NAME} .

all: rebuild run