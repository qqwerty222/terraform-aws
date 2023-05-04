#cloud-config
packages: 
  - nginx

runcmd:
  - export DD_API_KEY="${ dd_api_key }"
  - export DD_HOST_TAGS="${ dd_host_tags }"
  - export DD_SITE="datadoghq.eu"
  - bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
  - mv /run/tmp/nginx.conf /etc/nginx/nginx.conf
  - mv /run/tmp/status.conf /etc/nginx/conf.d/status.conf
  - systemctl restart nginx
  - chmod 0644 /var/log/nginx/*
  - mv /run/tmp/datadog_nginx.conf.yaml /etc/datadog-agent/conf.d/nginx.d/conf.yaml
  - "sed -i -e 's/# logs_enabled: false/logs_enabled: true/g' /etc/datadog-agent/datadog.yaml"
  - systemctl restart datadog-agent

write_files: 
  - path: /run/tmp/nginx.conf
    owner: root:root
    permissions: "0644"
    content: |
      events {
              worker_connections 1024;
      }
      http {
              log_format upstream     '[$time_local] $remote_addr $upstream_addr '
                                      '"$request" $status $body_bytes_sent '
                                      '"$http_user_agent"';
              server {
                      listen      80;

                      server_name localhost;

                      access_log /var/log/nginx/access.log upstream;
                      error_log  /var/log/nginx/error.log;

                      location /test {
                              return 200;
                      }
              }
              include conf.d/status.conf;
      }

  - path: /run/tmp/status.conf
    owner: root:root
    permissions: "0644"
    content: |
      server {
              listen 81;
              server_name localhost;

              access_log off;
              allow 127.0.0.1;
              deny all;

              location /nginx_status {
              # Choose your status module

              # freely available with open source NGINX
              stub_status;

              server_tokens on;
              }
      }

  - path: /run/tmp/datadog_nginx.conf.yaml
    owner: root:root
    permissions: "0644"
    content: |
      init_config:

      instances:

        - nginx_status_url: http://localhost:81/nginx_status/

          only_query_enabled_endpoints: true
          disable_generic_tags: true

      logs:
        - type: file
          path: /var/log/nginx/access.log
          service: proxy
          source: nginx

        - type: file
          path: /var/log/nginx/error.log
          service: proxy
          source: nginx








