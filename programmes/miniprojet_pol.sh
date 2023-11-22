DOC=$1
N=0

if [ $# -ne 1 ]
then
	echo "Ce script demande un argument"
	exit
else
	if [ -f "$DOC" ]
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
		<tr><th>Numéro</th><th>URL</th><th>codeHTTP</th><th>encodage</th></tr>"
while read -r URL;
do
	response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
	CODE=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	echo "<tr>
		<td>"$N"</td>
		<td>"$URL"</td>
		<td>"$response"</td>
		<td>"$CODE"</td>
	</tr>"
	  N=$(expr $N + 1)

done < "$DOC"
echo "		</table>
	</body>
</html>" 
