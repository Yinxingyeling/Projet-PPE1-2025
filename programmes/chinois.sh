#!/usr/bin/bash

URL=$1
COUNT=0
OUTFILE="../tableaux/tableau-zh.html" # Fichier de sauvegarde
CONCFINAL="../concordances/zh-final.html"

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
                <h2 class=\"subtitle is-3\">Corpus chinois</h2>
                </div>
            </div>
        </section>
        <nav class=\"navbar\" role=\"navigation\" aria-label=\"main navigation\">
            <div class=\"navbar-brand\">
                <p class="navbar-item is-size-4" style=\"cursor: default;\">☁️</p>

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
                            <a class=\"navbar-item is-selected has-background-link-light\" href=\"../tableaux/tableau-zh.html\">Chinois</a>
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
                .concordance-table th:nth-child(2) { text-align: right; width: 45%; }
                .concordance-table th:nth-child(3) { text-align: center; width: 10%; color: red; font-weight: bold; }
                .concordance-table th:nth-child(4) { text-align: left; width: 45%; }
                .concordance-table th:nth-child(1) { text-align: center; color: #999; }
                
                /* Alignement des élément dans tableau */
                .concordance-table td:nth-child(2) { text-align: right; width: 45%; }
                .concordance-table td:nth-child(3) { text-align: center; width: 10%; color: red; font-weight: bold; }
                .concordance-table td:nth-child(4) { text-align: left; width: 45%; }
                .concordance-table td:nth-child(1) { text-align: center; color: #999; }
            </style>
        </head>

        <body>
            <section class=\"hero is-medium is-primary\">
                <div class=\"hero-body\">
                    <div class=\"container\">
                        <h1 class=\"title is-1\">Tableau des concordances</h1>
                        <h2 class=\"subtitle is-3\">Corpus chinois</h2>
                    </div>
                </div>
            </section>
            <nav class=\"navbar\" role=\"navigation\" aria-label=\"main navigation\"> 
                <div class=\"navbar-brand\">
                    <p class="navbar-item is-size-4" style=\"cursor: default;\">☁️</p>

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
                            <a class=\"navbar-item\" href=\"../concordances/fr-final.html\">Français</a>
                            <a class=\"navbar-item has-background-link-light is-selected\" href=\"../concordances/zh-final.html\">Chinois</a>
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
    exit 1
fi


# Lis chaque ligne du fichier
while read -r line
do
    COUNT=$(expr "$COUNT" + 1)

    # Fichiers de sortie
    ASPIRATION="../aspirations/zh-${COUNT}.html" #Fichier html de la page téléchargé
    DUMP="../dumps-text/zh-${COUNT}.txt" # Texte brut de la page
    UTF8="../aspirations/zh-${COUNT}-utf8.html" #Page en utf-8
    CTXT="../contextes/zh-${COUNT}.txt" # Contexte autour du mot
    REWORD="云"

    # Récupère le code HTTP
    REPHTTP=$(curl -s -o /dev/null -w "%{http_code}" $line)

    # Ajout test pour 429 (trop de requêtes)
    if [ $REPHTTP -eq 429 ] || [ $REPHTTP -eq 000 ] || [ $REPHTTP -eq 503 ] ; then
        echo "Test pour HTTP 429/503/000 -> pause de 5s"
        sleep 5
        REPHTTP=$(curl -s -o /dev/null -w "%{http_code}" $line)
    fi

    if [ $REPHTTP -ne 200 ]; then
        echo "Test pour les erreurs HTTP qui ne sont pas 200"
        echo "<tr><td>$COUNT</td><td>$line</td><td>$REPHTTP</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>" >> ${OUTFILE}
        continue
    fi


    echo "Récupère la page... -> ${ASPIRATION}"
    # Si la page ne peut pas etre wget, presente la.
    if ! wget -q -O ${ASPIRATION} ${line};
    then
        echo "wget echoue: ${line}"
        continue
    fi

    # Détection de l'encodage : certains sites chinois indiquent seulement "text/html"
    ENCODAGE=$(curl -s -I "$line" | grep -i "content-type" | sed -n 's/.*charset=\([-a-zA-Z0-9]*\).*/\1/p' | tr -d '\r' | tr '[:lower:]' '[:upper:]')
    # Suppression des caractères de retour chariot (\r) provenant des en-têtes HTTP Windows

    # Si aucun encodage n’est indiqué dans l’en-tête HTTP
    if [ -z "$ENCODAGE" ]; then
        ENCODAGE=$(file --mime-encoding ${ASPIRATION} | cut -d: -f2 | tr -d " ")
    fi

    ENCODAGE=${ENCODAGE^^} #Majuscule

    #Unifier l'encodage
    iconv -f ${ENCODAGE} -t "UTF-8//IGNORE" ${ASPIRATION} -o ${UTF8} 2>/dev/null

    # Extraction du texte brut
    # -force_html nécessaire pour certains sites chinois qui ne déclarent pas correctement l'encodage dans les en-têtes HTTP
    # sed et grep pour essayer de supprimer des bruits du texte
    lynx -dump -nolist -force_html "${UTF8}" | sed 's/^[[:space:]]\+//' | sed '/^\s*$/d' \
    | grep -v -E "^\[.*\.(png|jpg|jpeg|gif|svg)\]" \
    | grep -v -E "^\[\?url=|thumbnail=|quality=|type=jpg" \
    | grep -v -E "打开.*新闻|查看精彩图片|打开APP|体验更佳" \
    | grep -v -E "下载客户端|登录|无障碍" \
    | grep -v -E "\(BUTTON\)|查看更多|开始答题" \
    | grep -v -E "^(热搜|热门跟贴|相关推荐|相关新闻|新闻排行榜)" \
    | grep -v -E "^[0-9]+条跟贴|跟贴$" \
    | grep -v -E "^(首页|当前位置|回到顶部|回到首页)" \
    | grep -v -E "^当前位置|^上一篇|^下一篇" \
    | grep -v -E "打印文章|关闭页面|返回顶部" \
    | grep -v -E "设为首页|加入收藏|关注我们|扫描此二维码|网站首页|搜索$" \
    | grep -v -E "^(关于我们|我们的历史|我们的工作|科学中心|资源分享|新闻中心|工作机会|机构介绍|联系我们|领域|地域|招聘信息)$" \
    | grep -v -E "^友情链接|\[===.*===\]" \
    | grep -v -E "微信|二维码|手机版|官方微信" \
    | grep -v -E "©|版权所有|未经授权|责任编辑|校对" \
    | grep -v -E "ICP|公网安备|备案号|互联网新闻信息服务许可证" \
    | grep -v -E "主办|承办|协办|地址：|邮编：|电话：|传真：|邮箱" \
    | grep -v -E "^(IFRAME:|\[USEMAP:)" \
    | grep -v -E "^[\*\+]\s+" \
    > "${DUMP}"

    # Si dump invalide, ignore le lien
    if [ ! -s ${DUMP} ]; then
        echo "Dump vide : ${line}"
        echo "<tr><td>${COUNT}</td><td>${line}</td><td>${REPHTTP}</td><td>${ENCODAGE}</td><td>0</td><td>0</td><td>Non exploitable</td><td>-</td><td>-</td><td>-</td></tr>"\
        >> ${OUTFILE}
        continue
    fi

    # Tokenisation chinoise
    MOT="../bigrammes/mots/zh-mot-${COUNT}.txt" #un mot en chinois n'est pas un caractere, et alors il faut segmenter le texte en mot avant de compter le nombre de mot
    if ! python ../ressources/tokenization/Chinois/tokenize_chinese.py ${DUMP} | tr " " "\n" | sed '/^$/d' > ${MOT} 2>/dev/null;
    then
        echo "tokenisation echouee: ${line}"
        continue
    fi

    # Comptages
    echo "Compte le nombre d'occurrence de '云'..."
    WORD=$(grep -v -E "^[[:punct:]]+$" ${MOT} | wc -l) #ignore les ponctuations
    WORDCOUNT=$(grep -c ${REWORD} ${MOT})

    # Bigrammes sur token
    MOTSHIFT="../bigrammes/mots-shift/zh-mot_shift-${COUNT}.txt"
    BIGRAM="../bigrammes/bigramme/zh-bigramme-${COUNT}.txt"
    FREQ="../bigrammes/result/zh-freq_bigram-${COUNT}.txt"

    echo "Génération des fréquences de bigrammes (chinois)..."

    #suppression des ponctuations dans les bigrammes
    grep -v -E "^[[:punct:]]+$" "${MOT}" | tee "${MOT}_nopunct" > /dev/null

    # Génération des bigrammes avec paste
    # MOT = TOKEN (1 mot chinois par ligne)
    tail -n +2 "${MOT}_nopunct" > ${MOTSHIFT}
    paste -d " " "${MOT}_nopunct" ${MOTSHIFT} > ${BIGRAM}

    # Comptage des fréquences
    sort ${BIGRAM} | uniq -c | sort -nr > ${FREQ}

    # Contexte sur le texte brut
    grep -C 2 ${REWORD} ${DUMP} > ${CTXT}

    rm -f "${MOT}_nopunct"

    if [ ! -s ${CTXT} ]; then
        continue
    fi

    # Construction du fichier concordance
    CONCORD="../concordances/zh-${COUNT}.html" # Concordance
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
                .concordance-table th:nth-child(2) { text-align: right; width: 45%; }
                .concordance-table th:nth-child(3) { text-align: center; width: 10%; color: red; font-weight: bold; }
                .concordance-table th:nth-child(4) { text-align: left; width: 45%; }
                .concordance-table th:nth-child(1) { text-align: center; color: #999; }
                
                /* Alignement des élément dans tableau */
                .concordance-table td:nth-child(2) { text-align: right; width: 45%; }
                .concordance-table td:nth-child(3) { text-align: center; width: 10%; color: red; font-weight: bold; }
                .concordance-table td:nth-child(4) { text-align: left; width: 45%; }
                .concordance-table td:nth-child(1) { text-align: center; color: #999; }
            </style>
        </head>

        <body>
            <section class=\"hero is-medium is-primary\">
                <div class=\"hero-body\">
                    <div class=\"container\">
                        <h1 class=\"title is-1\">Tableau des concordances</h1>
                        <h2 class=\"subtitle is-3\">Corpus chinois ${COUNT}</h2>
                    </div>
                </div>
            </section>
            <nav class=\"navbar\" role=\"navigation\" aria-label=\"main navigation\"> 
                <div class=\"navbar-brand\">
                    <p class="navbar-item is-size-4" style=\"cursor: default;\">☁️</p>

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

    if [ -s ${CTXT} ]; then
        echo "Complète le tableau de concordance..."
        # sed : guillemets doubles nécessaires pour l’expansion des variables
        sed -nE "s/^(.*)(${REWORD})(.*)$/<tr><td>${COUNT}<\/td><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/p" ${CTXT} | tee -a ${CONCORD} ${CONCFINAL} > /dev/null
    fi
    echo "</tbody></table></div></section></body></html>" >> "${CONCORD}"

    echo "Complète le tableau final..."
    # Complète le tableau
    echo "           <tr>
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
    # Le fichier général : tmp/zh.txt-blacklist

    BLACKLIST="../tmp/zh.txt-blacklist"

    # extraction du serveur à partir de l'URL
    server=$(echo $line | awk -F/ '{print $1"//"$3}')

    # fichier robots correspondant (s'il existe)
    ROBOT_FILE=$(ls ../tmp/robots/*$(echo "${server}" | sed 's|://|_|; s|/||g')-robots.txt 2>/dev/null || echo "")

    if grep -Fxq "$line" $BLACKLIST; then
        echo -e "\t\t\t\t\t\t\t\t<td><p>Présent<br>Accès non autorisé</p ></td>" >> "${OUTFILE}"
    else
        if [ -n "$ROBOT_FILE" ]; then
            echo -e "\t\t\t\t\t\t\t\t<td><p>Présent<br>Accès autorisé</p ></td>" >> "${OUTFILE}"
        else
            echo -e "\t\t\t\t\t\t\t\t<td><p>Absent<br>Autorisé par défaut</p ></td>" >> "${OUTFILE}"
        fi
    fi

    echo "</tr>" >>${OUTFILE}

done < "$URL" ;

echo -e "          </table>
            </div>
        </section>
    </body>
</html>" | tee -a ${OUTFILE} ${CONCFINAL} > /dev/null # Fin des deux fichiers html
