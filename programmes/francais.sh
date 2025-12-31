# !/usr/bin/bash

URL=$1
COUNT=0
OUTFILE="../tableaux/tableau-fr.html" # Fichier de sauvegarde
CONCFINAL="../concordances/fr-final.html"

# Construction du fichier tableau
echo -e "<html>
    <head>
        <meta charset=\"UTF-8\"/>
        <title>Tableau</title>
        <link rel=\"stylesheet\" href=\"../../assets/css/style.css\"/>
        <link
        rel=\"stylesheet\"
        href=\"https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/versions/bulma-no-dark-mode.min.css\">
    </head>
    <body class=\"tableau\">
        <div class=\"centrer\">
            <a href=\"../../index.html\" class=\"button accueil\">Accueil</a>
            <a class=\"button script\">Script</a>
            <a class=\"button tablo is-focus\">Tableau</a>
            <a href=\"../concordances/fr-final.html\" class=\"button concordance\">Concordance</a>
        </div>
        <section class=\"section has-text-centered\">
            <h1 class=\"title is-1\">Links table</h1>
            <div class=\"columns-is-centered\">
                <table class=\"table is-hoverable is-striped\">
                    <tr>
                        <th>Lignes</th>
                        <th>Liens</th>
                        <th>Code</th>
                        <th>Encodage</th>
                        <th>Nombres total</th>
                        <th>Nombres d'occurence</th>
                        <th>Contextes</th>
                        <th>Concordanciers</th>
                    </tr>" > ${OUTFILE}

# Construction du fichier de concordance final (à la totalité des concordances des liens français)
echo -e "<html>
    <head>
        <meta charset=\"UTF-8\">
        <title>Liste de concordances</title>
        <link rel=\"stylesheet\" href=\"../../assets/css/style.css\"/>
        <link
        rel=\"stylesheet\"
        href=\"https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/versions/bulma-no-dark-mode.min.css\">
    </head>

    <body>
        <section class=\"hero is-primary\">
            <div class=\"hero-body\">
                <div class=\"container\">
                <h1 class=\"title\">Tableau des concordances</h1>
                </div>
            </div>
        </section>

        <section class=\"section\">
            <div class=\"container\">
                <table class=\"table is-striped is-fullwidth\">

                <tr>
                    <th>Fichier</th>
                    <th>Contexte gauche</th>
                    <th>Cible</th>
                    <th>Contexte droit</th>
                </tr>
" > ${CONCFINAL}

# Test du chemin
if [ ! -n "$URL" ]
then
    echo "L'argument est incorrect"
    exit
fi

# Lis chaque ligne du fichier
while read -r line
do
    COUNT=$(expr "$COUNT" + 1)

    # Récupère le code HTTP
    REPHTTP=$(curl -s -o /dev/null -w %{http_code} "$line")

    # Test pour les erreurs HTTP
    if [ "$REPHTTP" -eq 200 ]; then
        # Récupère l'encodage et le nombre de mots
        ENCODAGE=$(curl -s -o /dev/null -w "%{content_type}" "${line}" | cut -d '=' -f2)
        WORD=$(lynx -dump "$line" | wc -w)
    
    # Ajout test pour 429 (trop de requêtes)
    elif [ "$REPHTTP" -eq 429 ] ; then
        sleep 3 # Pause de 3 secondes
        REPHTTP=$(curl -s -o /dev/null -w %{http_code} "$line")
        ENCODAGE=$(curl -s -o /dev/null -w "%{content_type}" "${line}" | cut -d '=' -f2)
        WORD=$(lynx -dump "$line" | wc -w)

    # Si erreur : ne pas afficher la suite
    else
        ENCODAGE="-"
        WORD="-"
    fi

    # Fichiers de sortie
    ASPIRATION="../aspirations/fr-${COUNT}.html" #Fichier html de la page téléchargé
    DUMP="../dumps-text/fr-${COUNT}.txt" # Texte brut de la page
    CTXT="../contextes/fr-${COUNT}.txt" # Contexte autour du mot
    TEMPO="../tmp/concord.txt" # Facilite la tâche pour le tableau des concordances
    REWORD="nuages"

    mkdir -p ../tmp/ # Crée un répertoire temporaire

    if wget -O ${ASPIRATION} ${line}; # Récupère la page
    then

        if [[ ${ENCODAGE,,} == "utf-8" ]]; # Si l'encodage est utf8
        then

            # Extraction du texte brut dans dump-text
            lynx -dump ${ASPIRATION} > ${DUMP} 

            # Extraction du contexte autour du mot
            cat ${DUMP} | grep  -i -E ${REWORD} -C2 > ${CTXT} # -i ignore-case
    
        else
            # Capture l'encodage source (qui n'est pas utf8)
            CODESOURCE=$(file --mime-encoding ${ASPIRATION} | cut -d ' ' -f2 | tr "[:lower:]" "[:upper:]" ) # Ne prends que l'encodage
            
            # Change l'encodage en UTF-8 si nécessaire
            if [[ ${CODESOURCE} != "UTF-8" ]];
            then

                # Fichier de sauvegarde après conversion
                UTF8="../aspirations/fr-${COUNT}-utf8.html"
                # Conversion encodage source à utf8
                iconv -f ${CODESOURCE} -t UTF-8 ${ASPIRATION} -o ${UTF8}
                rm ${ASPIRATION}

                # Extraction
                lynx -dump ${UTF8} > ${DUMP}
                cat ${DUMP} | grep  -i -E ${REWORD} -C2 > ${CTXT} 
        
            fi
        fi
    fi  

    # Construction du fichier concordance
    CONCORD="../concordances/fr-${COUNT}.html" # Concordance
    echo -e "<html>
        <head>
            <meta charset=\"UTF-8\">
            <title>Liste de concordances</title>
            <link rel=\"stylesheet\" href=\"../../assets/css/style.css\"/>
            <link
            rel=\"stylesheet\"
            href=\"https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/versions/bulma-no-dark-mode.min.css\">
        </head>

        <body>
            <section class=\"hero is-primary\">
                <div class=\"hero-body\">
                    <div class=\"container\">
                    <h1 class=\"title\">Tableau des concordances</h1>
                    </div>
                </div>
            </section>

            <section class=\"section\">
                <div class=\"container\">
                    <table class=\"table is-striped is-fullwidth\">

                    <tr>
                        <th>Fichier</th>
                        <th>Contexte gauche</th>
                        <th>Cible</th>
                        <th>Contexte droit</th>
                    </tr>
    " > ${CONCORD}

    WORDCOUNT=$(cat ${CTXT} | grep -i -o "nuage" | wc -l) # Nombre d'occurrence "nuage" dans le texte

    sed -nE "s#^(.*)(nuages?)(.*)#<tr><td>${COUNT}</td><td>\1</td><td>\2</td><td>\3</td></tr>#Ip" ${CTXT} | tee -a ${CONCORD} ${CONCFINAL} > /dev/null
    
    # Complète le tableau
    echo "                  <tr>
                            <td>${COUNT}</td> <!-- numéro de ligne -->
                            <td><a href=\"${line}\">${line}</a></td> <!-- lien url -->
                            <td>${REHTTP}</td> <!-- code http -->
                            <td>${ENCODAGE}</td> <!-- encodage de la page -->
                            <td>${WORD}</td> <!-- nombre de mot total -->
                            <td>${WORDCOUNT}</td> <!-- nombre d'occurrence de nuage(s) -->
                            <td><a href=\"${CTXT}\">Contexte</a></td> <!-- lien vers le contexte autour de nuage (.txt) -->
                            <td><a href=\"${CONCORD}\">Concordance</a></td> <!-- lien vers la concordance de nuage -->
                        </tr>" >> ${OUTFILE}

done < "$URL" ;

echo -e "               </table>
            </div>
        </section>
    </body>
</html>" | tee -a ${OUTFILE} ${CONCORD} ${CONCFINAL} > /dev/null # Fin des deux fichiers html
