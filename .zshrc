export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys-avery" # set by `omz`
plugins=(git aliases alias-finder)
source $ZSH/oh-my-zsh.sh

unalias grep

zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

source ~/.secrets

export EDITOR=vim
export MSYS=winsymlinks:nativestrict
export DISABLE_AUTO_TITLE=true
export LESS='-RFX'

alias todo="todo.sh"
alias tla="todo ls -+1:1"

alias -g wb="/Applications/WebStorm.app/Contents/MacOS/webstorm"
alias xwb="xargs wb"
alias kwb="ps -e | grep '/Applications/WebStorm.app/Contents/MacOS/webstorm' | head -1 | awkp 1 | xargs kill -9"
alias xvim="xargs -o vim"

alias vz="vim ~/.zshrc"
alias sz="source ~/.zshrc"

awkp() { awk -v i=$1 '{ print (i == "NF" ? $NF : $i) }' }

alias yarna="TARGETS=assets yarn start:standalone"
alias yarnia="yarn install && yarna"
alias cdusd="cd ~/Projects/unity-services-dashboard"
alias cdmw="cd ~/Projects/asset-cloud-frontend-services"

alias jqts-raw="jq '.[] | select(.fileName == \"udash.assets\") | .messages | del(.[] | .locales | .de_DE, .fr_FR, .pt_BR, .ru_RU, .es_XN) | map(select(.locales | .ja_JP and .ko_KR and .zh_CN | not)) | del(.[] | .locales)'"
alias jqts="curl https://cdn.cloud.unity.com/translation-status/translation-status.json | jqts-raw"
alias jqtsl="jqts-raw translation-status.json"

alias ghopen="start \`git remote -v | grep fetch | sed -r 's/.*git@(.*):(.*)\.git.*/http:\/\/\1\/\2/' | head -n1\`"
alias chrome-dev="open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir='/tmp/chrome_dev_test' --disable-web-security"

alias -g gcg="git checkout --guess"
alias gitf="git status -s | sed s/...//"
alias gitfr='gitf | awk '\''{ print ($3 == "") ? $1 : $3; }'\'
alias gitd="git diff $(git_main_branch) --merge-base --name-only"
alias clorig="git clean -fdx --exclude node_modules -- '*.orig'"
alias cljs="git clean -fdx --exclude node_modules -- '*.js'"
alias gitmi="git for-each-ref refs/heads --exclude='**/$(git_main_branch)' --format='%(authorname)%09%(refname:short)' | grep -i avery | awk -F\t '{ print \$2 }'"
alias gitnm="git for-each-ref refs/heads --exclude='**/$(git_main_branch)' --format='%(authorname)%09%(refname)' | grep -iv avery | grep -oP '(?<=refs/heads/)(.*)'"
alias gitbv="git branch -vv"
alias gitr="git hash-object -t tree /dev/null"
gitum () {
    git checkout $(git_develop_branch) && git push && git checkout $(git_main_branch) && git merge $(git_develop_branch) && git push && git checkout $(git_develop_branch)
}

alias tspec="sed -r -e 's/^([^.]*)(\.spec)?(\.\w+)$/\1\3\n\1.spec\3/' | sort | uniq | paste -sd\| - | sed -r -e 's/^|$/'\''/g'"
alias spec="sed -r -e 's/^([^.]*)(\.spec)?(\.\w+)$/\1.spec\3/' | sort | uniq | paste -sd\| - | sed -r -e 's/^|$/'\''/g'"

alias jtest="xargs yarn test --noStackTrace --"
alias jtestcov="xargs -I{} yarn test --noStackTrace --coverage --collectCoverageFrom={} -- {}"
alias jtesta="yarn test --noStackTrace -- app/services/assets"
alias jtu="yarn test $WIP_FEATURE_PATH"

jtestcovf () {
    yarn test --noStackTrace --coverage --collectCoverageFrom="$1"'/**/*' -- "$1"
}

alias gitmm="git checkout $(git_main_branch) && git pull && git checkout - && git merge $(git_main_branch) --no-edit"
alias gitrb="git checkout $(git_main_branch) && git pull && git checkout - && git rebase $(git_main_branch)"
alias gitrba="git checkout $(git_main_branch) && git pull && gitmi | xargs -i sh -c 'git checkout {} && git rebase $(git_main_branch)'"

gitcb () {
	git remote update origin --prune > /dev/null 2>&1
    gone_branches=(${(f)"$(< <(git branch -vv | grep ': gone]' | awk '{ print $1 }'))"})

	if [ ${#gone_branches[@]} -gt 0 ]; then
		echo 'Branches to be deleted:'
		printf '%s\n' "${gone_branches[@]}"
		read 'response?'$'\n''Remove branches? (y/n) '
		if [[ "$response" =~ ^[yY]$ ]]; then
			printf '%s\n' "${gone_branches[@]}" | xargs -r git branch -D
		else
			echo 'Goodbye'
		fi
	else
		echo 'No branches deleted on remote'
	fi
}

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
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

ghcs() {
	FUNCNAME="$funcstack[1]"
	TARGET="shell"
	local GH_DEBUG="$GH_DEBUG"
	local GH_HOST="$GH_HOST"

	read -r -d '' __USAGE <<-EOF
	Wrapper around \`gh copilot suggest\` to suggest a command based on a natural language description of the desired output effort.
	Supports executing suggested commands if applicable.

	USAGE
	  $FUNCNAME [flags] <prompt>

	FLAGS
	  -d, --debug           Enable debugging
	  -h, --help            Display help usage
	      --hostname        The GitHub host to use for authentication
	  -t, --target target   Target for suggestion; must be shell, gh, git
	                        default: "$TARGET"

	EXAMPLES

	- Guided experience
	  $ $FUNCNAME

	- Git use cases
	  $ $FUNCNAME -t git "Undo the most recent local commits"
	  $ $FUNCNAME -t git "Clean up local branches"
	  $ $FUNCNAME -t git "Setup LFS for images"

	- Working with the GitHub CLI in the terminal
	  $ $FUNCNAME -t gh "Create pull request"
	  $ $FUNCNAME -t gh "List pull requests waiting for my review"
	  $ $FUNCNAME -t gh "Summarize work I have done in issues and pull requests for promotion"

	- General use cases
	  $ $FUNCNAME "Kill processes holding onto deleted files"
	  $ $FUNCNAME "Test whether there are SSL/TLS issues with github.com"
	  $ $FUNCNAME "Convert SVG to PNG and resize"
	  $ $FUNCNAME "Convert MOV to animated PNG"
	EOF

	local OPT OPTARG OPTIND
	while getopts "dht:-:" OPT; do
		if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
			OPT="${OPTARG%%=*}"       # extract long option name
			OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
			OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
		fi

		case "$OPT" in
			debug | d)
				GH_DEBUG=api
				;;

			help | h)
				echo "$__USAGE"
				return 0
				;;

			hostname)
				GH_HOST="$OPTARG"
				;;

			target | t)
				TARGET="$OPTARG"
				;;
		esac
	done

	# shift so that $@, $1, etc. refer to the non-option arguments
	shift "$((OPTIND-1))"

	TMPFILE="$(mktemp -t gh-copilotXXXXXX)"
	trap 'rm -f "$TMPFILE"' EXIT
	if GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot suggest -t "$TARGET" "$@" --shell-out "$TMPFILE"; then
		if [ -s "$TMPFILE" ]; then
			FIXED_CMD="$(cat $TMPFILE)"
			print -s -- "$FIXED_CMD"
			echo
			eval -- "$FIXED_CMD"
		fi
	else
		return 1
	fi
}

ghce() {
	FUNCNAME="$funcstack[1]"
	local GH_DEBUG="$GH_DEBUG"
	local GH_HOST="$GH_HOST"

	read -r -d '' __USAGE <<-EOF
	Wrapper around \`gh copilot explain\` to explain a given input command in natural language.

	USAGE
	  $FUNCNAME [flags] <command>

	FLAGS
	  -d, --debug      Enable debugging
	  -h, --help       Display help usage
	      --hostname   The GitHub host to use for authentication

	EXAMPLES

	# View disk usage, sorted by size
	$ $FUNCNAME 'du -sh | sort -h'

	# View git repository history as text graphical representation
	$ $FUNCNAME 'git log --oneline --graph --decorate --all'

	# Remove binary objects larger than 50 megabytes from git history
	$ $FUNCNAME 'bfg --strip-blobs-bigger-than 50M'
	EOF

	local OPT OPTARG OPTIND
	while getopts "dh-:" OPT; do
		if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
			OPT="${OPTARG%%=*}"       # extract long option name
			OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
			OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
		fi

		case "$OPT" in
			debug | d)
				GH_DEBUG=api
				;;

			help | h)
				echo "$__USAGE"
				return 0
				;;

			hostname)
				GH_HOST="$OPTARG"
				;;
		esac
	done

	# shift so that $@, $1, etc. refer to the non-option arguments
	shift "$((OPTIND-1))"

	GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot explain "$@"
}

# pnpm
export PNPM_HOME="/Users/avery.garmaise/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.local/bin:$PATH"
