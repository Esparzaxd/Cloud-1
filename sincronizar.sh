#!/bin/bash
# sincronizar.sh - Sube la Agenda a las 3 VMs de Nginx

ORIGEN="."
KEYS="/c/Users/espar/Desktop/2026 Agos-Dic/NUBE/keys"
DESTINO="/var/www/html/agenda"

SERVIDORES=(
  "129.80.117.82 nginx01.key"
  "129.80.132.52 nginx02.key"
  "129.80.66.194 nginx03.key"
)

for s in "${SERVIDORES[@]}"; do
  read -r IP LLAVE <<< "$s"
  echo "==> Sincronizando $IP"
  tar -czf - --exclude=.git --exclude=sincronizar.sh --exclude=database \
      --exclude=README.md --exclude=.gitignore -C "$ORIGEN" . | \
    ssh -i "$KEYS/$LLAVE" -o StrictHostKeyChecking=accept-new ubuntu@"$IP" \
    "sudo rm -rf $DESTINO && sudo mkdir -p $DESTINO && sudo tar -xzf - -C $DESTINO && sudo chown -R www-data:www-data $DESTINO"
  if [ $? -eq 0 ]; then echo "    OK"; else echo "    ERROR en $IP"; fi
done
