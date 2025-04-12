Passos para adicionar um certificado digital ao Argo CD:

Passo 1: Criar um Secret com o certificado e a chave privada

Primeiro, você precisa criar um Secret contendo o certificado e a chave privada. Isso pode ser feito com o comando kubectl create secret tls.

Exemplo de comando:
```bash
kubectl create secret tls argocd-ingress-tls-secret \
  --cert=/path/to/your/cert.crt \
  --key=/path/to/your/cert.key \
  -n argocd
--cert=/path/to/your/cert.crt: Caminho para o certificado (arquivo .crt).

--key=/path/to/your/cert.key: Caminho para a chave privada (arquivo .key).

-n argocd: O namespace onde o Argo CD está instalado (no seu caso, é argocd).
```

Este comando criará um Secret chamado argocd-ingress-tls-secret no namespace argocd, que conterá o certificado e a chave privada.

Passo 2: Configurar o Ingress para usar o certificado

Agora que o Secret foi criado, você precisa configurar o Ingress para usar o certificado TLS.

No seu arquivo values.yaml para o Argo CD (ou no seu arquivo de configuração do Helm), você precisa adicionar a configuração do Ingress TLS para apontar para o Secret criado.

Exemplo de configuração do Ingress no values.yaml:




Para verificar o conteúdo do Secret gerado:

```bash
kubectl get secret argocd-ldap-secret -n argocd
```

Ver o conteúdo do Secret (decodificado para base64):

```bash
kubectl get secret argocd-ldap-secret -n argocd -o yaml
```

A senha estará codificada em base64. Para decodificar, você pode usar o seguinte comando:

```bash
kubectl get secret argocd-ldap-secret -n argocd -o jsonpath="{.data.ldap\.bindPW}" | base64 --decode
```
