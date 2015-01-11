#!/bin/bash

RESULTS_FILE='results.txt'
CODE_FILE='labo3_exec.sh'

if [[ "$1" == '-f' ]]
then
    FORCE_RELOAD='true'
else
    FORCE_RELOAD='false'
fi

error() {
    echo "Se presento un error" >&2
    exit 1
}

exec_code() {
    echo "Obteniendo resultados"
    ./$CODE_FILE > $RESULTS_FILE || error
    echo "Resultados obtenidos"
}

accuracy() {
    local correct=$1
    local total=$2
    echo "scale=2; $correct * 100/$total" | bc
}

if [[ "$FORCE_RELOAD" == 'true' ]]
then
    exec_code
else
    [ -f $RESULTS_FILE ] || exec_code
fi

TOTAL=$(cat $RESULTS_FILE | wc -l)
NUM_OK=$(cat $RESULTS_FILE | grep -v void | wc -l)

echo "Numero total de lineas: $TOTAL"
echo "Numero de lineas correctas: $NUM_OK"
echo "Numero de lineas incorrectas: $(($TOTAL - $NUM_OK))"
echo "Accuracy: $(accuracy $NUM_OK $TOTAL)"
