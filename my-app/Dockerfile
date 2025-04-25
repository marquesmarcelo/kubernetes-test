FROM node:23-alpine
WORKDIR /app

# Copiar o arquivo Chart.yaml para dentro da imagem, em algum lugar que ele possa ser acessado pela interface web
# Isso deve ajudar a saber quando atualizou a versão
RUN mkdir -p /app/info
COPY info/Chart.yaml /app/info/Chart.yaml

COPY . /app
RUN npm install express
CMD ["node", "/app/index.js"]