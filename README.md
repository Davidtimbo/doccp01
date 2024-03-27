# Script em Shell de Backup automático de Imagens via FTP e Crontab

### Objetivo
- Este script Bash foi desenvolvido para automatizar o backup de imagens de um servidor remoto usando o protocolo FTP e Crontab.
- Script feito com intuíto de fazer backup todo dia de seg á sex (usando crontab) ás 12:20h (horário de almoço) e 18:20h (fim do expediente). Esse agendamento visa evitar conflitos com imagens enviadas por usuários durante a execução do script.

### Detalhes do Script
- O script acessa o servidor remoto usando o lftp e verifica a quantidade de imagens disponíveis.
- Se houver mais de uma imagem, ele realiza o download e remove as imagens do servidor.
- Mensagens de sucesso ou falha são registradas no arquivo *executado.txt* e mandadas por *email*.
- Relatórios por e-mail são enviados para $EMAIL1.

<br></br>


### Requisitos
- [lftp](https://lftp.yar.ru/)
- [sendEmail](https://github.com/mogaal/sendemail)
- [Solução para upload de arquivo utilizando lftp](https://pt.stackoverflow.com/questions/193024/como-fazer-um-upload-de-arquivo-utilizando-lftp)
 
<br></br>

 ### Configuração

1. **Diretório de Backup:**
   - O script realiza o backup do diretório `/opt/backup/doccp01`. Certifique-se de que o diretório exista e tenha as permissões corretas.

2. **Servidor FTP:**
   - O script utiliza o comando `lftp` para interagir com um servidor FTP. Verifique se o servidor FTP está acessível e as credenciais configuradas no script.

3. **Configuração do E-mail:**
   - Substitua a variável `EMAIL1` pelo endereço de e-mail para receber as notificações.

4. **Configuração do servidor de e-mail:**
   - As configurações do servidor de e-mail (SMTP) estão definidas para para um IP específico. Substitua conforme necessário.
     
 <br></br>

### Certifique-se de ter as dependências instaladas.
   ```bash
sudo apt-get install lftp
   ```
   ```bash
sudo apt-get install sendemail
   ```
<br></br>
### Edite o script para configurar as variáveis conforme necessário. 
 ex:
- CD_PATH="/opt/backup/doccp01"
- SERVER="1.0.0.1"
- REMOTE_PATH="/crase02/doccp01/doccp01dia"
- EMAIL1="mellod98@gmail.com"

<br></br>

### Certifique-se de ter as permissões necessárias.

```bash
chmod 777 seu_scrit.sh
   ```

### Execução (na mão) ou usar com *crontab*
```bash
/.seu_script.sh
   ```
### Configuração do Crontab
- Este script pode ser agendado para execução automática usando o Crontab. Aqui estão alguns exemplos de como você pode configurar o Crontab para executar o script em horários específicos.
- Para agendar a execução do script todos os dias, de segunda a sexta-feira, às 12:20h e 18:20h, você pode adicionar as seguintes linhas ao seu arquivo `/etc/crontab`:
```bash
20 12,18 * * 1-5 root /home/crase/cpdoccp01.sh #Exemplo do meu
30 12,18 * * 1-5 root /caminho/do/seu_outro_script.sh
```
Substitua o `caminho/do/seu_script.sh` pelo caminho real do seu script.

