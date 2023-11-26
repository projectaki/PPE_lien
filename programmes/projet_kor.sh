urls=$1

if [ $# -ne 1 ]
then
	echo "Il faut un fichier en argument !
Usage : $0 ~/Desktop/Cours/ppe/PPE_lien/URLs/liens_gwangye.txt"
	exit
else
	if [ -f "$urls" ]
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
		<tr><th>Numéro</th><th>urls</th><thcode HTTP</th><th>Encodage</th></tr><th>Aspiration</th><Dump</th><th>Nombre d'occurences</th><th>Contexte</th></tr>"

N=0
while read -r urls;
do
	response=$(curl -s -I -L -w "%{httpcode}" -o "./aspirations/aspiration_kor${N}.html" $urls)
code=$(curl -s -I -L -w "%{content_type}" -o /dev/null $urls | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	curl $urls >../aspirations/aspiration_kor$N.txt
	lynx -dump $urls >../dumps-text/dump_kor$N.txt
	compte=$(cat ./dumps-text/dump_kor${N}.html | grep -i -o -E "(관계|링크|끈)"  | wc -w)
    contexte=$(cat ./dumps-text/dump_kor${N}.html | grep -B 1 -A 1 -i -w -E "(관계|링크|끈)" > "./contexte/contexte_kor${N}.txt" )
	N=$(expr $N + 1)
		echo "<tr>
		<td>"$N"</td>
		<td>"$urls"</td>
		<td>"$response"</td>
		<td>"$code"</td>
	</tr>"

done < "$urls"
echo "		</table>
	</body>
</html>" 
