#!/bin/bash
script_dir=$(dirname "$(readlink -e "$0")")
file_css="$script_dir/fonts.css"
file_html="$script_dir/demo.html"

cat > $file_css <<EOL
*{
    font-size: 1.1em;
}
p{
    padding: 5px 20px;
    line-height: 27px;
    height: 27px;
    display: block;
    margin: 0;
}
td{
    overflow: hidden;
}
EOL

cat > $file_html <<EOL
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<title>Font preview</title>
<link rel="stylesheet" href="fonts.css" />
</head>
<body>
    <table>
EOL

n=0
from=1
to=100

for file in $script_dir/*.woff; do

    n=$((n+1))
    if [[ $n -lt $from || $n -gt $to ]]; then
        continue
    fi

    name=$(basename $file)
    name="${name%.*}"
    echo $name

    cat >> $file_css <<EOL
@font-face{
    font-family: "${name}";
    font-style: normal;
    font-weight: 400;
    src: url("${name}.woff") format('woff');
}
EOL

    #Өнөөдөрүдшээрмаргаашнөгөөдөруржигдар
    #Сүүлийн үед эрчимтэй хөгжиж байгаа хиймэл оюуны салбар олон тооны ажлын байрыг булаана, эцэстээ хүн төрөлхтөнд аюул занал учруулна гэсэн ойлголт нийгэмд тархаад байгаа.
    cat >> $file_html <<EOL
    <tr>
        <td>${name}</td>
        <td><p style="font-family: '${name}', courier">Ñ¿¿ëèéí ¿åä ýð÷èìòýé õºãæèæ áàéãàà õèéìýë îþóíû ñàëáàð îëîí òîîíû àæëûí áàéðûã áóëààíà, ýöýñòýý õ¿í òºðºëõòºíä àþóë çàíàë ó÷ðóóëíà ãýñýí îéëãîëò íèéãýìä òàðõààä áàéãàà.</p></td>
    </tr>
EOL

done


cat >> $file_html <<EOL
    </table>
</body>
</html>
EOL
