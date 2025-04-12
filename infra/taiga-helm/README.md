Passos para Aplicar a Configuração
Certifique-se de que o Ingress Controller está funcionando (por exemplo, o NGINX Ingress). Caso contrário, o Taiga não conseguirá expor os serviços para fora do cluster Kubernetes.

Crie o Secret com o certificado digital:

O certificado TLS usado no Ingress pode ser criado a partir de um arquivo de certificado e chave privada. Aqui está um exemplo de como criar o Secret:

bash
Copiar
Editar
kubectl create secret tls taiga-ingress-tls-secret \
  --cert=/path/to/cert.crt \
  --key=/path/to/cert.key \
  --namespace taiga
Aplicar o Kustomize: Com os arquivos kustomization.yaml e values.yaml configurados, aplique o recurso com o comando:

bash
Copiar
Editar
kubectl apply -k ./path/to/your/kustomize/directory
4. Testar a Integração
LDAP (Active Directory): Após a instalação do Taiga, você deve conseguir autenticar no Taiga usando as credenciais do Active Directory configuradas.

GitLab: O Taiga poderá se integrar com o GitLab para buscar repositórios e usar a API do GitLab com o token configurado.

SMTP: Verifique se o envio de e-mails está funcionando, como notificações de recuperação de senha ou alertas.

Ingress: O Taiga deverá estar acessível via https://taiga.example.com com o certificado TLS corretamente configurado.