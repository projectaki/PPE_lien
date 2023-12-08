TEXTE=$(grep -o -P -i "(\w+\W){0,5}links?(\W+\w+){0,5}" ./contextes/contexte_ang17.txt | sed 's/\(links\?\)/\t\0\t/g')
while read -r TEXTE ;
do
	DEBUT=$(grep "^(*\t)" $TEXTE)
	MOT=$(grep "\t*\t" $TEXTE)
	FIN=$(grep "(\t*)$" $TEXTE)
	echo $DEBUT\t$MOT\t$FIN
done	
