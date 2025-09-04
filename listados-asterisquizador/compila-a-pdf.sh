#!/bin/bash

TEMPLATE_TEX_PD="./rsrc/templates/eisvogel.tex"
PANDOC_OPTIONS="-V fontsize=10pt -V  --pdf-engine=xelatex "


for f in $(find ./generados/*.md); do 

	echo " * Working with $f"
	pandoc --template $TEMPLATE_TEX_PD $PANDOC_OPTIONS --from markdown -o $f.pdf $f

done


echo " Generamos ahora un pdf con todos "
for f in $(find ./generados/*.md); do 
    echo " * Concatenando : $f"  
    cat $f >> ./generados/todos.aux
done

echo " Compilando el pdf"
mv ./generados/todos.aux ./generados/todos.md
pandoc --template $TEMPLATE_TEX_PD $PANDOC_OPTIONS --from markdown -o ./generados/todos.pdf ./generados/todos.md


