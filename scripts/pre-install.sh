#!/bin/bash

usage() {
	if [ `whoami` != 'root' ]; 
		then echo "this script must be executed as root" && exit 1;
	fi
}
usage
