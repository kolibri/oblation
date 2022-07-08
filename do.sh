#!/bin/bash

set -e

helptext () {
  echo "./do.sh meet          # create a new meeting file"
  echo "./do.sh sacrifice     # choose someone from members.txt"

  echo "\nHints:"
  echo "subl \`./do.sh meet\` # to directly open the file in editor"
}

run_action () {
  ACTIONS=$1
  if [[ "meet" = $ACTIONS ]]; then
    export DATE=`date '+%Y-%m-%d'`
    NEW_PATH="./dev-meetings/${DATE}.md"
    if [ ! -f $NEW_PATH ]; then
      envsubst '$DATE' < ./_templates/dev-meeting.md > $NEW_PATH
      echo $NEW_PATH
    else 
      echo "File already exists"
    fi
  elif [[ "sacrifice" = $ACTIONS ]]; then
    sort -R members.txt | head -n1
  elif [[ "help" = $ACTIONS ]]; then
    helptext
  else
    echo "There was no action to perform."
    echo "Maybe, this will help you consider, what you want to perform"

    helptext
    exit 1
  fi
}

run_board_cmd () {
    docker-compose run board $@
}

run_action $@
