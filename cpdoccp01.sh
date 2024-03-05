#!/bin/bash

cd /opt/backup/doccp01
#cd /home/crase/testeBAIXAR

# Captura a quantidade de imagens
num_images=$(lftp -c "
open 1.0.0.1
cd /crase02/doccp01/doccp01dia
ls *.jpg | wc -l
")

# Remove espaços em branco e quebras de linha da variável
num_images=$(echo "$num_images" | tr -d '[:space:]')

# Configuração do e-mail
EMAIL1="mellod98@gmail.com"

# Realiza o download apenas se a quantidade de imagens for maior que 1
if [ "$num_images" -gt 1 ]; then
  lftp -c "
  open 1.0.0.1
  cd /crase02/doccp01/doccp01dia
  mget *.jpg
  mrm *.jpg
  bye
  "
  # Mensagens para email e executado.txt
  success_message="
Script rodado com sucesso no doccp01! \n-$(date '+%a %d %b %H:%M:%S')- \nTotal de imagens: $num_images"
  echo "$success_message" >> /home/crase/executado.txt

  # Envia e-mail de sucesso
  echo -e "$success_message" | sendEmail -o tls=no -f naoresponda@crasemail.com.br -t "$EMAIL1" -u "Relatório - Crontab rodado" -m "$success_message" -s 172.16.0.4

else
  failure_message="Falha no script doccp01. -$(date '+%a %d %b %H:%M:%S')-"
  echo "$failure_message" >> /home/crase/executado.txt

  # Envia e-mail de falha
  echo "$failure_message" | sendEmail -o tls=no -f naoresponda@crasemail.com.br -t "$EMAIL1" -u "Relatório - Crontab rodado" -m "$failure_message" -s 172.16.0.4
fi
