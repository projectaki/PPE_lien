LANGUE=$1

$PATH = "../contextes/contexte_$LANGUE*.txt"

if $LANGUE == "ang"
then
	$REGEXP="\blinks?\b"
fi

if $LANGUE == "pol"
then
	$REGEXP=""
fi

if $LANGUE == "kor"
then
	$REGEXP=""
fi

echo "	<html>
	<head>
		<meta charset= \"UTF-8\">
	</head>
	<body>
	<table>
	<thead>
	<tr><th>Contexte droit</th><th>Mot</th><th>Contexte gauche</th></tr>
	</thead>
	<tbody>"

grep -o -E -i "(\w+\W){0,5}$REGEXP(\W+\w+){0,5}" $PATH | sed -E "s/(.*)($REGEXP)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/g" > concordancier_$LANGUE.html

echo"</tbody>
</table>
	</body>
</html>" 
