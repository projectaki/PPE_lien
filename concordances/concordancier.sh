#!/usr/bin/bash
LANGUE=$1
FICHIER=$2
CHEMIN=../contextes/contexte_$FICHIER.txt

if $LANGUE == "ang"
then
	REGEXP=\blinks?\b
fi

if $LANGUE == "pl"
then
	REGEXP="\b(Z|z)wiaz(ek|k(u|owi|iem|i|ow|om|ami|ach))\b"
fi

if $LANGUE == "kor"
then
	REGEXP="관계"
fi

echo "
<!DOCTYPE html>
<html lang=\"${LANGUE}\">
<head>
	<meta charset=\"UTF-8\">
	<title>Concordance</title>
</head>
<body>
	<table>
	<thead>
		<tr>
    			<th class="has-text-right">Contexte gauche</th>
    			<th>Mot</th>
    			<th class="has-text-left">Contexte droit</th>
		</tr>
	</thead>
	<tbody>"
	
grep -o -E -i "(\w+\W){0,5}\blinks?\b(\W+\w+){0,5}" "$CHEMIN" | sed -E 's/(.*)(\blinks?\b)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/'  


echo "
	</tbody>
	</table>
</body>
</html>
"
