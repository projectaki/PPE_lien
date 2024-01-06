#!/usr/bin/env bash
URL=$1
N=0

if [ $# -ne 1 ]
then
	echo "Ce script demande un argument"
	exit
else
	if [ ! -e "$URL" ]
	then 
		echo "Le fichier n'existe pas"
		exit
	fi
fi

echo "<table>" 
echo "<html>
	<head>
		<meta charset=\"UTF-8\">
	</head>
	<body>"

echo "		<table>
		<tr><th>Numéro</th><th>URL</th><th>Code HTTP</th><th>Encodage</th><th>Aspiration</th><th>Dump</th><th>Nombre d'occurences</th><th>Contexte</th><th>Concordances</th></tr>"
while read -r URL
do
   	response=$(curl -s -L -w "%{http_code}" -o "../aspirations/aspiration_pl$N.html" $URL)
	CODE=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | egrep -E -o "charset=\S+" | cut -d"=" -f2 | tail -n 1| tr '[:lower:]' '[:upper:]')
	if [ $response == 200 ]; 
	then
		if [ ! "$CODE" == "UTF-8" ]; 
		then
        iconv -f "$CODE" -t "UTF-8" -o "/tmp/reencodage_$N.html"  "../aspirations/aspiration_pl$N.html"
		mv "/tmp/reencodage_$N.html" "./aspirations/aspiration_pl$N.html"
    fi
	lynx --assume-charset=UTF-8 --display-charset=UTF-8 -dump -nolist "$URL" > "../dumps-text/dump_pl$N.txt"
	# for file in "../dumps-text/dump_pl$N.txt"; do
    # iconv -f "MACROMAN" -t "UTF-8" "$file" > "dump_temp_pl_$N.txt"
    # mv "dump_temp_pl_$N.txt" "../dumps-text/dump_pl$N.txt"
	# done
	#w3m -dump "$URL" > "./dumps-text/dump_pl$N.txt"
    COMPTE=$(cat "../dumps-text/dump_pl$N.txt" | egrep -i -o -E "(Z|z)wi(a|ą)z(ek|k(u|owi|iem|i|(o|ó)w|om|ami|ach))"  | wc -w)
	cat "../dumps-text/dump_pl$N.txt" | egrep -C 3 -i -E "(Z|z)wi(a|ą)z(ek|k(u|owi|iem|i|(o|ó)w|om|ami|ach))" > "../contextes/contexte_pl$N.txt"
	bash ../concordances/concordancier.sh pl pl$N > "../concordances/concord_pl$N.html"
	fi

    echo "<tr>
    <td>$N</td>
    <td><a href="$URL">$URL</a></td>
    <td>$response</td>
    <td>$CODE</td>
    <td><a href='../aspirations/aspiration_pl$N.html'>aspiration</a></td>
    <td><a href='../dumps-text/dump_pl$N.txt'>dump</a></td>
    <td>$COMPTE</td>
    <td><a href='../contextes/contexte_pl$N.txt'>contexte</a></td>
	<td><a href="../concordances/concord_pl$N.html">Concordances</a></td>
    </tr>"
    N=$((N + 1))

done < "$URL"
echo "</table>
	</body>
</html>"
