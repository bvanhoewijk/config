#!/usr/bin/env bash

FILES=(bashrc vimrc minttyrc bash_aliases tmux.conf)
for FILE in ${FILES[*]}
do
  if [ -f "${HOME}/.$FILE" ]; then
     echo "File ${HOME}/.$FILE.backup exists."
     echo "cp ${HOME}/.$FILE.backup ${HOME}/.$FILE"
     cp ${HOME}/.$FILE.backup ${HOME}/.$FILE
  fi
done
