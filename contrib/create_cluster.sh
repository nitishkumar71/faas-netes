#!/usr/bin/env bash

DEVENV=${OF_DEV_ENV:-kind}
KUBE_VERSION=v1.18.8

echo ">>> Creating Kubernetes ${KUBE_VERSION} cluster ${DEVENV}"

kind create cluster --wait 5m --image kindest/node:${KUBE_VERSION} --name "$DEVENV" -v 1

echo ">>> Waiting for CoreDNS"
kubectl --context "kind-$DEVENV" -n kube-system rollout status deployment/coredns


echo ">>> Descibe Kind Node"
kubectl --context "kind-$DEVENV" -n kube-system describe nodes

echo ">>> Descibe CoreDNS Deploy"
kubectl --context "kind-$DEVENV" -n kube-system describe deploy/coredns

echo ">>> Descibe CoreDNS Pods"
kubectl --context "kind-$DEVENV" -n kube-system describe pod -l k8s-app=kube-dns

echo ">>>> Get Pods in kube-system"
kubectl --context "kind-$DEVENV" -n kube-system get pods

echo ">>>> Get logs of coredns"
kubectl --context "kind-$DEVENV" -n kube-system logs -l k8s-app=kube-dns