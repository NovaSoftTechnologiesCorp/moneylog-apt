#!/bin/sh
# Agrega el repositorio de MoneyLog a apt (Ubuntu 22.04+ y Debian 12+).
# Después: sudo apt install moneylog. Las actualizaciones llegan con apt upgrade.
set -e
URL=https://novasofttechnologiescorp.github.io/moneylog-apt
[ "$(id -u)" = 0 ] || { echo "Corre este instalador con sudo." >&2; exit 1; }
install -d -m 0755 /etc/apt/keyrings
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL/moneylog.gpg" -o /etc/apt/keyrings/moneylog.gpg
else
  wget -qO /etc/apt/keyrings/moneylog.gpg "$URL/moneylog.gpg"
fi
chmod 0644 /etc/apt/keyrings/moneylog.gpg
cat > /etc/apt/sources.list.d/moneylog.sources <<SRC
Types: deb
URIs: $URL
Suites: stable
Components: main
Architectures: amd64
Signed-By: /etc/apt/keyrings/moneylog.gpg
SRC
apt-get update -o Dir::Etc::sourcelist=sources.list.d/moneylog.sources -o Dir::Etc::sourceparts=- -o APT::Get::List-Cleanup=0 >/dev/null
echo "Listo. Ahora: sudo apt install moneylog"
