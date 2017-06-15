#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

printf '\n\n\n\n ==== BUILD APPLICATION ===== \n\n\n\n'
$DIR/build.sh

printf "\n\n\n\n ==== DEPLOY APPLICATION ===== \n\n\n\n"
$DIR/deploy.sh

printf "\n\n\n\n ==== RUN APPLICATION ===== \n\n\n\n"
$DIR/run.sh
