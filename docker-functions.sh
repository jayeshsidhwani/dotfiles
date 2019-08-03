#!/bin/bash

function loginHSDockerRegistry {
	eval $(echo $1 aws ecr get-login --profile prod-us --no-include-email);
	docker login
}

function startSonar {
	if $1
	then
		stopContainer sonarqube
	fi
	
	docker run -d --name sonarqube -p 9000:9000 \
	-v /usr/local/etc/sonarqube/conf:/opt/sonarqube/conf \
	-v /usr/local/etc/sonarqube/data:/opt/sonarqube/data \
	-v /usr/local/etc/sonarqube/logs:/opt/sonarqube/logs \
	-v /usr/local/etc/sonarqube/extensions:/opt/sonarqube/extensions sonarqube
}

# First argument controls whether the container should be restarted. It is a boolean
function startPostgres {
	if $1
	then
		stopContainer postgres
	fi

	docker run -d --name postgres -p 5432:5432 \
	-v /usr/local/etc/postgres/data:/var/lib/postgresql/data \
	-e POSTGRES_USER=root \
	-e POSTGRES_PASSWORD=password \
	postgres:latest
}

function stopContainer {
	docker kill $1
	docker rm $1
}
