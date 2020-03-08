echo "api.ririiy.com {
 gzip
 tls tabuxiangma@gmail.com
 proxy / 107.182.21.208:10086 {
    websocket
    header_upstream Host {host}
    header_upstream X-Real-IP {remote}
    header_upstream X-Forwarded-For {remote}
    header_upstream X-Forwarded-Port {server_port}
    header_upstream X-Forwarded-Proto {scheme}
  }
}
dy.ririiy.com {
 gzip
 tls tabuxiangma@gmail.com
 proxy / 107.182.21.208:10010 {
    websocket
    header_upstream Host {host}
    header_upstream X-Real-IP {remote}
    header_upstream X-Forwarded-For {remote}
    header_upstream X-Forwarded-Port {server_port}
    header_upstream X-Forwarded-Proto {scheme}
  }
}" > /usr/local/caddy/Caddyfile