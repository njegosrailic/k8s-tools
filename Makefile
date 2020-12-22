#
# Makefile
#
# Simple makefile to build or push image.
#
# @author Njegos Railic <railic.njegos@gmail.com>
#

default: build

DOCKER_IMAGE ?= njegosrailic/k8s-tools
DOCKER_TAG ?= `git rev-parse --abbrev-ref HEAD`

build:
	docker build \
	  --build-arg GIT_REF=`git rev-parse --short HEAD` \
	  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	  -t $(DOCKER_IMAGE):$(DOCKER_TAG) . -f Dockerfile
	  
push:
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
