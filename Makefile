# Export env variables
include .env
# Loging to AWS ECR

test_env_vars:
	@echo $(AWS_ACCOUNT_ID)
	@echo $(AWS_REGION)
	@echo $(IMAGE_NAME)
	@echo $(IMAGE_TAG)

login_ecr:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com

# Build Docker Image AMD64
build_image:
	docker buildx build --platform linux/amd64 -t $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(IMAGE_NAME):$(IMAGE_TAG) -f Dockerfile --push .