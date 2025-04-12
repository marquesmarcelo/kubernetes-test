# Simulador para envio de email

Aplicar o Deployment:

Execute o comando para aplicar o arquivo YAML no Kubernetes:

bash
Copiar
Editar
kubectl apply -f mailhog-deployment.yaml
Acessando a Interface Web do MailHog:

Após o deployment ser criado, você pode acessar a interface web do MailHog, que permite visualizar os e-mails enviados para o servidor SMTP. Para isso, você pode expor a porta do MailHog usando um port-forward ou criar um Ingress.

Para fazer o port-forward:

bash
Copiar
Editar
kubectl port-forward svc/mailhog 8025:8025
Isso irá encaminhar a porta 8025 do MailHog para a sua máquina local. Agora você pode acessar a interface web do MailHog no seu navegador, indo para http://localhost:8025.

Configurar o SMTP no SonarQube (ou outra aplicação):

Agora, você pode configurar suas aplicações para usar o MailHog como servidor SMTP. No caso do SonarQube, por exemplo, você pode configurar o SMTP da seguinte forma:

yaml
Copiar
Editar
smtp:
  enabled: true
  server: "mailhog"  # Nome do serviço MailHog no Kubernetes
  port: 1025         # Porta do MailHog SMTP
  sender: "sonarqube@example.com"
  from: "sonarqube@example.com"
  tls: false
Agora, qualquer e-mail enviado pelo SonarQube ou outras aplicações será capturado pelo MailHog.