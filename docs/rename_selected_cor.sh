#!/bin/bash

for pasta in */ ; do
    nome=$(basename "$pasta")
    arquivo_csv="${pasta}${nome}.csv"
    arquivo_saida="${pasta}${nome}_cor_modified.csv"

    if [ -f "$arquivo_csv" ]; then
        echo "Processando $arquivo_csv"

        awk -F'\t' '
        BEGIN {OFS="\t"}
        NR==1 {
            print $0, "weight_adj"
            next
        }
        {
            weight = $3 + 0
            print $0, weight + 1
        }' "$arquivo_csv" > "$arquivo_saida"

        echo "Criado: $arquivo_saida"
    else
        echo "Arquivo não encontrado: $arquivo_csv"
    fi
done

