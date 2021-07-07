#!/usr/bin/env bash

DEVENV=${OF_DEV_ENV:-kind}
KUBE_VERSION=v1.18.8

echo ">>> Creating Kubernetes ${KUBE_VERSION} cluster ${DEVENV}"

kind create cluster --image kindest/node:${KUBE_VERSION} --name "$DEVENV" -v 5

echo ">>> Get overall cluster health"
kubectl --context "kind-$DEVENV" cluster-info dump
echo ">>> Waiting for CoreDNS"
kubectl --context "kind-$DEVENV" -n kube-system rollout status deployment/coredns
