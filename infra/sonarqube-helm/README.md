3. Passos para Aplicar a Configuração
Ingress Controller: Certifique-se de que o Ingress Controller esteja corretamente configurado no seu cluster (por exemplo, o NGINX Ingress). Caso contrário, o SonarQube não conseguirá expor os serviços para fora do cluster Kubernetes.

Criar o Secret com o Certificado Digital: Se você já tem um certificado TLS para o SonarQube, você pode criar um Secret para armazená-lo no Kubernetes:

bash
Copiar
Editar
kubectl create secret tls sonarqube-ingress-tls-secret \
  --cert=/path/to/cert.crt \
  --key=/path/to/cert.key \
  --namespace sonarqube
Isso cria um Secret no namespace sonarqube com o certificado e chave privada.

Aplicar a Configuração com Kustomize: Agora, com o arquivo kustomization.yaml e values.yaml configurados, você pode aplicar os recursos com o comando:

bash
Copiar
Editar
kubectl apply -k ./path/to/your/kustomize/directory
Este comando aplicará as configurações e instalará o SonarQube com as integrações configuradas.

4. Testar a Integração
LDAP (Active Directory): Após a instalação, você pode verificar se a autenticação via LDAP está funcionando ao tentar fazer login com um usuário do Active Directory.

SMTP: Verifique se o envio de e-mails está funcionando corretamente. Isso pode ser feito, por exemplo, testando a recuperação de senha ou o envio de alertas.

Ingress/TLS: O SonarQube deve estar acessível via https://sonarqube.example.com, com um certificado TLS configurado corretamente.