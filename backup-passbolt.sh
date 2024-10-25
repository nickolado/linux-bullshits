#!/bin/bash

# Credenciais
CONTAINER_NOME="mariadb"
BANCO_NOME="passbolt"
USUARIO="root"
SENHA="test"
DATA_ATUAL=$(date +"%Y-%m-%d-%H.%M")
#CAMINHO_DUMP="/home/passbolt_db_backup.sql"
CAMINHO_LOCAL="/opt/passbolt/backups/passbolt_db_backup_"$DATA_ATUAL".sql"
DIRETORIO="/opt/passbolt/backups"

# Criando dump

echo "Iniciando dump do banco de dados no container" 
docker exec -it "${CONTAINER_NOME}" mysqldump -u "${USUARIO}" -p"${SENHA}" "${BANCO_NOME}" > "${CAMINHO_LOCAL}" 

# Verificando se o DUMP foi feito com sucesso

if [ $? -eq 0 ]; then
  echo "Dump gerado com sucesso na pasta "${DIRETORIO}""
else
  echo "Erro ao gerar o dump do banco de dados."
  exit 1
fi

# Transferindo dump 
#echo "Transferindo o dump para o caminho local"
#docker cp "${CONTAINER_NOME}:${CAMINHO_DUMP}" "${CAMINHO_LOCAL}"

# Remover arquivo do container após feito a cópia
# echo "Limpando arquivo do container"
# docker exec "${CONTAINER_NOME}" rm "${CAMINHO_LOCAL}"

# Comprimir o backup do banco de dados
gzip "${DIRETORIO}/passbolt_db_backup_"$DATA_ATUAL".sql"

# Excluir backups antigos 
find "${DIRETORIO}" -name "passbolt_db_backup_*.sql.gz" -type f -mtime +7 -exec rm {} \;

# Verificando
if [ $? -eq 0 ]; then
    echo "Excluindo arquivos com data superior a 7 dias de armazenamento"
else
    echo "Erro ao excluir arquivos, verificar script"
    exit 1
fi

chmod 777 * "${DIRETORIO}"

# Verificando
if [ $? -eq 0 ]; then
    echo "Permissões concedidas para o arquivo. Final do script"
else
    echo "Erro ao conceder as permissões"
    exit 1
fi

# essas configurações verificar depois
# os comandos que estou utilizando é de um script antigo que havia criado e salvo em um repositório remoto

#mv glpi_db_backup_*.sql.gz /home/dados/backup-glpi/db

# Transferir arquivos para servidor 141

#scp "${BANCO}/glpi_db_backup_${DATA}.sql.gz" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_BACKUP_DIR}"
#scp "${BANCO}/glpi_db_backup_${DATA}.sql.gz" "${REMOTE_USER2}@${REMOTE_HOST2}:${REMOTE_BACKUP_DIR2}"
#scp "${BANCO}/glpi_db_backup_${DATA}.sql.gz" "${REMOTE_USER3}@${REMOTE_HOST3}:${REMOTE_BACKUP_DIR3}"

#echo "Backup concluído com sucesso!"
