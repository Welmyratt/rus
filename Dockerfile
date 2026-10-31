worker_processes auto;
error_log /dev/stderr warn;
pid /tmp/nginx.pid;

events {
    worker_connections 4096;
}

http {
    access_log off;
    client_max_body_size 0;

    map $http_upgrade $connection_upgrade {
        default upgrade;
        ''      close;
    }

    server {
        listen 8080;

        location / {
            proxy_pass http://185.12.126.154:80;
            proxy_http_version 1.1;

            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection $connection_upgrade;
            proxy_set_header Host $host;

            proxy_buffering off;
            proxy_request_buffering off;
            proxy_connect_timeout 10s;
            proxy_read_timeout 3600s;
            proxy_send_timeout 3600s;
        }
    }
}
