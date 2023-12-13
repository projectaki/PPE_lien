#!/usr/bin/bash
urls=$1

if [ $# -ne 1 ]
then
	echo "Il faut un fichier en argument !
Usage : $0 \"../URLs/liens_gwangye.txt\""
	exit
else
	if [ -f "${urls}" ]
	then 
		echo " "
	else
		echo "Le fichier n'existe pas !
Usage : $0 \"../URLs/liens_gwangye.txt\""
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
			<th>encodage HTTP</th>
			<th>Encodage/th>
			<th>Aspiration</th>
			<Dump</th>
			<th>Nombre d'occurences</th>
			<th>Contexte</th></tr>"

while read -r urls;
do
N=0
LANG="kor"
reponse=$(curl -s -I -L -w "%{http_encodage}" -o "../aspirations/aspiration_${LANG}${N}.html" $urls)
encodage=$(curl -s -I -L -w "%{content_type}" -o /dev/null $urls | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1 | tr '[:lower:]' '[:upper:]')

if [ $reponse -eq 200 ]
then 
	if [ ! $encodage == "UTF-8" ]
	then 
		iconv -f "$encodage" -t "UTF-8" -o "/tmp/reencodage_${N}.html" "./aspirations/${LANG}-${N}.html"
		mv "/tmp/reencodage_${N}.html" "./aspirations/${LANG}-${N}.html"
	fi	

	lynx -assume_charset UTF-8 -dump -nolist ./apsirations/${LANG}-${N}.html > "../dumps-text/dump_${LANG}${N}.txt"
	compte=$(cat "../dumps-text/dump_${LANG}${N}.html" | egrep -i -o "관계"  | wc -w)
    cat "../dumps-text/dump_${LANG}${N}.html" | egrep -2 "관계" > "../contextes/contexte_${LANG}${N}.txt"
	echo "<tr>
		<td>${N}</td>
		<td>${urls}</td>
		<td>${reponse}</td>
		<td>${encodage}</td>
		<td><a href="../aspirations/aspiration_${LANG}${N}.html">Aspiration</a></td>
        <td><a href="../dumps-text/dump_${LANG}${N}.html">Dump</a></td>
        <td>${compte}</td>
        <td><a href="../contextes/contexte_${LANG}${N}.txt">Contexte</a></td>
	</tr>"
	N=$(expr $N + 1)
fi

done < "$urls"
echo "		</table>
	</body>
</html>" 

# bash projet_${LANG}.sh ../URLs/liens_gwangye.txt > "../tableaux/tableau_${LANG}.html"
