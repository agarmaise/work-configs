#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

where brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install bash coreutils docker findutils gh git gnu-sed grep jq todo-txt tmux tmuxinator util-linux wget yarn
brew install --cask alt-tab font-sauce-code-pro-nerd-font iterm2 raycast rectangle scroll-reverser visual-studio-code
