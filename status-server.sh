#!/bin/bash
# status-server.sh
# Este script mostra informações sobre o servidor

echo "Hostname: $(hostname)"
echo "Data atual: $(date)"
echo "Versão atual do kernel e arquitetura da CPU: $(uname -rp)"


echo "Uso de CPU:"
sar -u l l | grep -v "Linux"
echo ""
echo "Uso de RAM:"
sar -r l l | grep -v "Linux"
echo "Uso de SWAP:"
sar -S l l | grep -v "Linux"
echo ""
echo "Atual I/O do Disco:"
sar -d l l | grep -E "(DEV|sd|vd)" | grep -v "Linux"
echo ""
echo "Uso atual da largura de banda:"
sar -n DEV l l | grep -v lo  | grep -v "Linux"
echo ""

