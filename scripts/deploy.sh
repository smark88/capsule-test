#!/bin/bash

clusterVersion="kindest/node:v1.24.15"

# create cluster
kind create cluster --config config.yaml --image=${clusterVersion}
# wait for kube proxy
kubectl wait --for=condition=ready --timeout=240s -n kube-system pod -l k8s-app=kube-proxy
# install helm repo
helm repo add clastix https://clastix.github.io/charts
# helm update
helm repo update
# helm install capsule
helm install capsule clastix/capsule -n capsule-system --create-namespace