# !/usr/bin/bash

set -e

# Fichier passé en argument
URL_FILE=$1

# Détermination de la langue selon le nom de fichier
if [ "${URL_FILE}" = "../URLs/francais.txt" ]; then
    NOM="fr"
else
    NOM="zh"
fi

# Dossiers
TMP_DIR="../tmp"
ROBOTS_DIR="${TMP_DIR}/robots"
BLACKLIST="${TMP_DIR}/${NOM}.txt-blacklist"

mkdir -p "${ROBOTS_DIR}"
> "${BLACKLIST}"

echo "[*] Extraction des serveurs uniques..."
awk -F/ '{print $1 "//" $3}' "${URL_FILE}" | sort | uniq > "${TMP_DIR}/${NOM}-servers.txt"


while read -r server; do
    FILE_NAME="${NOM}-$(echo ${server} | sed 's|://|_|; s|/||g')-robots.txt"
    echo "[*] Téléchargement de ${server}/robots.txt → ${ROBOTS_DIR}/${FILE_NAME}"
    curl -s "${server}/robots.txt" -o "${ROBOTS_DIR}/${FILE_NAME}"
done < "${TMP_DIR}/${NOM}-servers.txt"


echo "[*] Lecture des robots.txt et génération de la blacklist..."

while read -r server; do
    FILE_NAME="${NOM}-$(echo ${server} | sed 's|://|_|; s|/||g')-robots.txt"
    FILE="${ROBOTS_DIR}/${FILE_NAME}"
    user_agent_ok=0

    while IFS= read -r line; do
        line=$(echo "${line}" | sed 's/#.*//; s/^[ \t]*//; s/[ \t]*$//')
        [[ -z "${line}" ]] && continue

        if [[ "${line}" =~ ^User-Agent:[[:space:]]*\* ]]; then
            user_agent_ok=1
            continue
        fi
        if [[ "${user_agent_ok}" -eq 1 && "${line}" =~ ^User-Agent: ]]; then
            user_agent_ok=0
        fi

        if [[ "${user_agent_ok}" -eq 1 && "${line}" =~ ^Disallow:[[:space:]]*(.*) ]]; then
            path="${BASH_REMATCH[1]}"
            [[ -n "${path}" ]] && echo "${server}${path}" >> "${BLACKLIST}"
        fi
    done < "${FILE}"

done < "${TMP_DIR}/${NOM}-servers.txt"

echo "[+] Blacklist générée : ${BLACKLIST}"