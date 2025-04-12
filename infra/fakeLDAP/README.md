3. Criar a Imagem Docker do FakeLDAP
Com o Dockerfile pronto, você pode construir a imagem Docker e fazer o push para um repositório como o Docker Hub. Aqui estão os comandos:

Construa a imagem:

bash
Copiar
Editar
docker build -t seu-usuario/fakedldap:latest .
Faça o login no Docker Hub:

bash
Copiar
Editar
docker login
Faça o push da imagem para o Docker Hub:

bash
Copiar
Editar
docker push seu-usuario/fakedldap:latest
4. Aplicar no Kubernetes
Agora que a imagem Docker do FakeLDAP está no Docker Hub, você pode aplicar o deployment no seu cluster Kubernetes.

Aplique o arquivo de deployment:

bash
Copiar
Editar
kubectl apply -f fakedldap-deployment.yaml
Verifique se o deployment foi bem-sucedido:

bash
Copiar
Editar
kubectl get pods
Isso deve criar o contêiner com o FakeLDAP rodando no seu cluster Kubernetes.

5. Acessando o FakeLDAP
Para testar a integração com o FakeLDAP, você pode fazer um port-forward para a porta 1389, que é a porta LDAP exposta pelo FakeLDAP:

bash
Copiar
Editar
kubectl port-forward svc/fakedldap 1389:1389
Isso permitirá que você acesse o servidor LDAP no seu localhost na porta 1389.

6. Testar o LDAP com o FakeLDAP
Com o port-forward configurado, você pode testar a conexão LDAP com o comando ldapsearch:

bash
Copiar
Editar
ldapsearch -x -H ldap://localhost:1389 -b "dc=example,dc=com"
Esse comando vai realizar uma consulta no servidor LDAP FakeLDAP, que está simulando um ambiente LDAP para testes.

