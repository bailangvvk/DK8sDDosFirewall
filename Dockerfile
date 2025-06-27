FROM openresty/openresty:1.21.4.2-alpine as builder
# FROM openresty/openresty:1.27.1.2-alpine as builder
RUN mkdir /app
WORKDIR /app

ADD stats.lua    /app
ADD protect.lua  /app
ADD record.lua   /app

RUN /usr/local/openresty/luajit/bin/luajit -b /app/stats.lua   /app/stats.ljbc
RUN /usr/local/openresty/luajit/bin/luajit -b /app/protect.lua /app/protect.ljbc
RUN /usr/local/openresty/luajit/bin/luajit -b /app/record.lua  /app/record.ljbc

# FROM --platform=linux/amd64 openresty/openresty:1.21.4.2-alpine
FROM openresty/openresty:1.21.4.2-alpine
EXPOSE 180 1443 13000

RUN mkdir /app
WORKDIR /app
RUN apk add --no-cache tzdata
ENV TZ Asia/Shanghai
COPY --from=builder /app/stats.ljbc   /app/
COPY --from=builder /app/protect.ljbc /app/
COPY --from=builder /app/record.ljbc  /app/
ADD stats.lua       /app/stats.lua
ADD protect.lua     /app/protect.lua
ADD record.lua      /app/record.lua
ADD cert.key        /app/cert.key
ADD cert.pem        /app/cert.pem
ADD env.conf        /app/env.conf
ADD nginx.conf      /app/nginx.conf

CMD ["openresty", "-c", "/app/nginx.conf"]
