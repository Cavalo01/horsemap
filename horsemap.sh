pkg install nmap && pkg install curl &&

banner="
╭╮╱╭┳━━━┳━━━┳━━━┳━━━┳━╮╭━┳━━━┳━━━╮
┃┃╱┃┃╭━╮┃╭━╮┃╭━╮┃╭━━┫┃╰╯┃┃╭━╮┃╭━╮┃
┃╰━╯┃╃┃┃┃╰━╯┃╰━━┫╰━━┫╭╮╭╮┃┃╃┃┃╰━╯┃
┃╭━╮┃╃┃┃┃╭╮╮┻━━╮┃╭━━┫┃┃┃┃┃┃╃┃┃╭━━╯
┃┃╱┃┃╰━╯┃╃┃╰┫╰━╯┃╰━━┫┃┃┃┃┃╃┃┃┃
╰╯╱╰┻━━━┻╯╰━┻━━━┻━━━┻╯╰╯╰┻╯╱╰┻╯"

echo "$banner"
read -p "DIGITE O ALVO: " site

echo "ESCANEANDO... LEMBRE-SE DE SEGUIR LEIS E SER ÉTICO. (O processo pode demorar muito dependendo do site.)"

echo "Portas abertas e fechadas:" >> HsReply.txt
nmap -p- $site >> HsReply.txt 2>&1

echo "Código fonte:" >> HsReply.txt
curl -s $site >> HsReply.txt

echo "Informações detalhadas:" >> HsReply.txt
curl -I $site >> HsReply.txt

echo "Informações do alvo:" >> HsReply.txt
nmap -p- -A $site >> HsReply.txt 2>&1

echo "Sistema Operacional Do Alvo:" >> HsReply.txt
nmap -O $site >> HsReply.txt 2>&1

echo "Informações da varredura rápida:" >> HsReply.txt
nmap -F $site >> HsReply.txt 2>&1

echo "Informações da varredura reversa de DNS:" >> HsReply.txt
nmap -R $site >> HsReply.txt 2>&1

echo "Versão de serviços do alvo:" >> HsReply.txt
nmap -sV $site >> HsReply.txt 2>&1

echo "Vulnerabilidades e configurações em serviços do alvo:"
nmap -sC $site >> HsReply.txt 2>&1

echo "Website consultado com sucesso! Os resultados foram salvos em HsReply.txt."
echo "Digite nano HsReply.txt para ver os resultados e rm HsReply.txt para esvaziar."
