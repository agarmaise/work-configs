#!/bin/bash

where brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install bash coreutils docker findutils gh git gnu-sed grep jq tmux tmuxinator util-linux wget yarn
brew install --cask alt-tab font-sauce-code-pro-nerd-font iterm2 raycast scroll-reverser visual-studio-code
