#cloud-config
packages: 
  - mysql-server

runcmd:
  - export DD_API_KEY="${ dd_api_key }"
  - export DD_HOST_TAGS="${ dd_host_tags }"
  - export DD_SITE="datadoghq.eu"
  - bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
  - mysql < /run/tmp/mysql_init.sql
  - cat /run/tmp/mysql_my.cnf >> /etc/mysql/my.cnf
  - systemctl restart mysql
  - chmod o+rx /var/log/mysql
  - chmod 0644 /var/log/mysql/*
  - mv /run/tmp/datadog_mysql.conf.yaml /etc/datadog-agent/conf.d/mysql.d/conf.yaml
  - "sed -i -e 's/# logs_enabled: false/logs_enabled: true/g' /etc/datadog-agent/datadog.yaml"
  - systemctl restart datadog-agent

write_files: 
  - path: /run/tmp/mysql_init.sql
    owner: root:root
    permissions: "0644"
    content: |
      CREATE USER 'datadog'@'localhost' IDENTIFIED BY 'dd-password';
      GRANT REPLICATION CLIENT ON *.* TO 'datadog'@'localhost';
      ALTER USER 'datadog'@'localhost' WITH MAX_USER_CONNECTIONS 5;
      GRANT PROCESS ON *.* TO 'datadog'@'localhost';
      GRANT SELECT ON performance_schema.* TO 'datadog'@'localhost';
  
  - path: /run/tmp/mysql_my.cnf
    owner: root:root
    permissions: "0644"
    content: |
      [mysqld_safe]
      log_error = /var/log/mysql/mysql_error.log

      [mysqld]
      general_log = on
      general_log_file = /var/log/mysql/mysql.log
      log_error = /var/log/mysql/mysql_error.log
      slow_query_log = on
      slow_query_log_file = /var/log/mysql/mysql_slow.log
      long_query_time = 2

  - path: /run/tmp/datadog_mysql.conf.yaml
    owner: root:root
    permissions: "0644"
    content: |
      init_config:

      instances:
        - host: 127.0.0.1
          username: datadog
          password: "dd-password"
          port: 3306
          options:
            replication: false
            galera_cluster: true
            extra_status_metrics: true
            extra_innodb_metrics: true
            extra_performance_metrics: false
            schema_size_metrics: false
            disable_innodb_metrics: false

      logs:
        - type: file
          path: "/var/log/mysql/mysql_error.log"
          source: mysql
          service: "db"

        - type: file
          path: "/var/log/mysql/mysql_slow.log"
          source: mysql
          service: "db"
          log_processing_rules:
            - type: multi_line
              name: new_slow_query_log_entry
              pattern: "# Time:"

        - type: file
          path: "/var/log/mysql/mysql.log"
          source: mysql
          service: "db"
          log_processing_rules:
            - type: multi_line
              name: new_log_start_with_date
              pattern: \d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])


    


