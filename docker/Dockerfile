FROM node:14 as builder
LABEL description="nginx"

WORKDIR /aergoscan_frontend

COPY ./aergoscan_v2_frontend/package* ./
RUN yarn

ARG ARG_AERGO_NODE_HOST="http://local-api-http.aergo.io"
ARG ARG_API_URL="http://api2-local.aergoscan.io/v2"
ENV AERGO_NODE ${ARG_AERGO_NODE_HOST}
ENV API_URL ${ARG_API_URL}

COPY ./aergoscan_v2_frontend .

RUN AERGO_NODE=${AERGO_NODE} API_URL=${API_URL} yarn build


FROM nginx:latest
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /aergoscan_frontend/build /usr/share/nginx/html