#!/bin/bash


TEMPLATE_TEX_PD="./rsrc/templates/eisvogel.tex"
PANDOC_OPTIONS="-V fontsize=10pt -V  --pdf-engine=xelatex "

# Primero transformamos el PDF a txt y  luego procesamos cosas

#cat Listado1.txt | grep -v "^CENTRO" | grep -v "^DIRECC" | grep -v "^LOCAL"  | grep -v "LISTADO DE ALUMNOS"| grep -v "^$"| tr -s " "| grep -v "^Orden" | grep -v "^ Curso" | sed -e "s%GRUPO%   GRUPO%g" | cut -d " " -f4-| rev | cut -c 8- | rev | sed "s%GRUPO%\nGRUPO%g"

cat head.yml

cat listado-final.txt | while read line; do

    rc=0
    echo $line| grep -q "GRUPO:"|| rc=1

    if [ $rc -eq 0 ]; then
        echo ""
        echo "\newpage"
        echo "# $line"
        echo ""
        echo "| APELLIDOS | NOMBRE |"
        echo "|-----------|--------|"
    else
        echo -n "|"
        apellidos="$(echo $line|cut -d "," -f1)"
        apellidosLOPD=""
        for apellido in $apellidos; do
                # Obtener la parte del Apellido antes de la posición
                parte_antes="${apellido:0:2}"
                # Obtener la parte del Apellido a partir de la posición y transformarla en asteriscos
                parte_despues="${apellido:posicion}"
                parte_transformada="${parte_despues//?/*}"

                # Concatenar ambas partes
                apellidosLOPD="${apellidosLOPD}, ${parte_antes}${parte_transformada}"
        done

        nombre="$(echo $line|cut -d "," -f2)"
        apellidosLOPD=$(echo $apellidosLOPD | sed -e "s%^,%%g")
        echo "$apellidosLOPD | $nombre |" | sed -e "s%|,%|%g"
    fi

done

echo >&2 "pandoc --template $TEMPLATE_TEX_PD $PANDOC_OPTIONS --from markdown -o listado2025grupos.pdf" FICHERO.md
