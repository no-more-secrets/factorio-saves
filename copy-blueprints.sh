#!/bin/bash
set -e
set -o pipefail

file=blueprint-storage.dat
from=~/games/factorio/$file
to=~/games/factorio-saves/$file

cp $from $to
rm $from
ln -s $to $from
