DOC=$1

if [ $# -ne 1 ]
then
	echo "Il faut un fichier en argument !
Usage : $0 ~/Desktop/Cours/ppe/PPE_lien/URLs/liens_gwangye.txt"
	exit
else
	if [ -f "$DOC" ]
	then 
		echo "Le fichier existe bien."
	else
		echo "Le fichier n'existe pas !
Usage : $0 ~/Desktop/Cours/ppe/PPE_lien/URLs/liens_gwangye.txt" 
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

N=1
while read -r URL;
do
	langue=$(basename $URL .txt)
	response=$(curl -s -I -L -w "%{http_code}" -o "./aspirations/${langue}${N}.html" $URL)
	CODE=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	echo "<tr>
		<td>"$N"</td>
		<td>"$URL"</td>
		<td>"$response"</td>
		<td>"$CODE"</td>
	</tr>"
	curl $URL >../aspirations/aspiration_kor$N.txt
	lynx -dump $URL >../dumps-text/dump_kor$N.txt
	  N=$(expr $N + 1)

done < "$DOC"
echo "		</table>
	</body>
</html>" 
