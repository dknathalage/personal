#!/bin/bash
# docker push dknathalage/personal:svc-name

service_dirs=(
    "svc-front"
    "svc-web"
)

for dir in ${service_dirs[@]}; do
    docker build -t dknathalage/personal:$dir $dir
done

for dir in ${service_dirs[@]}; do
    docker push dknathalage/personal:$dir
done

for dir in ${service_dirs[@]}; do
    microk8s.helm uninstall $dir
    microk8s.helm install $dir -f ./config/$dir.yaml ./config/service
done

