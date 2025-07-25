# FROM openresty/openresty:1.21.4.2-alpine as builder
# FROM openresty/openresty:1.27.1.2-alpine as builder
FROM bailangvvking/openresty:latest as builder
USER root
RUN mkdir /app
WORKDIR /app

ADD stats.lua    /app
ADD protect.lua  /app
ADD record.lua   /app

# RUN /usr/local/openresty/luajit/bin/luajit -b /app/stats.lua   /app/stats.ljbc
# RUN /usr/local/openresty/luajit/bin/luajit -b /app/protect.lua /app/protect.ljbc
# RUN /usr/local/openresty/luajit/bin/luajit -b /app/record.lua  /app/record.ljbc

# 不用编译了 他本来运行时候就会自动编译成自己嘛 并且缓存
# RUN /usr/local/luajit/bin/luajit -b /app/stats.lua   /app/stats.ljbc
# RUN /usr/local/luajit/bin/luajit -b /app/protect.lua /app/protect.ljbc
# RUN /usr/local/luajit/bin/luajit -b /app/record.lua  /app/record.ljbc

# FROM --platform=linux/amd64 openresty/openresty:1.21.4.2-alpine
# FROM openresty/openresty:1.21.4.2-alpine
FROM bailangvvking/openresty:latest
EXPOSE 80 443 3000

USER root
RUN mkdir /app
WORKDIR /app
RUN apk add --no-cache tzdata
ENV TZ Asia/Shanghai
# 同样 也不需要拷过去了
# COPY --from=builder /app/stats.ljbc   /app/
# COPY --from=builder /app/protect.ljbc /app/
# COPY --from=builder /app/record.ljbc  /app/
ADD stats.lua       /app/stats.lua
ADD protect.lua     /app/protect.lua
ADD record.lua      /app/record.lua
ADD cert.key        /app/cert.key
ADD cert.crt        /app/cert.crt
ADD env.conf        /app/env.conf
ADD nginx.conf      /app/nginx.conf

# 更改文件权限给 nobody
RUN chown -R nobody:nobody /app

# 切换到非 root 用户
USER nobody

CMD ["openresty", "-c", "/app/nginx.conf"]
