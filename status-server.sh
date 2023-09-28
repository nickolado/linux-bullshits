#!/bin/bash
# status-server.sh
# Este script mostra informações sobre o servidor

echo "Hostname: $(hostname)"
echo "Data atual: $(date)"
echo "Versão atual do kernel e arquitetura da CPU: $(uname -rp)"


echo "Uso de CPU:"
sar -u 1 1 | grep -v "Linux"
echo ""
echo "Uso de RAM:"
sar -r 1 1 | grep -v "Linux"
echo "Uso de SWAP:"
sar -S 1 1 | grep -v "Linux"
echo ""
echo "Atual I/O do Disco:"
sar -d 1 1 | grep -E "(DEV|sd|vd)" | grep -v "Linux"
echo ""
echo "Uso atual da largura de banda:"
sar -n DEV 1 1 | grep -v lo  | grep -v "Linux"
echo ""
