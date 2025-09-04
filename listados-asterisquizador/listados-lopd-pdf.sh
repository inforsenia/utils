#!/bin/bash


# PRIMERO PILLAR EL PDF del listado
PDF_LISTADO=$1

pdftotext $PDF_LISTADO
TXT=$(echo $(basename $PDF_LISTADO) | cut -d "." -f1).txt
echo ${TXT}
cp ${TXT}  /tmp/INF_ALUMNOS.txt

./listados-lopd.sh > /tmp/listado.md
cat head.yml /tmp/listado.md > /tmp/doc.md



TEMPLATE_TEX_PD="./rsrc/templates/eisvogel.tex"
PANDOC_OPTIONS="-V fontsize=12pt -V mainfont="Ubuntu" --pdf-engine=xelatex "
pandoc --template $TEMPLATE_TEX_PD $PANDOC_OPTIONS --from markdown --listings -o listados-2025-lopd.pdf /tmp/doc.md

echo " Trabajo concluido aqui : $(readlink -f listados-2023-lopd.pdf)"
xdg-open  $(readlink -f listados-2023-lopd.pdf)

exit 0
