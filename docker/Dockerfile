FROM node:14 as builder
LABEL description="nginx"

WORKDIR /aergoscan_frontend

COPY ./aergoscan_v2_frontend/package* ./
RUN yarn

ARG AERGO_NODE="http://local-api-http.aergo.io"
ARG API_URL="http://api2-local.aergoscan.io/v2"

COPY ./aergoscan_v2_frontend .

RUN yarn build


FROM nginx:latest
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /aergoscan_frontend/build /usr/share/nginx/html
