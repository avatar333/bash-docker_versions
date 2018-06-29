#!/usr/bin/env bash
#title           :docker_versions.sh
#description     :A script to display running and available version for each docker
#author          :Kevin Pillay
#date            :20180629
#version         :0.1
#usage           :bash docker_versions.sh
#notes           :
#bash_version    :GNU bash, version 4.4.19(1)-release (x86_64-redhat-linux-gnu)
#==============================================================================

if [[ $(id -u $USERNAME) -ne 0 ]]
then
        printf "\nYou need to run this as root\n"
        exit 1
fi

for DOCKER in $(docker ps -a | grep -v IMAGE| awk -F '[[:space:]][[:space:]]+' '{print $6}')
do
        IMAGE=$(docker ps -a | grep $DOCKER | awk -F '[[:space:]][[:space:]]+' '{print $2}')
        NAME=$(docker ps -a | grep $DOCKER | awk -F '[[:space:]][[:space:]]+' '{print $6}')

        printf "Image version for : $DOCKER\n"
        printf "docker inspect -f '{{ index .Config.Labels \"build_version\" }}' $IMAGE\n" | /bin/bash

        printf "Container version for : $DOCKER\n"
        printf "docker inspect -f '{{ index .Config.Labels \"build_version\" }}' $NAME\n\n" | /bin/bash

done
