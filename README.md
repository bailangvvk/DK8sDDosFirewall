# DK8sDDosFirewall
Protect your service from CC attacks, UDP attacks, and traffic flooding attacks.

[DK8s DDos Firewall Code Repository](https://github.com/yinyue123/DK8sDDosFirewall)

[DK8s DDos Firewall Docker Image](https://hub.docker.com/r/yinyue123/ddos-firewal)

`For more information, please visit `[https://www.dk8s.com](https://www.dk8s.com)

## 快速启动

```bash
DIR=/data/dk8sfirewall
GH=https://gitee.com/azhaoyang_admin/DK8sDDosFirewall/raw/main

mkdir -p "$DIR"

for f in nginx.conf env.conf cert.pem cert.key; do
  curl -L --retry 3 -o "$DIR/$f" "$GH/$f"
done

docker run -d \
--name dk8s-ddos-fw \
--network host \
--cap-add=NET_ADMIN \
--cap-add=NET_RAW \
--cap-add=SYS_ADMIN \
-v "$DIR/nginx.conf:/app/nginx.conf:ro" \
-v "$DIR/env.conf:/app/env.conf:ro" \
-v "$DIR/cert.pem:/app/cert.pem:ro" \
-v "$DIR/cert.key:/app/cert.key:ro" \
bailangvvking/dk8sddosfirewall:latest
