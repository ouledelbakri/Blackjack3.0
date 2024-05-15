FROM node:latest

WORKDIR /app

COPY ./package.json ./vite.config.js ./blockchain /app/

RUN npm install

COPY . .

RUN npm install

EXPOSE 5173

CMD ["npm", "run", "dev"]
