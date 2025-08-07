#!/bin/bash

# DNS-Server IP und Hostname
DNS_IP="192.168.X.XX" # hier deine wunsch ip eintragen 
HOSTNAME="dns1"

# System vorbereiten
sudo hostnamectl set-hostname "$HOSTNAME"
sudo apt update && sudo apt upgrade -y

# SSH absichern
sudo sed -i 's/^#PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Technitium DNS installieren
curl -sSL https://download.technitium.com/dns/install.sh | sudo bash #technitium laden und installieren 

# IP statisch setzen (optional – oder via dhcpcd.conf manuell)
echo -e "\ninterface eth0\nstatic ip_address=${DNS_IP}/24\nstatic routers=192.168.1.1\nstatic domain_name_servers=192.168.1.1" | sudo tee -a /etc/dhcpcd.conf # hier die ip des routers/dhcp oder dhcp des vlans eintragen

# Reboot vorbereiten
echo -e "\n✅ Installation abgeschlossen. Starte mit 'sudo reboot' neu."
