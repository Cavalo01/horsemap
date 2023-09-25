pkg install nmap && pkg install curl &&

banner = 
╭╮╱╭┳━━━┳━━━┳━━━┳━━━┳━╮╭━┳━━━┳━━━╮
┃┃╱┃┃╭━╮┃╭━╮┃╭━╮┃╭━━┫┃╰╯┃┃╭━╮┃╭━╮┃
┃╰━╯┃┃╱┃┃╰━╯┃╰━━┫╰━━┫╭╮╭╮┃┃╱┃┃╰━╯┃
┃╭━╮┃┃╱┃┃╭╮╭┻━━╮┃╭━━┫┃┃┃┃┃╰━╯┃╭━━╯
┃┃╱┃┃╰━╯┃┃┃╰┫╰━╯┃╰━━┫┃┃┃┃┃╭━╮┃┃
╰╯╱╰┻━━━┻╯╰━┻━━━┻━━━┻╯╰╯╰┻╯╱╰┻╯

echo "$banner"
read -p "DIGITE O ALVO: " site

echo "ESCANEANDO... LEMBRE-SE DE SEGUIR LEIS E SER ÉTICO."

echo "Portas abertas e fechadas:" >> HsReply.txt
nmap -p- $site > HsReply.txt 2>&1

echo "Código fonte:"
curl -s $site >> HsReply.txt

echo "Outras Informações:"
curl -O $site >> HsReply.txt

echo "Informações detalhadas:" >> HsReply.txt
curl -I $site >> HsReply.txt

echo "Website consultado com sucesso! Os resultados foram salvos em HsReply.txt."
echo "Digite nano HsReply.txt para ver os resultados e rm HsReply.txt para esvaziar."
