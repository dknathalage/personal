#!/bin/bash
# docker push dknathalage/personal:svc-name

service_dirs=(
    "svc-front"
)

for dir in ${service_dirs[@]}; do
    docker build -t dknathalage/personal:$dir $dir
done

for dir in ${service_dirs[@]}; do
    docker push dknathalage/personal:$dir
done

