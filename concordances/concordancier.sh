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
    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css\">
</head>
<body>
    <section class=\"section\">
        <div class=\"container\">
            <h1 class=\"title\">Concordances</h1>
            <table class=\"table\">
                <thead>
                    <tr>
                        <th class=\"has-text-right\">Contexte gauche</th>
                        <th>Mot</th>
                        <th class=\"has-text-left\">Contexte droit</th>
                    </tr>
                </thead>
                <tbody>
"

if [ "$LANGUE" ==  "pl" ]
then
    grep -h -o -E -i -r "(\w+\W){0,5}$REGEXP(\W+\w+){0,5}" "$CHEMIN" | while read -r line; do
        context_gauche=$(echo "$line" | grep -o -E -i "(\w+\W){0,5}$REGEXP" | sed 's/^\W*//' | grep -o -E -i "(\w+\W){0,5}" | sed 's/^\W*//' )
        match=$(echo "$line" | grep -o -E -i "$REGEXP")
        context_droite=$(echo "$line" | grep -o -E -i "$REGEXP(\W+\w+){0,5}" | sed 's/\W*$//' | grep -o -E -i "(\w+\W){0,5}" | sed 's/\W*$//' | tail -n 1)
        echo "<tr><td>${context_gauche}</td><td>${match}</td><td>${context_droite}</td></tr>"
    done
else
    grep -o -E -i "(\w+\W){0,5}$REGEXP(\W+\w+){0,5}" "$CHEMIN" | sed -E "s/(.*)($REGEXP)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/"
fi

echo "
                </tbody>
            </table>
        </div>
    </section>
</body>
</html>
"
