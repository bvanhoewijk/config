#!/usr/bin/env bash

FILES=(bashrc vimrc minttyrc bash_aliases tmux.conf)
for FILE in ${FILES[*]}
do
  if [ -f "${HOME}/.$FILE" ]; then
     echo "File ${HOME}/.$FILE exists."
     echo "cp ${HOME}/.$FILE ${HOME}/.$FILE.backup"
  fi
  echo "cp $FILE ${HOME}/.$FILE"
done
