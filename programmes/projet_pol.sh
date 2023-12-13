URL=$1
N=0

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
while read -r URL
do
   	response=$(curl -s -I -L -w "%{http_code}" -o "./aspirations/aspiration_pl$N.html" $URL)
	CODE=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | egrep -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
    lynx -dump "$URL" > ./dumps-text/dump_pl${N}.html
    COMPTE=$(cat ./dumps-text/dump_pl$N.html | grep -i -o -E "(Z|z)wiaz(ek|k(u|owi|iem|i|ow|om|ami|ach))"  | wc -w)
    CONTEXTES=$(cat ./dumps-text/dump_pl$N.html | grep -B 1 -A 1 -i -w -E "(Z|z)wiaz(ek|k(u|owi|iem|i|ow|om|ami|ach))" > "./contextes/contexte_pl$N.txt" )

    echo "<tr>
    <td>$N</td>
    <td>$URL</td>
    <td>$response</td>
    <td>$CODE</td>
    <td><a href='../aspirations/aspiration_pl$N.html'>aspiration</a></td>
    <td><a href='../dumps-text/dump_pl$N.html'>dump</a></td>
    <td>$COMPTE</td>
    <td><a href='../contextes/contexte_pl$N.txt'>contexte</a></td>
    </tr>" 
    N=$((N + 1))

done < "$URL"
echo "	</table>
	</body>
</html>"
