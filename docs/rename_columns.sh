#!/bin/bash

# Loop por cada subpasta no diretório atual
for pasta in */ ; do
    echo "Modificando arquivos em $pasta"

    for arquivo in "median_correlation2.tsv" "pvalues2.tsv"; do
        caminho_arquivo="${pasta}${arquivo}"

        # Verifica se o arquivo existe antes de modificar
        if [ -f "$caminho_arquivo" ]; then
            # Substitui apenas na primeira linha
            sed -i '1s/^#OTU ID/OTUID/' "$caminho_arquivo"
            echo "Arquivo modificado: $caminho_arquivo"
        else
            echo "Arquivo não encontrado: $caminho_arquivo"
        fi
    done
done
