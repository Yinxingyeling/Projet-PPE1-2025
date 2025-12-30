#!/usr/bin/bash

URL=$1
Langue=$2
COUNT=$3

html="../aspirations/$Langue-$COUNT.html"
texte="../dumps-text/$Langue-$COUNT.txt"
utf8_texte="../dumps-text/$Langue-$COUNT-utf8.txt"
token_texte="../dumps-text/$Langue-$COUNT-token.txt"

wget -O  $html $URL

lynx -dump -nolist $html > $texte
encodage=$(file --mime-encoding $texte | cut -d: -f2 | tr -d " ")
if [ "$encodage" != "utf-8" ]; then
    iconv -f "$encodage" -t utf-8 $texte -o $utf8_texte
else
    cp $texte $utf8_texte #统一名称
fi

#tokenization
if [ "$Langue" = "zh" ]; then
    python ../ressources/tokenization/Chinois/tokenize_chinese.py $utf8_texte > $token_texte #这里用了上课使用的中文分词工具
elif [ "$Langue" = "fr" ]; then
    grep -oP "\p{L}+" $utf8_texte | tr "[:upper:]" "[:lower:]" > $token_texte
fi

# Compter les occurrences du mot étudié
if [ "$Langue" = "zh" ]; then
    Nbr_mot=$(grep -c "云" $token_texte) #因为中文词汇切分的时候云可能是包含在不同词汇里的，不能只找云单字，需要找包含云的词汇
elif [ "$Langue" = "fr" ]; then
    Nbr_mot=$(grep -c -E "^(nuages?)$" $token_texte)
fi

echo "$Nbr_mot"

#Contexte
contexte="../Contexte/$Langue-$COUNT.txt"
if [ "$Langue" = "zh" ]; then
    grep -C 2 "云" $utf8_texte > $contexte #-C 2 取前后2行
elif [ "$Langue" = "fr" ]; then
    grep -i -C 2 -E "nuages?" $utf8_texte > $contexte #-i避免大写搜不到
fi

#Concordances
concordance="../concordances/$Langue-$COUNT.html"

echo -e "
<head>
  <meta charset=\"UTF-8\">
  <title>Liste de concordances</title>
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
  <th>Contexte gauche</th>
  <th>Cible</th>
  <th>Contexte droit</th>
</tr>
" > $concordance

if [ "$Langue" = "zh" ]; then
    sed -n 's#^\(.*\)\(云\)\(.*\)$#<tr><td>\1</td><td>\2</td><td>\3</td></tr>#p' $utf8_texte >> $concordance
    #sed/左/右/，是用左替换右，左侧正则分别对应关键词左侧、关键词和关键词右侧，分别对应右侧html表格的3列；sed -n关闭自动输出 “/p”输出匹配行（print）; -I忽视大小写
    #sed#左#右#，因为</>标签中有/，影响sed判断
    #sed后面有正则和标签，用单引号避免出错（双引号出错很多遍...）
elif [ "$Langue" = "fr" ]; then
    sed -n 's#^\(.*\)\(nuages\?\)\(.*\)$#<tr><td>\1</td><td>\2</td><td>\3</td></tr>#Ip' $utf8_texte >> $concordance
fi

echo "
</table>
</section>
</body>
</html>
" >> $concordance

