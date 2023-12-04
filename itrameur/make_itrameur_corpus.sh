DOSSIER=$1
BASE=$2

echo "<lang=ang>"
FICHIER=$(../$DOSSIER/dump_$BASE.html)
while read -r $FICHIER
do
	echo "<page="$BASE">
	<text>
	cat $FICHIER
	</text>
	</page>§" >dump-$BASE.txt
done



