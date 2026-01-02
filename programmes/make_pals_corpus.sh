#!/usr/bin/bash

DOSSIER=$1 # prend un dossier en argument
NOM=$2 #lang1 ou lang2 -> fr ou zh
COUNT=0

# Fichier de sortie
OUTFILE="${DOSSIER}-${NOM}.txt"

# Test du dossier
if [ ! -n ${DOSSIER} ];then
    echo "Le dossier n'est pas correct"
    exit
fi

TOTAL=$(ls ../${DOSSIER}/ | wc -l)
RE='A-Za-zÀ-ÖØ-öø-ÿ0-9\.!?'

# Tokeniser fichier
while [ ${COUNT} -lt ${TOTAL} ];
do

    COUNT=$(expr ${COUNT} + 1)
    FICHIER="../${DOSSIER}/${NOM}-${COUNT}.txt"

    # Tokenisation
    if [ -f ${FICHIER} ]; then
        echo "Traitement de ${FICHIER}"

        cat ${FICHIER} | tr -cs 'A-Za-zÀ-ÖØ-öø-ÿ0-9.!?' '\n' | sed 's/\([.!?]\)/\n\1\n/g' | sed '/^$/d' > ${OUTFILE}
    else
        echo "${FICHIER} manquant"
    fi

done
