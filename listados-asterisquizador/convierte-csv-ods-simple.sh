#!/bin/bash
#

ruta_a_csv="generados-csv-simple/"
ruta_a_ods="generados-ods-simple"

echo " * Cleaning old files "
mkdir -p ${ruta_a_ods}/
rm -rf ${ruta_a_ods}/*


for f in $(find $ruta_a_csv -xtype f); do

    echo " * Working with ${f}"
    soffice --convert-to ods "${f}" --outdir "${ruta_a_ods}/"

done



#
