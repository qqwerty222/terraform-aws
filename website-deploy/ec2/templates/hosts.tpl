[proxy]  
%{ for ip in proxy_ips ~}
${ip}
%{endfor ~}

[website]
%{ for ip in website_ips ~}
${ip}
%{endfor ~}
