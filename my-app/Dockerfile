FROM node:23-alpine
WORKDIR /app

# Copiar o arquivo environment-info.txt para dentro da imagem, em algum lugar que ele possa ser acessado pela interface web
RUN mkdir -p /app/info
COPY environment-info.txt /app/info/environment-info.txt

COPY . /app
RUN npm install express
CMD ["node", "/app/index.js"]