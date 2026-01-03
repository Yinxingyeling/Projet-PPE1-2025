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
        <section class=\"hero  is-medium is-primary\">
            <div class=\"hero-body\">
                <div class=\"container\">
                <h1 class=\"title is-1\">Tableau général</h1>
                <h2 class=\"subtitle is-3\">Corpus français</h2>
                </div>
            </div>
        </section>
        <nav class=\"navbar\" role=\"navigation\" aria-label=\"main navigation\">
            <div class=\"navbar-brand\">
                <p class="navbar-item">
                    <img src=\"../assets/img/cloud.png\" alt=\"Cloud\" style=\"max-height: 40px;\">
                </p>

                <a role=\"button\" class=\"navbar-burger\" aria-label=\"menu\" aria-expanded=\"false\" data-target=\"navbarBasicExample\">
                <span aria-hidden=\"true\"></span>
                <span aria-hidden=\"true\"></span>
                <span aria-hidden=\"true\"></span>
                <span aria-hidden=\"true\"></span>
                </a>
            </div>

            <div id=\"navbarBasicExample\" class=\"navbar-menu\">
                <div class=\"navbar-start\">
                    <a class=\"navbar-item\" href=\"../index.html\">
                        Home
                    </a>

                    <!-- Analyse -->
                    <div class=\"navbar-item has-dropdown is-hoverable\">
                        <a class=\"navbar-link\">Analyse</a>

                        <div class=\"navbar-dropdown\">
                            <a class=\"navbar-item\" href=\"../fr_analyse.html\">Français</a>
                            <a class=\"navbar-item\" href=\"../zh_analyse.html\">Chinois</a>
                        </div>
                    </div>

                    <!-- Script -->
                    <div class=\"navbar-item has-dropdown is-hoverable\">
                        <a class=\"navbar-link\">Script</a>

                        <div class=\"navbar-dropdown\">
                            <a class=\"navbar-item\" href=\"../fr_script.html\">Français</a>
                            <a class=\"navbar-item\" href=\"../zh_script.html\">Chinois</a>
                            <a class=\"navbar-item\" href=\"../blacklist.html\">Blacklist</a>
                            <a class=\"navbar-item\" href=\"../make_pals_corpus.html\">PALS</a>
                        </div>
                    </div>

                    <!-- Tableau -->
                    <div class=\"navbar-item has-dropdown is-hoverable\">

                        <a class=\"navbar-link\">Tableau</a>
                        <div class=\"navbar-dropdown\">
                            <a class=\"navbar-item is-selected has-background-link-light\" href=\"../tableaux/tableau-fr.html\">Français</a>
                            <a class=\"navbar-item\" href=\"../tableaux/tableau-zh.html\">Chinois</a>
                        </div>
                    </div>

                    <!-- Concordances -->
                    <div class=\"navbar-item has-dropdown is-hoverable\">
                        <a class=\"navbar-link\">Concordances</a>

                        <div class=\"navbar-dropdown\">
                            <a class=\"navbar-item\" href=\"../concordances/fr-final.html\">Français</a>
                            <a class=\"navbar-item\" href=\"../concordances/zh-final.html\">Chinois</a>
                    </div>           
                </div>
            </div>
        </nav>
        <section class=\"section has-text-centered\">
            <div class=\"columns-is-centered\">
                <table class=\"table is-hoverable is-striped\">
                    <tr>
                        <th>Lignes</th>
                        <th>Liens</th>
                        <th>Code</th>
                        <th>Encodage</th>
                        <th>Total</th>
                        <th>Nuage</th>
                        <th>Contextes</th>
                        <th>Concordanciers</th>
                        <th>Bigrammes</th>
                        <th>Gestions</th>
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
            <style>
                /* Alignement des en-têtes */
                .concordance-table th:nth-child(2) { text-align: right; width: 40%; }
                .concordance-table th:nth-child(3) { text-align: center; width: 20%; color: red; font-weight: bold; }
                .concordance-table th:nth-child(4) { text-align: left; width: 40%; }
                .concordance-table th:nth-child(1) { text-align: center; color: #999; }
                
                /* Alignement des élément dans tableau */
                .concordance-table td:nth-child(2) { text-align: right; width: 40%; }
                .concordance-table td:nth-child(3) { text-align: center; width: 20%; color: red; font-weight: bold; }
                .concordance-table td:nth-child(4) { text-align: left; width: 40%; }
                .concordance-table td:nth-child(1) { text-align: center; color: #999; }
            </style>
        </head>

        <body>
            <section class=\"hero is-medium is-primary\">
                <div class=\"hero-body\">
                    <div class=\"container\">
                        <h1 class=\"title is-1\">Tableau des concordances</h1>
                        <h2 class=\"subtitle is-3\">Corpus français</h2>
                    </div>
                </div>
            </section>
            <nav class=\"navbar\" role=\"navigation\" aria-label=\"main navigation\"> 
                <div class=\"navbar-brand\">
                    <p class="navbar-item">
                        <img src=\"../assets/img/cloud.png\" alt=\"Cloud\" style=\"max-height: 40px;\">
                    </p>

                    <a role=\"button\" class=\"navbar-burger\" aria-label=\"menu\" aria-expanded=\"false\" data-target=\"navbarBasicExample\">
                    <span aria-hidden=\"true\"></span>
                    <span aria-hidden=\"true\"></span>
                    <span aria-hidden=\"true\"></span>
                    <span aria-hidden=\"true\"></span>
                    </a>
                </div>

                <div id=\"navbarBasicExample\" class=\"navbar-menu\">
                    <div class=\"navbar-start\">
                        <a class=\"navbar-item\" href=\"../index.html\">
                            Home
                        </a>

                        <!-- Analyse -->
                    <div class=\"navbar-item has-dropdown is-hoverable\">
                        <a class=\"navbar-link\">Analyse</a>

                        <div class=\"navbar-dropdown\">
                            <a class=\"navbar-item\" href=\"../fr_analyse.html\">Français</a>
                            <a class=\"navbar-item\" href=\"../zh_analyse.html\">Chinois</a>
                        </div>
                    </div>

                    <!-- Script -->
                    <div class=\"navbar-item has-dropdown is-hoverable\">
                        <a class=\"navbar-link\">Script</a>

                        <div class=\"navbar-dropdown\">
                            <a class=\"navbar-item\" href=\"../fr_script.html\">Français</a>
                            <a class=\"navbar-item\" href=\"../zh_script.html\">Chinois</a>
                            <a class=\"navbar-item\" href=\"../blacklist.html\">Blacklist</a>
                            <a class=\"navbar-item\" href=\"../make_pals_corpus.html\">PALS</a>
                        </div>
                    </div>

                    <!-- Tableau -->
                    <div class=\"navbar-item has-dropdown is-hoverable\">

                        <a class=\"navbar-link\">Tableau</a>
                        <div class=\"navbar-dropdown\">
                            <a class=\"navbar-item\" href=\"../tableaux/tableau-fr.html\">Français</a>
                            <a class=\"navbar-item\" href=\"../tableaux/tableau-zh.html\">Chinois</a>
                        </div>
                    </div>

                    <div class=\"navbar-item has-dropdown is-hoverable\">
                        <a class=\"navbar-link\">Concordances</a>

                        <div class=\"navbar-dropdown\">
                            <a class=\"navbar-item has-background-link-light is-selected\" href=\"../concordances/fr-final.html\">Français</a>
                            <a class=\"navbar-item\" href=\"../concordances/zh-final.html\">Chinois</a>
                        </div>           
                    </div>
                </div>
                <div class=\"navbar-end\">
                    <div class=\"navbar-item\">
                        <div class=\"buttons\">
                            <button class=\"button is-primary\" onclick=\"history.back();\">Retour</button>
                        </div>
                    </div>
                </div>
            </nav>

            <section class=\"section\">
                <div class=\"container\">
                    <table class=\"table is-striped is-fullwidth concordance-table\">
                        <tr>
                            <th>Fichier</th>
                            <th>Contexte gauche</th>
                            <th>Cible</th>
                            <th>Contexte droit</th>
                        </tr>" > ${CONCFINAL}

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
    echo "Récupère le code HTTP du lien ${COUNT}"
    REPHTTP=$(curl -s -o /dev/null -w %{http_code} "$line")

    # Test pour les erreurs HTTP
    if [ "$REPHTTP" -eq 200 ]; then
        # Récupère l'encodage et le nombre de mots
        echo "Test pour les erreurs HTTP qui ne sont pas 200"
        ENCODAGE=$(curl -s -o /dev/null -w "%{content_type}" "${line}" | cut -d '=' -f2)
        WORD=$(lynx -dump "$line" | wc -w)
    
    # Ajout test pour 429 (trop de requêtes)
    elif [ "$REPHTTP" -eq 429 ] ; then
        echo "Test pour HTTP 429 -> pause de 3s"
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
    REWORD="nuages?"

    echo "Récupère la page... -> ${ASPIRATION}"
    if wget -q -O - "${line}" | sed '/<script[^>]*googleapis[^>]*>/,/<\/script>/d' > "${ASPIRATION}"; # Récupère la page
    then

        if [[ ${ENCODAGE,,} == "utf-8" ]]; # Si l'encodage est utf8
        then

            # Extraction du texte brut dans dump-text
            echo "Extraction du texte brut... -> ${DUMP}"
            lynx -dump ${ASPIRATION} > ${DUMP} 

            # Extraction du contexte autour du mot
            echo "Extraction du contexte autour du mot... -> ${CTXT}"
            cat ${DUMP}  | sed -E '/(https?:\/\/|file:\/\/\/|mailto:)/d' | sed -E '/^\*? *\[[0-9]+\]$/d' | grep -iE ${REWORD} -C2 > ${CTXT} # sed pour nettoyer les urls dans les pages
            # cat ${DUMP} | grep  -i -E ${REWORD} -C2 > ${CTXT} # -i ignore-case

        else
            # Capture l'encodage source (qui n'est pas utf8)
            echo "Mauvaise encodage, capture l'encodage..."
            CODESOURCE=$(file --mime-encoding ${ASPIRATION} | cut -d ' ' -f2 | tr "[:lower:]" "[:upper:]" ) # Ne prends que l'encodage
            
            # Change l'encodage en UTF-8 si nécessaire
            if [[ ${CODESOURCE} != "UTF-8" ]];
            then
                echo "Conversion et extraction de la page..."
                # Fichier de sauvegarde après conversion
                UTF8="../aspirations/fr-${COUNT}-utf8.html"
                # Conversion encodage source à utf8
                iconv -f ${CODESOURCE} -t UTF-8 ${ASPIRATION} -o ${UTF8}
                rm ${ASPIRATION}

                # Extraction
                lynx -dump ${UTF8} > ${DUMP}
                cat ${DUMP} | sed -E '/(https?:\/\/|file:\/\/\/|mailto:)/d' | grep -iE ${REWORD} -C2 > ${CTXT} 
        
            fi
        fi
    fi  

    # Construction du fichier concordance
    echo "Construction du fichier concordance..."
    CONCORD="../concordances/fr-${COUNT}.html" # Concordance
    echo -e "<html>
    <head>
        <meta charset=\"UTF-8\">
        <title>Liste de concordances</title>
        <link rel=\"stylesheet\" href=\"../../assets/css/style.css\"/>
        <link
        rel=\"stylesheet\"
        href=\"https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/versions/bulma-no-dark-mode.min.css\">
        <style>
            /* Alignement des en-têtes */
            .concordance-table th:nth-child(2) { text-align: right; width: 40%; }
            .concordance-table th:nth-child(3) { text-align: center; width: 20%; color: red; font-weight: bold; }
            .concordance-table th:nth-child(4) { text-align: left; width: 40%; }
            .concordance-table th:nth-child(1) { text-align: center; color: #999; }
            
            /* Alignement des élément dans tableau */
            .concordance-table td:nth-child(2) { text-align: right; width: 40%; }
            .concordance-table td:nth-child(3) { text-align: center; width: 20%; color: red; font-weight: bold; }
            .concordance-table td:nth-child(4) { text-align: left; width: 40%; }
            .concordance-table td:nth-child(1) { text-align: center; color: #999; }
        </style>
    </head>

    <body>
        <section class=\"hero is-medium is-primary\">
            <div class=\"hero-body\">
                <div class=\"container\">
                    <h1 class=\"title is-1\">Tableau des concordances</h1>
                    <h2 class=\"subtitle is-3\">Corpus français ${COUNT}</h2>
                </div>
            </div>
        </section>
        <nav class=\"navbar\" role=\"navigation\" aria-label=\"main navigation\"> 
            <div class=\"navbar-brand\">
                <p class="navbar-item">
                    <img src=\"../assets/img/cloud.png\" alt=\"Cloud\" style=\"max-height: 40px;\">
                </p>

                <a role=\"button\" class=\"navbar-burger\" aria-label=\"menu\" aria-expanded=\"false\" data-target=\"navbarBasicExample\">
                <span aria-hidden=\"true\"></span>
                <span aria-hidden=\"true\"></span>
                <span aria-hidden=\"true\"></span>
                <span aria-hidden=\"true\"></span>
                </a>
            </div>

            <div id=\"navbarBasicExample\" class=\"navbar-menu\">
                <div class=\"navbar-start\">
                    <a class=\"navbar-item\" href=\"../index.html\">
                        Home
                    </a>

                    <!-- Analyse -->
                <div class=\"navbar-item has-dropdown is-hoverable\">
                    <a class=\"navbar-link\">Analyse</a>

                    <div class=\"navbar-dropdown\">
                        <a class=\"navbar-item\" href=\"../fr_analyse.html\">Français</a>
                        <a class=\"navbar-item\" href=\"../zh_analyse.html\">Chinois</a>
                    </div>
                </div>

                <!-- Script -->
                <div class=\"navbar-item has-dropdown is-hoverable\">
                    <a class=\"navbar-link\">Script</a>

                    <div class=\"navbar-dropdown\">
                        <a class=\"navbar-item\" href=\"../fr_script.html\">Français</a>
                        <a class=\"navbar-item\" href=\"../zh_script.html\">Chinois</a>
                    </div>
                </div>

                <!-- Tableau -->
                <div class=\"navbar-item has-dropdown is-hoverable\">

                    <a class=\"navbar-link\">Tableau</a>
                    <div class=\"navbar-dropdown\">
                        <a class=\"navbar-item\" href=\"../tableaux/tableau-fr.html\">Français</a>
                        <a class=\"navbar-item\" href=\"../tableaux/tableau-zh.html\">Chinois</a>
                        <a class=\"navbar-item\" href=\"../blacklist.html\">Blacklist</a>
                        <a class=\"navbar-item\" href=\"../make_pals_corpus.html\">PALS</a>
                    </div>
                </div>

                <div class=\"navbar-item has-dropdown is-hoverable\">
                    <a class=\"navbar-link\">Concordances</a>

                    <div class=\"navbar-dropdown\">
                        <a class=\"navbar-item\" href=\"../concordances/fr-final.html\">Français</a>
                        <a class=\"navbar-item\" href=\"../concordances/zh-final.html\">Chinois</a>
                    </div>           
                </div>
            </div>
            <div class=\"navbar-end\">
                <div class=\"navbar-item\">
                    <div class=\"buttons\">
                        <button class=\"button is-primary\" onclick=\"history.back();\">Retour</button>
                    </div>
                </div>
            </div>
        </nav>

        <section class=\"section\">
            <div class=\"container\">
                <table class=\"table is-striped is-fullwidth concordance-table\">
                <tr>
                    <th>Fichier</th>
                    <th>Contexte gauche</th>
                    <th>Cible</th>
                    <th>Contexte droit</th>
                </tr>
    " > ${CONCORD}

    echo "Compte le nombre d'occurrence de 'nuage'..."
    WORDCOUNT=$(cat ${CTXT} | grep -i -o "nuage" | wc -l) # Nombre d'occurrence "nuage" dans le texte

    echo "Complète le tableau de concordance..."
    sed -nE "s#^(.*)(nuages?)(.*)#\t\t\t\t\t<tr><td>${COUNT}</td><td><span style=\"text-align:right;\">\1</span></td><td><span style=\"color:red;\">\2</span></td><td><span style=\"text-align:left;\">\3</span></td></tr>#Ip" ${CTXT} | tee -a ${CONCORD} ${CONCFINAL} > /dev/null

    # Bigrammes
    # Liste de fréquences de bigrammes
    MOT="../bigrammes/mots/mot-${COUNT}.txt"
    MOTSHIFT="../bigrammes/mots-shift/fr-mot_shift-${COUNT}.txt"
    BIGRAM="../bigrammes/bigramme/fr-bigramme-${COUNT}.txt"
    FREQ="../bigrammes/result/fr-freq_bigram-${COUNT}.txt"

    echo "Génération des fréquences de bigrammes..."
    # Nettoyage + transformation en liste de mots (1 par ligne)
    tr -cs 'A-Za-zÀ-ÖØ-öø-ÿ' '\n' < "${CTXT}" | tr 'A-Z' 'a-z' > ${MOT}

    # Génération des bigrammes avec paste
    tail -n +2 ${MOT} > ${MOTSHIFT}
    paste -d " " ${MOT} ${MOTSHIFT} > ${BIGRAM}

    # Comptage des fréquences
    sort ${BIGRAM} | uniq -c | sort -nr > ${FREQ}

    echo "Complète le tableau final..."
    # Complète le tableau
    echo "                      <tr>
                        <td>${COUNT}</td> <!-- numéro de ligne -->
                        <td><a href=\"${line}\">${line}</a></td> <!-- lien url -->
                        <td>${REPHTTP}</td> <!-- code http -->
                        <td>${ENCODAGE}</td> <!-- encodage de la page -->
                        <td>${WORD}</td> <!-- nombre de mot total -->
                        <td>${WORDCOUNT}</td> <!-- nombre d'occurrence de nuage(s) -->
                        <td><a href=\"${CTXT}\">Contexte</a></td> <!-- lien vers le contexte autour de nuage (.txt) -->
                        <td><a href=\"${CONCORD}\">Concordance</a></td> <!-- lien vers la concordance de nuage -->
                        <td><a href=\"${FREQ}\">Bigramme</a></td> <!-- lien vers la liste de fréquences de bigrammes -->" >> ${OUTFILE}

    echo "Capture et test avec le fichier robots.txt..."
    # Gestion des fichiers robots.txt -> blacklist.sh
    # Le fichier général : tmp/fr.txt-blacklist
    BLACKLIST="../tmp/fr.txt-blacklist"
    server=$(echo "$url" | awk -F/ '{print $1"//"$3}')
    ROBOT_FILE=$(ls ../tmp/robots/*$(echo ${server} | sed 's|://|_|; s|/||g')-robots.txt 2>/dev/null || echo "")

    if grep -Fxq "$line" "$BLACKLIST"; then
        echo -e "\t\t\t\t\t\t\t\t<td><p>Présent<br>Accès non autorisé</p> <!-- Vérification blacklist -->" >> ${OUTFILE}
    else 
        if [ -n "$ROBOT_FILE" ];then
            echo -e "\t\t\t\t\t\t\t\t<td><p>Présent<br>Accès autorisé</p> <!-- Vérification blacklist -->" >> ${OUTFILE}
        else
            echo -e "\t\t\t\t\t\t\t\t<td><p>Asbent<br>Autorisé par défaut</p> <!-- Vérification blacklist -->" >> ${OUTFILE}
        fi 
    fi

    echo -e "               </table>
            </div>
        </section>
    </body>
</html>" >> ${CONCORD}

done < "$URL" ;

echo -e "               </table>
            </div>
        </section>
    </body>
</html>" | tee -a ${OUTFILE} ${CONCFINAL} > /dev/null # Fin des deux fichiers html

