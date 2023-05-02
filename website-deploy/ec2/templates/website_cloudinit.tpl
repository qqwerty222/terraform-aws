#cloud-config

runcmd:
  - export DD_API_KEY="${ dd_api_key }"
  - export DD_HOST_TAGS="${ dd_host_tags }"
  - export DD_SITE="datadoghq.eu"
  - bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

