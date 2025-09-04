#!/bin/bash
#

ruta_a_csv="generados-csv/"
ruta_a_ods="generados-ods"

echo " * Cleaning old files "
rm -rf ${ruta_a_ods}/*


for f in $(find $ruta_a_csv -xtype f); do

    echo " * Working with ${f}"
    soffice --convert-to ods "${f}" --outdir "${ruta_a_ods}/"

done



#
