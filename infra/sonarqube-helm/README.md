

Adicionar o repositório do Helm do SonarQube:

Primeiro, adicione o repositório oficial do Helm para o SonarQube:

```bash
helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo update
```

Instalar o SonarQube com Helm:

Agora, você pode instalar o SonarQube em seu cluster Kubernetes. Crie um namespace sonarqube (caso ainda não tenha):

```bash
kubectl create namespace sonarqube
```


Passos complementares
Atualize seu /etc/hosts local (ou equivalente no Windows):

```bash
127.0.0.1 sonarqube.localhost
```

(Opcional) Gerar um certificado self-signed para teste:

```bash
kubectl create namespace sonarqube

mkdir -p infra/sonarqube-helm/tls

openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
  -out infra/sonarqube-helm/tls/tls.crt -keyout infra/sonarqube-helm/tls/tls.key \
  -subj "/CN=sonarqube.localhost/O=SonarQube"

kubectl create secret tls sonarqube-tls \
  --key infra/sonarqube-helm/tls/tls.key --cert infra/sonarqube-helm/tls/tls.crt \
  -n sonarqube
```


```bash
helm upgrade --install sonarqube sonarqube/sonarqube -n sonarqube --create-namespace -f path/to/your/values.yaml --set community.enabled=true,monitoringPasscode=admin123
```


Usuário e senha padrão

```bash
admin
admin
```