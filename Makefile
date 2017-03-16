
VERSION=`cat ./version`
NAME=pgbouncer
REGISTRY=827541288795.dkr.ecr.us-east-1.amazonaws.com

build:
	docker build -t $(NAME)\:$(VERSION) . && docker tag $(NAME):$(VERSION) $(REGISTRY)/$(NAME)\:$(VERSION)

push:
	`aws ecr get-login --region us-east-1` && docker push $(REGISTRY)/$(NAME)\:$(VERSION)

