urls=$1

if [ $# -ne 1 ]
then
	echo "Il faut un fichier en argument !
Usage : $0 ../liens_gwangye.txt"
	exit
else
	if [ -f "${urls}" ]
	then 
		echo "Le fichier existe bien."
	else
		echo "Le fichier n'existe pas !
Usage : $0 ".."/liens_gwangye.txt" 
		exit
	fi
fi

echo "<table>" 
echo "<html>
	<head>
		<meta charset= \"UTF-8\">
	</head>
	<body>"

echo "  <table>
            <tr><th>Numéro</th>
			<th>URLs</th>
			<th>Code HTTP</th>
			<th>Encodage</th>
			<th>Aspiration</th>
			<Dump</th>
			<th>Nombre d'occurences</th>
			<th>Contexte</th></tr>"

N=0
while read -r urls;
do
	response=$(curl -s -I -L -w "%{http_code}" -o "./aspirations/aspiration_kor${N}.html" $urls)
	code=$(curl -s -I -L -w "%{content_type}" -o /dev/null $urls | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	lynx -dump $urls > "../dumps-text/dump_kor${N}.html"
	compte=$(cat "./dumps-text/dump_kor${N}.html" | egrep -i -o "(관계|링크|끈)"  | wc -w)
    cat "./dumps-text/dump_kor${N}.html" | egrep -2 "(관계|링크|끈)" > "./contexte/contexte_kor${N}.txt"
	echo "<tr>
		<td>${N}</td>
		<td>${urls}</td>
		<td>${response}</td>
		<td>${code}</td>
		<td><a href="../aspirations/aspiration_kor${N}.html">Aspiration</a></td>
        <td><a href="../dumps-text/dump_kor${N}.html">Dump</a></td>
        <td>${compte}</td>
        <td><a href="../contextes/contexte_kor${N}.txt">Contexte</a></td>
	</tr>"
	N=$(expr $N + 1)

done < "$urls"
echo "		</table>
	</body>
</html>" 
