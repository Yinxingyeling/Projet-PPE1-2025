#!/usr/bin/bash

DOSSIER=$1 # prend un dossier en argument
NOM=$2 #lang1 ou lang2 -> fr ou zh
COUNT=0

# Fichier de sortie
OUTFILE="../PALS/${DOSSIER}-${NOM}.txt"

# Vider le fichier de sortie
> ${OUTFILE}

# Test du dossier
if [ -z ${DOSSIER} ];then
    echo "Le dossier n'est pas correct"
    exit
fi

TOTAL=$(ls ../${DOSSIER}/${NOM}-*.txt | wc -l)
RE='A-Za-zÀ-ÖØ-öø-ÿ0-9\.!?'

# Tokeniser fichier
while [ ${COUNT} -lt ${TOTAL} ];
do

    COUNT=$(expr ${COUNT} + 1)
    FICHIER="../${DOSSIER}/${NOM}-${COUNT}.txt"
    FILEBYFILE="../PALS/${DOSSIER}/${DOSSIER}-${NOM}-${COUNT}.txt"

    # Tokenisation
    if [ -f "$FICHIER" ]; then
        echo "Traitement de ${FICHIER}"

        # Découpage en mots et phrases
        if [ "$NOM" = "fr" ]; then
        # Tokenisation française
            cat "$FICHIER" | tr -cs 'A-Za-zÀ-ÖØ-öø-ÿ0-9.!?' '\n' | \
                sed 's/\([.!?]\)/\n\1\n/g' | sed '/^$/d' > "$FILEBYFILE"

        elif [ "$NOM" = "zh" ]; then
        # Tokenisation chinoise via Python
            if ! python3 ../ressources/tokenization/Chinois/tokenize_chinese.py "$FICHIER" | tr " " "\n" | sed '/^$/d' > "$FILEBYFILE" 2>/dev/null
            then
                echo "Tokenisation chinoise échouée: $FICHIER"
                continue
            fi
        fi

        # Vérifier si le fichier est en UTF-8
        ENCODAGE=$(file -b "$FILEBYFILE")   # -b pour ne pas afficher le nom du fichier
        UTF8FILE="../PALS/${DOSSIER}/${NOM}-${COUNT}-utf8.txt"

        if [[ "$ENCODAGE" != *"UTF-8"* ]]; then
            # Cas Non-ISO extended-ASCII
            if [[ "$ENCODAGE" == *"Non-ISO extended-ASCII text"* ]]; then
                iconv -f windows-1252 -t utf-8//IGNORE "$FILEBYFILE" > "$UTF8FILE"
                rm "$FILEBYFILE"
            else
                # Détection automatique d’encodage (prend le 1er mot comme encodage source)
                ENCODAGE_SRC=$(echo "$ENCODAGE" | awk '{print $1}')
                iconv -f "$ENCODAGE_SRC" -t utf-8//IGNORE "$FILEBYFILE" > "$UTF8FILE"
                rm "$FILEBYFILE"
            fi
        else
            # Si déjà UTF-8
            cp "$FILEBYFILE" "$UTF8FILE"
        fi

        # Copie dans le fichier final
        cat "$UTF8FILE" >> "$OUTFILE"
        echo -e "\n" >> "$OUTFILE"  # Saut de ligne pour séparer les fichiers

    else
        echo "${FICHIER} manquant"
    fi

done

