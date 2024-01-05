#!/usr/bin/bash
LANGUE=$1
FICHIER=$2
CHEMIN=../contextes/contexte_$FICHIER.txt

if [ "$LANGUE" ==  "ang" ]
then
	REGEXP='[Ll]inks?'
fi

if [ "$LANGUE" ==  "pl" ]
then
	REGEXP='\b(Z|z)wi(a|ą)z(ek|k(u|owi|iem|i|ow|om|ami|ach))\b'
fi

if [ "$LANGUE" ==  "kor" ]
then
	REGEXP='관계'
fi

echo "
<!DOCTYPE html>
<html lang=\"${LANGUE}\">
<head>
	<meta charset=\"UTF-8\">
	<title>Concordances</title>
</head>
<body>
	<table>
	<thead>
		<tr>
    			<th class="has-text-droite">Contexte gauche</th>
    			<th>Mot</th>
    			<th class="has-text-gauche">Contexte droit</th>
		</tr>
	</thead>
	<tbody>"

if [ "$LANGUE" ==  "pl" ]
then

	grep -h -o -E -i -r "(\w+\W){0,5}$REGEXP(\W+\w+){0,5}" "$CHEMIN" | while read -r line; do
	context_gauche=$(echo "$line" | grep -o -E -i "(\w+\W){0,5}$REGEXP" | sed 's/^\W*//')
    match=$(echo "$line"| grep -o -E -i "$REGEXP")
    context_droite=$(echo "$line" | grep -o -E -i "$REGEXP(\W+\w+){0,5}" | sed 's/\W*$//')
    
	echo "<tr><td>${context_gauche}</td><td>${match}</td><td>${context_droite}</td></tr>"
done
else
	grep -o -E -i "(\w+\W){0,5}$REGEXP(\W+\w+){0,5}" "$CHEMIN" |sed -E "s/(.*)($REGEXP)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/"
fi
	#sed -E "s/(.*)($REGEXP)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/i"  
	#grep -o -E -i "(\w+\W){0,5}$REGEXP(\W+\w+){0,5}" "$CHEMIN" | sed -E "s/(${REGEXP})(.*)/pppp\1oooo\2 xyz/"  


echo "
	</tbody>
	</table>
</body>
</html>
"
