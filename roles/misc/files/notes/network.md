# network

## tools

1. netstat

Command                             | action
------------------------------------|-------------------------
netstat -ant                        | show all TCP connections with no DNS resolution
netstat -i                          | Displays a table of all network interfaces
netstat -aop | grep <pid>           | display all ports open by a process with id pid
netstat -anlp | grep <app_name>     | display all ports open by a process with id pid

2. ss

https://azurplus.fr/comment-utiliser-la-commande-ss-sous-linux/

3. /proc/net/

This directory provides a comprehensive look at various networking parameters and statistics. Each directory and virtual file within this directory describes aspects of the system's network configuration.

4. nmap

Nmap (Network Mapper) is a network scanner. Nmap is used to discover hosts and services on a computer network by sending packets and analyzing the responses.

```
hard_nmap(){
    sudo nmap -v -A -T4 -Pn -p- $1
}
soft_nmap(){
    sudo nmap -v -sS -sU $1
```

