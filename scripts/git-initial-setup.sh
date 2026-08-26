#!/bin/bash

# Wire the dotfiles repo's local config to ~/.gitconfig_local, which supplies
# core.hooksPath and merge.ff for this repo only.
#
# The repo is bare at ~/dotfiles with $HOME as its work tree, so --git-dir has
# to be explicit: there is no .git in $HOME to discover.

git_dir="$HOME/dotfiles"
include_path="$HOME/.gitconfig_local"

if git --git-dir="$git_dir" config --local --get-all include.path |
  grep -qxF "$include_path"; then
  echo "include.path already set to $include_path"
  exit 0
fi

git --git-dir="$git_dir" config --local --add include.path "$include_path"
echo "added include.path $include_path"
