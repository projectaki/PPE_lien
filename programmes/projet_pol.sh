URL=$1
N=1

if [ $# -ne 1 ]
then
	echo "Ce script demande un argument"
	exit
else
	if [ -f "$URL" ]
	then 
		echo "Le fichier existe bien"
	else
		echo "Le fichier existe pas" 
		exit
	fi
fi

echo "<table>" 
echo "<html>
	<head>
		<meta charset= \"UTF-8\">
	</head>
	<body>"

echo "		<table>
		<tr><th>Numéro</th><th>URL</th><th>Code HTTP</th><th>Encodage</th><th>Aspiration</th><Dump</th><th>Nombre d'occurences</th><th>Contexte</th></tr>"
while read -r URL;
do
    response=$(curl -s -I -L -w "%{http_code}" -o "../aspirations/aspiration_pl${N}.html" $URL)
    CODE=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
    lynx -dump "$URL" > ./dumps-text/dump_pl${N}.html
    COMPTE=$(grep -o -i -w 'związ(ek|k(u|owi|iem|i|ów|om|ami|ach)' "./dumps-text/dump_pl${N}.html" | wc -l)
    CONTEXTES=$(grep -B 2 -A 2 -i -w 'związ(ek|k(u|owi|iem|i|ów|om|ami|ach)' "./dumps-text/dump_pl${N}.html" > "./contextes/contexte_pl${N}.txt")

    echo "<tr>
    <td>$N</td>
    <td>$URL</td>
    <td>$response</td>
    <td>$CODE</td>
    <td><a href='../aspirations/aspiration_pl${N}.html'>aspiration</a></td>
    <td><a href='../dumps-text/dump_pl${N}.html'>dump</a></td>
    <td>$COMPTE</td>
    <td><a href='../contextes/contexte_pl${N}.txt'>contexte</a></td>
    </tr>"

    echo "<tr>
    <td colspan='4'></td>
    <td><a href='../aspirations/aspiration_pl${N}.html'>Cliquez</a></td>
    <td><a href='../dumps-text/dump_pl${N}.html'>Cliquez</a></td>
    <td colspan='2'></td>
    </tr>"

    N=$((N + 1))

done < "$URL"
echo "	</table>
	</body>
</html>"
