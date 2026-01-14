#!/bin/bash

echo "Juntando Microdados partes no MICRODADOS_ENEM_2021.csv..."
echo ""

cat MicrodadosEnem-split-* > MICRODADOS_ENEM_2021.csv

echo ""
echo "Verificando a integridade do arquivo..."
echo ""

EXPECTED_SHA="84c1106219d195e458875be8e454d24cafc6424aeabea00a331bdd5cc5ac95d4"
FILE_TO_CHECK="MICRODADOS_ENEM_2021.csv"

ACTUAL_SHA=$(sha256sum "$FILE_TO_CHECK" | awk '{print $1}')

echo "SHA esperado: $EXPECTED_SHA"
echo "SHA calculado: $ACTUAL_SHA"
echo ""

if [ "$ACTUAL_SHA" = "$EXPECTED_SHA" ]; then
    echo "A verificacao do SHA corresponde. O arquivo e integro."
else
    echo "A verificacao do SHA falhou. O arquivo pode estar corrompido."
fi

echo ""
echo "concluido!"
