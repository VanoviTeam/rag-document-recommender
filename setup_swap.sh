#!/bin/bash
# Script para configurar 8GB de Swap en Ubuntu (OCI Ampere A1)
# Requiere permisos de root (sudo)

if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script con sudo:"
  echo "sudo ./setup_swap.sh"
  exit
fi

echo "Configurando 8GB de archivo Swap..."

# Crear el archivo si no existe
if grep -q "swapfile" /etc/fstab; then
    echo "¡El swap ya está configurado en /etc/fstab!"
else
    # Fallocate a veces da problemas en ciertos sistemas de archivos de OCI, dd es más seguro aunque más lento.
    # fallocate -l 8G /swapfile
    dd if=/dev/zero of=/swapfile bs=1M count=8192 status=progress
    
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile

    # Hacerlo persistente tras reiniciar
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
    
    # Ajustar vm.swappiness
    echo "vm.swappiness=10" >> /etc/sysctl.conf
    sysctl -p
    
    echo "Swap configurado correctamente."
fi

echo "Memoria actual:"
free -h
