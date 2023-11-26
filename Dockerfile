# Dockerfile
FROM node:14 as builder

WORKDIR /tic-tac-react

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2 - Production environment
FROM nginx:latest

# Копируем статические файлы React.js приложения в каталог Nginx
COPY --from=builder /tic-tac-react/build /usr/local/etc/nginx/servers/

# Копируем конфигурацию Nginx в контейнер
COPY nginx.conf /usr/local/etc/nginx/

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"]
