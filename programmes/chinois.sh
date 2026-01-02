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
        <nav class=\"navbar\" role=\"navigation\" aria-label=\"main navigation\">
            <div class=\"navbar-brand\">
               <img class=\"navbar-item\" src=\"../assets/img/PPE.png\" alt=\"Logo PPE\">

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

                    <a class=\"navbar-item\">
                        Script
                    </a>
                    <div class=\"navbar-item has-dropdown is-hoverable\">
                    <a class=\"navbar-link\">Tableau</a>

                    <div class=\"navbar-dropdown\">
                        <a class=\"navbar-item is-selected\" href=\"../tableaux/tableau-fr.html\">Français</a>
                        <a class=\"navbar-item\" href=\"../tableaux/tableau-zh.html\">Chinois</a>
                    </div>
                </div>

                <!-- Menu 2 : Concordances -->
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
         <style>
            .concordance-table td:nth-child(2) { text-align: right; width: 45%; }
            .concordance-table td:nth-child(3) { text-align: center; width: 10%; color: red; font-weight: bold; }
            .concordance-table td:nth-child(4) { text-align: left; width: 45%; }
            .concordance-table td:nth-child(1) { width: 50px; text-align: center; color: #999; }
        </style>
    </head>

    <body>
        <section class=\"hero is-primary\">
            <div class=\"hero-body\">
                <div class=\"container\">
                    <h1 class=\"title\">Tableau des concordances</h1>
                </div>
                <nav class=\"navbar\" role=\"navigation\" aria-label=\"main navigation\">
            <div class=\"navbar-brand\">
                <img class=\"navbar-item\" src=\"../assets/img/PPE.png\" alt=\"Logo PPE\">

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

                    <a class=\"navbar-item\">
                        Script
                    </a>
                    <div class=\"navbar-item has-dropdown is-hoverable\">
                    <a class=\"navbar-link\">Tableau</a>

                    <div class=\"navbar-dropdown\">
                        <a class=\"navbar-item\" href=\"../tableaux/tableau-fr.html\">Français</a>
                        <a class=\"navbar-item\" href=\"../tableaux/tableau-zh.html\">Chinois</a>
                    </div>
                </div>

                <!-- Menu 2 : Concordances -->
                <div class=\"navbar-item has-dropdown is-hoverable\">
                    <a class=\"navbar-link\">Concordances</a>

                    <div class=\"navbar-dropdown\">
                        <a class=\"navbar-item is-selected\" href=\"../concordances/fr-final.html\">Français</a>
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
                <div class=\"centrer\">
                    <a href=\"../../index.html\" class=\"button accueil\">Accueil</a>
                </div>
            </div>
        </section>

        <section class=\"section\">
            <div class=\"container\">
                <table class=\"table is-striped is-fullwidth concordance-table\">

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
    TOKEN="../dumps-text/zh-${COUNT}-token.txt" #un mot en chinois n'est pas un caractere, et alors il faut segmenter le texte en mot avant de compter le nombre de mot
    REWORD="云"

    # Récupère le code HTTP
    REPHTTP=$(curl -s -o /dev/null -w "%{http_code}" $line)

    # Ajout test pour 429 (trop de requêtes)
    if [ $REPHTTP -eq 429 ] || [ $REPHTTP -eq 000 ] ; then
        sleep 3
        REPHTTP=$(curl -s -o /dev/null -w "%{http_code}" $line)
    fi

    if [ $REPHTTP -ne 200 ]; then
        echo "<tr><td>$COUNT</td><td>$line</td><td>$REPHTTP</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>" >> ${OUTFILE}
        continue
    fi

    # Si la page ne peut pas etre wget, presente la.
    if ! wget -q -O ${ASPIRATION} ${line};
    then
        echo "wget echoue: ${line}"
        continue
    fi

    #Detection de l'encodage : l'encodage de certains liens en chinois ne presente que "text/html"
    ENCODAGE=$(curl -s -I "$line" | grep -i "content-type" | sed -n 's/.*charset=\([-a-zA-Z0-9]*\).*/\1/p' | tr -d '\r' | tr '[:lower:]' '[:upper:]')
    #只提取行头\r回车符（windows）在http header里会出现在行后

    #如果Header里没有encodage
    if [ -z "$ENCODAGE" ]; then
        ENCODAGE=$(file --mime-encoding ${ASPIRATION} | cut -d: -f2 | tr -d " ")
    fi

    ENCODAGE=${ENCODAGE^^} #Majuscule

    #Unifier l'encodage
    iconv -f ${ENCODAGE} -t "UTF-8//IGNORE" ${ASPIRATION} -o ${UTF8} 2>/dev/null

    # Extraction du texte brut (-force_html: 中文网站中需要强制使用html模式)
    lynx -dump -nolist -force_html "${UTF8}" | sed '/^\s*$/d' \
    | grep -v -E "^\s*\[.*\.(png|jpg|jpeg|gif|svg)\]" \
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
    | grep -v -E "^\s*(关于我们|我们的历史|我们的工作|科学中心|资源分享|新闻中心|工作机会|机构介绍|联系我们|领域|地域|招聘信息)$" \
    | grep -v -E "^友情链接|\[===.*===\]" \
    | grep -v -E "微信|二维码|手机版|官方微信" \
    | grep -v -E "©|版权所有|未经授权|责任编辑|校对" \
    | grep -v -E "ICP|公网安备|备案号|互联网新闻信息服务许可证" \
    | grep -v -E "主办|承办|协办|地址：|邮编：|电话：|传真：|邮箱" \
    | grep -v -E "^\s*(IFRAME:|\[USEMAP:)" \
    | grep -v -E "^\s*[\*\+]\s+" \
    > ${DUMP}

    # Si dump invalide, ignore le lien
    if [ ! -s ${DUMP} ]; then
        echo "Dump vide : ${line}"
        echo "<tr><td>${COUNT}</td><td>${line}</td><td>${REPHTTP}</td><td>${ENCODAGE}</td><td>0</td><td>0</td><td>Non exploitable</td><td>-</td></tr>"\
        >> ${OUTFILE}
        continue
    fi

    # Tokenisation chinoise
    if ! python ../ressources/tokenization/Chinois/tokenize_chinese.py ${DUMP} | tr " " "\n" | sed '/^$/d' > "${TOKEN}" 2>/dev/null;
    then
        echo "tokenisation echouee: ${line}"
        continue
    fi

    # Comptages
    echo "Compte le nombre d'occurrence de 'nuage'..."
    WORD=$(grep -v -E "^[[:punct:]]+$" ${TOKEN} | wc -l) #ignore les ponctuations
    WORDCOUNT=$(grep -c ${REWORD} ${TOKEN})

    # Contexte (sur les tokens)
    grep -C 2 ${REWORD} ${DUMP} > ${CTXT}

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
            .concordance-table td:nth-child(2) { text-align: right; width: 40%; }
            .concordance-table td:nth-child(3) { text-align: center; width: 20%; color: red; font-weight: bold; }
            .concordance-table td:nth-child(4) { text-align: left; width: 40%; }
            .concordance-table td:nth-child(1) { text-align: center; color: #999; }
            </style>
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
                    <table class=\"table is-striped is-fullwidth concordance-table\">
                    <tr>
                        <th>Fichier</th>
                        <th>Contexte gauche</th>
                        <th>Cible</th>
                        <th>Contexte droit</th>
                    </tr>
    " > ${CONCORD}
    if [ -s ${CTXT} ]; then
        # 注意：sed 使用双引号解析变量
        sed -nE "s/^(.*)(${REWORD})(.*)$/<tr><td>${COUNT}<\/td><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/p" ${CTXT} | tee -a ${CONCORD} ${CONCFINAL} > /dev/null
    fi
    echo "</tbody></table></div></section></body></html>" >> "${CONCORD}"

    # Complète le tableau
    echo "                  <tr>
                            <td>${COUNT}</td> <!-- numéro de ligne -->
                            <td><a href=\"${line}\">${line}</a></td> <!-- lien url -->
                            <td>${REPHTTP}</td> <!-- code http -->
                            <td>${ENCODAGE}</td> <!-- encodage de la page -->
                            <td>${WORD}</td> <!-- nombre de mot total -->
                            <td>${WORDCOUNT}</td> <!-- nombre d'occurrence de nuage(s) en chinois -->
                            <td><a href=\"${CTXT}\">Contexte</a></td> <!-- lien vers le contexte autour de nuage en chinois(.txt) -->
                            <td><a href=\"${CONCORD}\">Concordance</a></td> <!-- lien vers la concordance de nuage en chinois -->
                        </tr>" >> ${OUTFILE}

done < "$URL" ;

echo -e "          </table>
            </div>
        </section>
    </body>
</html>" | tee -a ${OUTFILE} ${CONCFINAL} > /dev/null # Fin des deux fichiers html
