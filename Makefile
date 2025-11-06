# Determine the current git Branch and use that for docker
BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)

NETBOX_BASE_VERSION = v2.2.1
RBLX_REVISION = 0.1.0
DB_SNAPSHOT_DATE = 20180821

PROD_APP_IMAGE = roblox/netbox-prod-app
PROD_FRONT_IMAGE = roblox/netbox-prod-front
PROD_IMAGE_TAG = $(NETBOX_BASE_VERSION)-$(RBLX_REVISION)

INTEG_APP_IMAGE = roblox/netbox-integ-app
INTEG_FRONT_IMAGE = roblox/netbox-integ-front
INTEG_IMAGE_TAG = $(NETBOX_BASE_VERSION)-$(RBLX_REVISION)

DB_REPLICA_IMAGE = roblox/netbox-db-replica

PWD = $(shell pwd)

RUN_INTEGRATION_OPTIONS = IMAGE_TAG=$(INTEG_IMAGE_TAG)
RUN_PROD_OPTIONS = IMAGE_TAG=$(PROD_IMAGE_TAG)

INTERNAL_DOCKER_REGISTRY=chi1-docker-registry.simulprod.com

### ----------------------------------------------------------------
### Production
### ---------------------------------------------------------------- 
production-build: production-app-build production-front-build

production-app-build:
	@echo "======================================================================"
	@echo "PRODUCTION - Build Netbox docker image"
	@echo "======================================================================"
	docker build -t $(INTERNAL_DOCKER_REGISTRY)/$(PROD_APP_IMAGE):$(PROD_IMAGE_TAG) -f ./rblx_configs/production/app/Dockerfile .

production-front-build:
	@echo "======================================================================"
	@echo "PRODUCTION - Build Nginx docker image"
	@echo "======================================================================"
	docker build -t $(INTERNAL_DOCKER_REGISTRY)/$(PROD_FRONT_IMAGE):$(PROD_IMAGE_TAG) -f ./rblx_configs/production/front/Dockerfile .

production-push:
	@echo "======================================================================"
	@echo "PRODUCTION - Pushing Docker Images to $(INTERNAL_DOCKER_REGISTRY) "
	@echo "======================================================================"
	docker push $(INTERNAL_DOCKER_REGISTRY)/$(PROD_FRONT_IMAGE):$(PROD_IMAGE_TAG)
	docker push $(INTERNAL_DOCKER_REGISTRY)/$(PROD_APP_IMAGE):$(PROD_IMAGE_TAG)
	
### ----------------------------------------------------------------
### Integration
### ---------------------------------------------------------------- 
integration-build: integration-app-build integration-front-build

integration-app-build:
	@echo "======================================================================"
	@echo "INTEGRATION - Build Netbox docker image"
	@echo "======================================================================"
	docker build -t $(INTERNAL_DOCKER_REGISTRY)/$(INTEG_APP_IMAGE):$(INTEG_IMAGE_TAG) -f ./rblx_configs/integration/app/Dockerfile .

integration-front-build:
	@echo "======================================================================"
	@echo "INTEGRATION - Build Nginx docker image"
	@echo "======================================================================"
	docker build -t $(INTERNAL_DOCKER_REGISTRY)/$(INTEG_FRONT_IMAGE):$(INTEG_IMAGE_TAG) -f ./rblx_configs/integration/front/Dockerfile .

integration-push:
	@echo "======================================================================"
	@echo "INTEGRATION - Pushing Docker Images to $(INTERNAL_DOCKER_REGISTRY) "
	@echo "======================================================================"
	docker push $(INTERNAL_DOCKER_REGISTRY)/$(INTEG_FRONT_IMAGE):$(INTEG_IMAGE_TAG)
	docker push $(INTERNAL_DOCKER_REGISTRY)/$(INTEG_APP_IMAGE):$(INTEG_IMAGE_TAG)
	docker push $(INTERNAL_DOCKER_REGISTRY)/$(DB_REPLICA_IMAGE):$(DB_SNAPSHOT_DATE)
	
### ----------------------------------------------------------------
### Database Replica
### ----------------------------------------------------------------
db-build:
	docker build -t $(INTERNAL_DOCKER_REGISTRY)/$(DB_REPLICA_IMAGE):$(DB_SNAPSHOT_DATE) -f rblx_configs/shared/db_replica/Dockerfile .

db-push:
	docker push $(INTERNAL_DOCKER_REGISTRY)/$(DB_REPLICA_IMAGE):$(DB_SNAPSHOT_DATE)

### ----------------------------------------------------------------
### Devlopment
### ----------------------------------------------------------------
 	
# dga-dev-build:
# 	docker build -t netbox-dev:latest -f rblx_configs/dev/Dockerfile.app .

# dga-dev-run:
# 	docker run -it -v $(shell pwd):/local -p 8080:8080 netbox-dev:latest bash

# dga-db-build:
# 	docker build -t netbox-dev-db:latest -f rblx_configs/dev/Dockerfile.db rblx_configs/docker_dev

# dga-db-run:
# 	docker run -d -p 5432:5432 netbox-dev-db:latest