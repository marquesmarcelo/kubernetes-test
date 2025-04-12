#!/bin/bash

# ----------------------------
# Verificando Clusters do KIND
# ----------------------------
echo "Verificando clusters do KIND..."
kind_clusters=$(kind get clusters)
if [ -z "$kind_clusters" ]; then
    echo "Nenhum cluster Kind ativo."
else
    echo "Clusters Kind ativos: $kind_clusters"
fi

# ----------------------------
# Verificando recursos do Kubernetes
# ----------------------------
echo "Verificando recursos no Kubernetes..."

# Verificando pods, services e deployments
kubectl_resources=$(kubectl get pods,services,deployments --all-namespaces)
if [ -z "$kubectl_resources" ]; then
    echo "Nenhum recurso do Kubernetes encontrado."
else
    echo "Recursos Kubernetes encontrados: $kubectl_resources"
fi

# Verificando namespaces
kubectl_namespaces=$(kubectl get namespaces)
if [ "$kubectl_namespaces" == "No resources found." ]; then
    echo "Nenhum namespace encontrado no Kubernetes."
else
    echo "Namespaces no Kubernetes encontrados: $kubectl_namespaces"
fi

# Verificando volumes persistentes
kubectl_volumes=$(kubectl get pv)
if [ -z "$kubectl_volumes" ]; then
    echo "Nenhum volume persistente encontrado no Kubernetes."
else
    echo "Volumes persistentes encontrados: $kubectl_volumes"
fi

# ----------------------------
# Verificando Docker
# ----------------------------
echo "Verificando containers no Docker..."
docker_containers=$(docker ps -a)
if [ -z "$docker_containers" ]; then
    echo "Nenhum container Docker encontrado."
else
    echo "Containers Docker encontrados: $docker_containers"
fi

echo "Verificando imagens no Docker..."
docker_images=$(docker images)
if [ -z "$docker_images" ]; then
    echo "Nenhuma imagem Docker encontrada."
else
    echo "Imagens Docker encontradas: $docker_images"
fi

echo "Verificando volumes no Docker..."
docker_volumes=$(docker volume ls)
if [ -z "$docker_volumes" ]; then
    echo "Nenhum volume Docker encontrado."
else
    echo "Volumes Docker encontrados: $docker_volumes"
fi

# ----------------------------
# Verificando arquivos de configuração
# ----------------------------
echo "Verificando arquivos de configuração..."

# Verificando arquivos de configuração do Kubernetes e Kind
if [ -d "~/.kube" ]; then
    echo "Configuração Kubernetes encontrada em ~/.kube"
else
    echo "Nenhuma configuração Kubernetes encontrada."
fi

if [ -d "~/.kind" ]; then
    echo "Configuração Kind encontrada em ~/.kind"
else
    echo "Nenhuma configuração Kind encontrada."
fi

# ----------------------------
# Finalizando
# ----------------------------
echo "Verificação completa concluída!"
