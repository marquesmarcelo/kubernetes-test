#!/bin/bash

# ----------------------------
# Apagando Clusters do KIND
# ----------------------------
echo "Removendo clusters do KIND..."
kind delete clusters --all

# ----------------------------
# Apagando configurações do Kubernetes
# ----------------------------
echo "Removendo todos os recursos do Kubernetes..."
kubectl delete --all pods,services,deployments,ingresses --all-namespaces

echo "Removendo todos os namespaces não padrão no Kubernetes..."
kubectl delete namespaces $(kubectl get namespaces --no-headers | awk '{print $1}' | grep -v -e 'default' -e 'kube-system' -e 'kube-public' -e 'kube-node-lease')

# ----------------------------
# Apagando volumes e persistent volumes (se houver)
# ----------------------------
echo "Removendo volumes persistentes..."
kubectl delete pv --all
kubectl delete pvc --all --all-namespaces

# ----------------------------
# Apagando Docker
# ----------------------------
echo "Removendo containers Docker..."
docker ps -q | xargs -r docker stop
docker ps -a -q | xargs -r docker rm

echo "Removendo imagens Docker..."
docker images -q | xargs -r docker rmi -f

echo "Removendo volumes Docker..."
docker volume ls -q | xargs -r docker volume rm

# ----------------------------
# Removendo configuração do Kind e Kubernetes (se necessário)
# ----------------------------
echo "Removendo configuração do Kubernetes e Kind..."
rm -rf ~/.kube
rm -rf ~/.kind

# ----------------------------
# Removendo rede do Docker (se necessário)
# ----------------------------
echo "Removendo redes do Docker..."
docker network ls -q | xargs -r docker network rm

# ----------------------------
# Finalizando
# ----------------------------
echo "Ambiente de Kubernetes (Kind e Docker) apagado com sucesso!"
