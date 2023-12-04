#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "On a besoin de 2 arguments : dossier dumps-txt avec son chemin et la LANGue"
    exit 1
fi

DOSSIER_DUMPS=$1
LANG=$2

output_dump="Desktop/PPE_lien/itrameur/dumps-text_${LANG}.txt"
echo "<LANG=\"${LANG}\">" > "$output_dump"

for FICHIER in "$DOSSIER_DUMPS"/dump_"${LANG}"*.html; 
do
    if [ -f "$FICHIER" ]; then

		page=$(basename $FICHIER.txt)
        contenu=$(cat $FICHIER | tr -d '&<>')
        echo "<page=\"${page}\">" >> "$output_dump"
        echo "<text>${contenu}</text>" >> "$output_dump"
        echo "</page> §" >> "$output_dump"
    fi
done
echo "</LANG>" >> "$output_dump"
