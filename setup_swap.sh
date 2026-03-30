#!/bin/bash
# Script to configure 8GB of Swap in Ubuntu (OCI Ampere A1)
# Requires root privileges (sudo)

if [ "$EUID" -ne 0 ]; then
  echo "Please, run this script with sudo:"
  echo "sudo ./setup_swap.sh"
  exit
fi

echo "Configuring 8GB of Swap file..."

# Create the file if it doesn't exist
if grep -q "swapfile" /etc/fstab; then
    echo "Swap is already configured in /etc/fstab!"
else
    # Fallocate sometimes causes issues on certain OCI filesystems, dd is safer although slower.
    # fallocate -l 8G /swapfile
    dd if=/dev/zero of=/swapfile bs=1M count=8192 status=progress
    
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile

    # Make it persistent after reboot
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
    
    # Adjust vm.swappiness
    echo "vm.swappiness=10" >> /etc/sysctl.conf
    sysctl -p
    
    echo "Swap successfully configured."
fi

echo "Current memory:"
free -h
