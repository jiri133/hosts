#!/bin/bash

# Funcție care verifică adresa IP și asocierea cu un server DNS
verifica_ip() {
    local hostname=$1
    local ip=$2
    local dns_server=$3
    
    # Verificăm formatul IP
    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        # Verificăm asocierea cu DNS
        nslookup $hostname $dns_server | grep -q "$ip"
        if [ $? -eq 0 ]; then
            echo "Asocierea pentru $hostname ($ip) este validă pe $dns_server"
        else
            echo "Asocierea pentru $hostname ($ip) este invalidă pe $dns_server"
        fi
    else
        echo "Adresă IP invalidă: $ip"
    fi
}

# Citim și verificăm fiecare linie din /etc/hosts
while read -r line; do
    hostname=$(echo "$line" | awk '{print $2}')
    ip=$(echo "$line" | awk '{print $1}')
    verifica_ip $hostname $ip 8.8.8.8 # Folosim 8.8.8.8 ca server DNS
done < /etc/hosts
