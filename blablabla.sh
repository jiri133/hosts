#!/bin/bash

# Citim fiecare linie din /etc/hosts
while read -r line; do
    ip=$(echo "$line" | awk '{print $1}')
    
    # Verificăm dacă este o adresă IP validă
    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        echo "Adresă IP validă: $ip"
    else
        echo "Adresă IP invalidă: $ip"
    fi
done < /etc/hosts
