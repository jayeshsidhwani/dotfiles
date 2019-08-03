#!/bin/bash

function loginECR {
	AWS_PROFILE=$1
	echo "=== Logging in to $AWS_PROFILE AWS profile ==="
	eval $(aws ecr get-login --profile $AWS_PROFILE --no-include-email)
	echo "\n ********** \n"
	echo "=== Logging into Docker Repository ==="
	docker login
}

function setJava {
	case "$1" in
		8)
			export JAVA_HOME=$JAVA_8_HOME
			;;

		11)
			export JAVA_HOME=$JAVA_11_HOME
			;;
		
		12)
			export JAVA_HOME=$JAVA_12_HOME
			;;

		*)
			echo $("Only 11 and 12 versions of Java are configured")
		
	esac
}
