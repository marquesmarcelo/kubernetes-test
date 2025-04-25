FROM node:23-alpine

RUN npm install express

WORKDIR /app

# Copiar o arquivo Chart.yaml para dentro da imagem, em algum lugar que ele possa ser acessado pela interface web
# Isso deve ajudar a saber quando atualizou a versão
RUN mkdir -p /app/info
COPY ./infra/charts/app/Chart.yaml /app/info/Chart.yaml

# Copiar apenas o código da aplicação para o diretório app
COPY ./src /app

CMD ["node", "/app/index.js"]