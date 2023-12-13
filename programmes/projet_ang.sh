URL=$1
N=0
 
if [ $# -ne 1 ]
then
	echo "Ce script demande un argument"
	exit
else
	if ! [ -f "$URL" ]
	then 
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
		<tr><th>Numéro</th><th>URL</th><th>Code HTTP</th><th>Encodage</th><th>Aspiration</th><th>Dump</th><th>Nonbre d'occurences</th><th>Contexte</th><th>Concordances</th></tr>"
while read -r URL;
do
	response=$(curl -s -L -w "%{http_code}" -o "../aspirations/aspiration_ang$N.html" $URL)
	CODE=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1 | tr '[:lower:]' '[:upper:]')
	COMPTE=0
	if [ $response == "200" ]
	then 
		if [ ! $CODE == "UTF-8"]
		then
			iconv -f "$CODE" -t "UTF-8" -o "/tmp/recode_${lineo}.html" "../aspirations/aspirations_ang$N.html"
			mv "/tmp/recode_${lineo}.html" "../aspirations/aspiration_ang${lineo}.html"
		fi

		lynx -assume_charset UTF-8 -dump -nolist ../aspirations/aspiration_ang$N.html >../dumps-text/dump_ang$N.html
		COMPTE=$(grep -P -i -w -o  "links?" ../dumps-text/dump_ang$N.html | wc -l)
		cat ../dumps-text/dump_ang$N.html | grep -P -C 3 -i  " link(s)? " > ../contextes/contexte_ang$N.txt
		bash ../concordances/concordancier.sh ang ang$N >../concordances/concord_ang$N.html
	fi
	echo "<tr>
		<td>"$N"</td>
		<td>"$URL"</td>
		<td>"$response"</td>
		<td>"$CODE"</td>
		<td><a href="../aspirations/aspiration_ang$N.html">aspiration</a></td>
		<td><a href="../dumps-text/dump_ang$N.html">dump</a></td>
		<td>"$COMPTE"</td>
		<td><a href="../contextes/contexte_ang$N.txt">contexte</a></td>
		<td><a href="../concordances/concord_ang$N.html">Concordances</a></td>
	</tr>"	
	  N=$(expr $N + 1)

done < "$URL"
echo "		</table>
	</body>
</html>" 
