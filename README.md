# Preparação da máquina de desenvolvimento

## Instalação do Docker no WSL

https://github.com/codeedu/wsl2-docker-quickstart

## Instalando o kind e kubectl

1. Instale o kind

https://kind.sigs.k8s.io/docs/user/quick-start/#installation


```bash
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/sbin/kind
```
2. Instalar o kubectl

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/sbin/kubectl
```

3. Instalar componentes do kubernetes
```bash
snap install helm --classic
snap install kustomize
```

# Iniciando a configuração da Infra

## Criando o cluster com o kind

1. Criar o Cluster com kind

```bash
mkdir -p /kind-data

kind create cluster --config ./infra/kind/cluster.yaml
```

2. Verifique se está tudo ok:

```bash
kubectl cluster-info --context kind-kdev
kubectl get nodes
```

3. Instalar o Ingress Controller (nginx) usando o helm e o values.yaml

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx --create-namespace \
  -f infra/ingress-nginx-helm/values.yaml
```

4. Espere o pod ingress-nginx-controller ficar Running:

```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```

## Configurando o postgres

O objetivo é ter um postgres externo para todos os PODs

1. Instalando o postgres

```bash
kubectl apply -k infra/argocd
```

# Instalando o Argo CD

1. Crie um domínio local (ex: argocd.local): Adicione ao seu /etc/hosts (Linux/macOS) ou C:\Windows\System32\drivers\etc\hosts (Windows):

```bash
127.0.0.1  argocd.localhost
```

2. Instalando o Argo CD

```bash
kubectl apply -k infra/argocd

kubectl get svc -n argocd
```

3. Pegar a senha do argocd
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

4. Acesse via browser: https://localhost:8443

```bash
Login:
Usuário: admin
Senha: (resultado do comando acima)
```

# Colocando a aplicação my-app para funcionar

1. Crie um domínio local (ex: argocd.local): Adicione ao seu /etc/hosts (Linux/macOS) ou C:\Windows\System32\drivers\etc\hosts (Windows):

```bash
127.0.0.1  my-app.localhost
```

1. Compile o container

```bash
cd my-app

docker build -t marquesmarcelo/my-app.localhost:latest .
```

2. Transfira o container para uma docker registry

```bash
docker push marquesmarcelo/my-app.localhost:latest
```

3. Instalar o my-app no kubernetes local

```bash
kubectl apply -k my-app/kubernetes
```

# Gerar os certificados digitais

1. Gerar um certificado digital autoassinado

```bash
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout tls.key \
  -out tls.crt \
  -subj "/CN=argocd.localhost/O=MinhaEmpresa"
```

2. Criar um Secret TLS no Kubernetes

Depois de gerar os arquivos, crie um Secret com tipo TLS:

```bash
kubectl create secret tls meu-certificado-tls \
  --cert=tls.crt \
  --key=tls.key \
  -n NAMESPACE
```

Substitua NAMESPACE pelo namespace do seu app, como argocd, sonarqube, etc.