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
		<tr><th>Numéro</th><th>URL</th><th>codeHTTP</th><th>encodage</th><th>aspiration</th><dump</th></tr>"
while read -r URL;
do
	response=$(curl -s -I -L -w "%{http_code}" -o "../aspirations/aspiration_ang$N.html" $URL)
	CODE=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
       lynx -dump $URL >../dumps-text/dump_ang$N.html

	echo "<tr>
		<td>"$N"</td>
		<td>"$URL"</td>
		<td>"$response"</td>
		<td>"$CODE"</td>
		<td><a href="../aspirations/aspiration_ang$N.html">aspiration</a></td>
		<td><a href="../dumps-text/dump_ang$N.html">dump</a></td>
	</tr>"	
	  N=$(expr $N + 1)

done < "$URL"
echo "		</table>
	</body>
</html>" 
