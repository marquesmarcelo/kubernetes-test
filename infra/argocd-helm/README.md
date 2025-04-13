

Instalar o Argo CD com Helm

```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm upgrade --install argocd argo/argo-cd \
  --namespace argocd --create-namespace \
  -f infra/argocd-helm/values.yaml
```


Passos complementares
Atualize seu /etc/hosts local (ou equivalente no Windows):

```bash
127.0.0.1 argocd.localhost
```

(Opcional) Gerar um certificado self-signed para teste:

```bash
kubectl create namespace argocd

mkdir -p infra/argocd-helm/tls

openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
  -out infra/argocd-helm/tls/tls.crt -keyout infra/argocd-helm/tls/tls.key \
  -subj "/CN=argocd.localhost/O=ArgoCD"

kubectl create secret tls argocd-tls \
  --key infra/argocd-helm/tls/tls.key --cert infra/argocd-helm/tls/tls.crt \
  -n argocd
```

Aplicar o Ingress:

```bash
kubectl apply -f infra/argocd-helm/ingress.yaml
```

A senha estará codificada em base64. Para decodificar, você pode usar o seguinte comando:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
```
