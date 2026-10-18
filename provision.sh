#!/bin/bash
apt update
apt install -y apache2
systemctl enable apache2
systemctl start apache2
echo "Nombre: Cristhian Carvajal Barragán, Hostname: debian-cristhian" > /var/www/html/index.html