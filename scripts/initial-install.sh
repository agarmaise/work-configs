#!/bin/zsh -i

which omz &> /dev/null || zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

which nvm &> /dev/null || curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | zsh

which brew &> /dev/null || zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install \
  bash \
  coreutils \
  docker \
  findutils \
  gh \
  git \
  gnu-sed \
  grep \
  jq \
  ripgrep \
  tmux \
  tmuxinator \
  todo-txt \
  util-linux \
  wget

brew install --cask \
  alt-tab \
  docker-desktop \
  font-sauce-code-pro-nerd-font \
  iterm2 \
  keyclu \
  raycast \
  rectangle \
  scroll-reverser \
  visual-studio-code
