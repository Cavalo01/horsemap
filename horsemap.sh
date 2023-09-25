pkg install nmap && pkg install curl && pkg install ncftp && pkg install lynx &&

banner='
╭╮╱╭┳━━━┳━━━┳━━━┳━━━┳━╮╭━┳━━━┳━━━╮
┃┃╱┃┃╭━╮┃╭━╮┃╭━╮┃╭━━┫┃╰╯┃┃╭━╮┃╭━╮┃
┃╰━╯┃╃┃┃┃╰━╯┃╰━━┫╰━━┫╭╮╭╮┃┃╃┃┃╰━╯┃
┃╭━╮┃╃┃┃┃╭╮╮┻━━╮┃╭━━┫┃┃┃┃┃┃╃┃┃╭━━╯
┃┃╱┃┃╰━╯┃╃┃╰┫╰━╯┃╰━━┫┃┃┃┃┃╃┃┃┃
╰╯╱╰┻━━━┻╯╰━┻━━━┻━━━┻╯╰╯╰┻╯╱╰┻╯
'

echo "$banner"
read -p "DIGITE O ALVO: " site

if [ -z "$site" ]; then
    echo "Alvo não especificado. Saindo..."
    exit 1
fi

echo "ESCANEANDO... LEMBRE-SE DE SEGUIR LEIS E SER ÉTICO. (O processo pode demorar muito dependendo do site.)"

output_file="HsReply.txt"

echo "Portas abertas e fechadas:" > "$output_file"
nmap -p- "$site" >> "$output_file"

echo "Código fonte:" >> "$output_file"
curl -s "$site" >> "$output_file"

echo "Informações detalhadas:" >> "$output_file"
nmap -A "$site" >> "$output_file"

echo "Informações do alvo:" >> "$output_file"
nmap -p- -A "$site" >> "$output_file"

echo "Sistema Operacional Do Alvo:" >> "$output_file"
nmap -O "$site" >> "$output_file"

echo "Informações da varredura rápida:" >> "$output_file"
nmap -F "$site" >> "$output_file"

echo "Informações da varredura reversa de DNS:" >> "$output_file"
nmap -R "$site" >> "$output_file"

echo "Versão de serviços do alvo:" >> "$output_file"
nmap -sV "$site" >> "$output_file"

echo "Vulnerabilidades e configurações em serviços do alvo:" >> "$output_file"
nmap -sC "$site" >> "$output_file"

# Verificar o servidor FTP
echo "Servidor FTP:" >> "$output_file"
ftp_prefixes=("ftp." "ftp1." "ftp2." "ftp3." "ftp4." "ftp5." "ftp6." "ftp7." "ftp8." "ftp9." "ftpserver." "ftpupload." "ftpuser." "ftpadmin." "ftpsecure." "myftp." "secureftp." "sftp." "publicftp." "proftp." "files." "upload." "downloads." "data." "ftpdata." "webftp." "userftp." "privateftp." "sharedftp." "anonymousftp." "testftp." "devftp." "ftps." "pureftp." "classicftp." "freeftp." "quickftp." "easyftp." "coolftp." "superftp." "bestftp." "fastftp." "favoriteftp." "perfectftp." "specialftp." "newftp." "topftp." "quickconnect." "standardftp." "ultimateftp.")
ftp_server_found="No"  # Inicialize como "Não"

for prefix in "${ftp_prefixes[@]}"; do
    ftp_url="${prefix}${site}"
    if nc -z -v -w 5 "$ftp_url" 21; then
        echo "$ftp_url" >> "$output_file"
        ftp_server_found="Yes"  # Indica que o servidor FTP foi encontrado
        break
    fi
done

if [ "$ftp_server_found" == "No" ]; then
    echo "Nenhum Servidor FTP Encontrado." >> "$output_file"
fi

# Listar diretórios e arquivos
echo "Diretórios e arquivos encontrados:" >> "$output_file"
lynx -listonly -dump "$site" >> "$output_file"

# Verificar se o site está funcionando com Nmap
echo "Verificando se o site está funcionando com Nmap..." >> "$output_file"
if nmap -p 80,443 "$site" | grep -E "80/tcp|443/tcp" > /dev/null; then
    echo "Site Está Funcionando: Sim" >> "$output_file"
else
    echo "Site Está Funcionando: Não" >> "$output_file"
fi

echo "Website consultado com sucesso! Os resultados foram salvos em $output_file."
