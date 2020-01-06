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
		
		13)
			export JAVA_HOME=$JAVA_13_HOME
			;;

		*)
			echo $("Only 8, 11, and 13 versions of Java are configured")
		
	esac
}
