#!/bin/bash

SCRIPT=$PWD/labo3.pl
PROLOG=/usr/bin/prolog

#GOALS=main
#[ "$1" == '-d' ] || GOALS=${GOALS}',halt'

#exec $PROLOG -q -f "${SCRIPT}" -g $GOALS --
exec $PROLOG -q -f "${SCRIPT}" --
