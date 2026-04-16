FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM nginx:stable-alpine

EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
