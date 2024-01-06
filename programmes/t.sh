#!/usr/bin/env bash
URL=$1
N=0

if [ $# -ne 1 ]; then
    echo "Ce script demande un argument"
    exit
else
    if [ ! -e "$URL" ]; then
        echo "Le fichier n'existe pas"
        exit
    fi
fi

while read -r URL; do
    response=$(curl -s -L -w "%{http_code}" -o "../aspirations/aspiration_pl$N.html" $URL)
    CODE=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | egrep -E -o "charset=\S+" | cut -d"=" -f2 | tail -n 1 | tr '[:lower:]' '[:upper:]')

    lynx --assume-charset=UTF-8 --display-charset=UTF-8 -dump -nolist "$URL" | iconv -c -f UTF-8 -t UTF-8 >"./t.txt"

    break

done <"$URL"
