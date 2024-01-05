#!/usr/bin/bash
urls=$1
N=0

if [ $# -ne 1 ]
then
	echo "Il faut un fichier en argument !
Usage : $0 \"../URLs/liens_gwangye.txt\""
	exit
else
	if [ -f "$urls" ]
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
			<th>Dump</th>
			<th>Nombre d'occurences</th>
			<th>Contexte</th>
			<th>Concordances</th></tr>"

while read -r urls;
do
reponse=$(curl -s -L -w "%{http_code}" -o "../aspirations/aspiration_kor$N.html" $urls)
encodage=$(curl -s -I -L -w "%{content_type}" -o /dev/null $urls | grep -o "charset=\S+" | cut -d"=" -f2 | tail -n 1 | tr '[:lower:]' '[:upper:]')

if [ $reponse == 200 ]
then 
	if [ ! $encodage == "UTF-8" ]
	then 
		iconv -f "$encodage" -t "UTF-8" -o "/tmp/reencodage_${lineno}.html" "./aspirations/kor$N.html"
		mv "/tmp/reencodage_${lineno}.html" "./aspirations/kor$N.html"
	fi	

	lynx -assume_charset UTF-8 -dump -nolist "$urls" > "../dumps-text/dump_kor$N.txt"
	compte=$(cat "../dumps-text/dump_kor$N.html" | egrep -w "관계" | wc -w)
    cat "../dumps-text/dump_kor$N.html" | egrep "관계" > "../contextes/contexte_kor$N.txt"
fi
echo "<tr>
	<td>$N</td>
	<td><a href="$urls">$urls</a></td>
	<td>$reponse</td>
	<td>$encodage</td>
	<td><a href="../aspirations/aspiration_kor$N.html">Aspiration</a></td>
    <td><a href="../dumps-text/dump_kor$N.html">Dump</a></td>
    <td>$compte</td>
    <td><a href="../contextes/contexte_kor$N.txt">Contexte</a></td>
    <td><a href="../concordances/concord_pl$N.html">Concordances</a></td>

	</tr>"
	N=$((N + 1))

done < "$urls"
echo "		</table>
	</body>
</html>" 

# bash projet_kor.sh ../URLs/liens_gwangye.txt > "../tableaux/tableau_kor.html"
