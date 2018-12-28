IMAGE_NAME=rcarmo/mqtt-broadlink:arm32v7
CONTAINER_NAME=mqtt-broadlink
build: Dockerfile
	docker build -t ${IMAGE_NAME} .

shell:
	docker run -it ${IMAGE_NAME} /bin/sh

daemon:
	-docker kill ${CONTAINER_NAME}
	-docker rm ${CONTAINER_NAME}
	docker run --name ${CONTAINER_NAME} \
	-d --restart=always --net=host -p 1883:1883 \
	${IMAGE_NAME}

push:
	docker push ${IMAGE_NAME}

clean:
	-docker rm -v $$(docker ps -a -q -f status=exited)
	-docker rmi $$(docker images -q -f dangling=true)
	-docker rmi $(IMAGE_NAME)
