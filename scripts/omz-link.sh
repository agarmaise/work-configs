#!/bin/zsh

ZSH_LOCAL_CUSTOM=~/.config/oh-my-zsh/custom
find $ZSH_LOCAL_CUSTOM/themes -maxdepth 1 -name '.*' -prune -o -type f -exec bash -c 'ln -s $0 '"$ZSH"'/custom/themes/$(basename $0)' {} \;
find $ZSH_LOCAL_CUSTOM/plugins -mindepth 1 -maxdepth 1 -type d -exec bash -c 'ln -s $0 '"$ZSH"'/custom/plugins' {} \;
