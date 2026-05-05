HISTSIZE=1000000000
SAVEHIST=1000000000
setopt APPEND_HISTORY
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_LEX_WORDS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys" # set by `omz`
plugins=(
    alias-finder
    aliases
    git
    globalias
    vi-mode
)
source $ZSH/oh-my-zsh.sh

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
MODE_INDICATOR="%{$terminfo[bold]%}%F{magenta}<<< NORMAL%f%{$reset_color%}%"
INSERT_MODE_INDICATOR="%{$terminfo[bold]%}%F{green}+++ INSERT%f%{$reset_color%}%"

unalias grep
unalias ls
unalias rd

zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

source ~/.secrets
source ~/.zsh_aliases

export EDITOR=vim
export MSYS=winsymlinks:nativestrict
export DISABLE_AUTO_TITLE=true
export LESS='-RFX'

eval "$(/opt/homebrew/bin/brew shellenv)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/util-linux/bin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/util-linux/sbin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOME/Projects/depot_tools:$PATH"

MANPATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman:$MANPATH"
MANPATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnuman:$MANPATH"
MANPATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnuman:$MANPATH"
export MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:${MANPATH}"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

export PATH="$HOME/.local/bin:$PATH"

autoload bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then . ~/google-cloud-sdk/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then . ~/google-cloud-sdk/completion.zsh.inc; fi
