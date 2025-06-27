# DK8sDDosFirewall
Protect your service from CC attacks, UDP attacks, and traffic flooding attacks.

[DK8s DDos Firewall Code Repository](https://github.com/yinyue123/DK8sDDosFirewall)

[DK8s DDos Firewall Docker Image](https://hub.docker.com/r/yinyue123/ddos-firewal)

`For more information, please visit `[https://www.dk8s.com](https://www.dk8s.com)

## 快速启动

```bash
mkdir -p /data/dk8sfirewall
docker run -d \
  --name dk8s-ddos-fw \
  --network host \
  -v /data/dk8sfirewall/nginx.conf:/app/nginx.conf:ro \
  -v /data/dk8sfirewall/env.conf:/app/env.conf:ro \
  -v /data/dk8sfirewall/cert.pem:/app/cert.pem:ro \
  -v /data/dk8sfirewall/cert.key:/app/cert.key:ro \
  bailangvvking/dk8sddosfirewall:latest
