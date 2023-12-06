#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "On a besoin de 3 arguments : dossier dumps-txt avec son chemin, dossier contextes avec son chemin et la langue"
    exit 1
fi

DOSSIER_DUMPS=$1
DOSSIER_CONTEXTES=$2
LANG=$3

output_dump="PPE_lien/itrameur/dumps-text_${LANG}.txt"
echo "<LANG=\"${LANG}\">" > "$output_dump"

output_contextes="PPE_lien/itrameur/contextes_${LANG}.txt"
echo "<LANG=\"${LANG}\">" > "$output_contextes"

for FICHIER in "$DOSSIER_DUMPS"/dump_"${LANG}"*.html; 
do
    if [ -f "$FICHIER" ]; then
		page=$(basename $FICHIER| sed "s/dump_//;s/\.html$//")
        contenu=$(cat $FICHIER | tr -d '&<>' | sed -e 's/&/&amp;/g' -e 's/</&lt;/g' -e 's/>/&gt;/g')
        echo "<page=\"${page}\">" >> "$output_dump"
        echo "<text>${contenu}</text>" >> "$output_dump"
        echo "</page> §" >> "$output_dump"
        #cleaned = $( echo $contenu | sed 's/&/&amp;/g')
        #cleaned = $( echo $contenu | sed 's/</&lt;/g')
        #cleaned = $( echo $contenu | sed 's/>/&gt;/g')
    fi
done
echo "</LANG>" >> "$output_dump"

for FICHIER in "$DOSSIER_CONTEXTES"/contexte_"${LANG}"*.txt; 
do
    if [ -f "$FICHIER" ]; then
		page=$(basename $FICHIER| sed "s/contexte_//;s/\.txt$//")
        contenu=$(cat "$FICHIER" | tr -d '&<>'| sed -e 's/&/&amp;/g' -e 's/</&lt;/g' -e 's/>/&gt;/g')
        echo "<page=\"${page}\">" >> "$output_contextes"
        echo "<text>${contenu}</text>" >> "$output_contextes"
        echo "</page> §" >> "$output_contextes"
    fi
done
echo "</LANG>" >> "$output_contextes"
