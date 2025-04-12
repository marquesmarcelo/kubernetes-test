FROM python:3.9-slim

# Instala o FakeLDAP
RUN pip install FakeLDAP

# Copia o arquivo LDIF com usuários e grupos para o contêiner
COPY add-user-group.ldif /tmp/add-user-group.ldif

# Expõe a porta 1389 (padrão do FakeLDAP)
EXPOSE 1389

# Comando para rodar o FakeLDAP e adicionar o LDIF
CMD fakedldap -H ldap://0.0.0.0:1389 -b "dc=example,dc=com" && ldapadd -x -D "cn=admin,dc=example,dc=com" -w adminpassword -f /tmp/add-user-group.ldif && tail -f /dev/null
