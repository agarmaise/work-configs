#!/bin/bash
set -euo pipefail

# Bootstrap the dotfiles repo on a fresh machine.
#
# History ends up in ~/dotfiles as a bare repo; the work tree is $HOME itself,
# so the files stay where the programs that read them expect them.
#
# Usage: dotfiles-clone.sh [branch]   (default: dev)

repo="git@github.com:agarmaise/work-configs.git"
git_dir="$HOME/dotfiles"
branch="${1:-dev}"
backup="$HOME/.dotfiles-backup"

if [ -e "$git_dir" ]; then
  echo "$git_dir already exists - refusing to clobber it" >&2
  exit 1
fi

# Clone normally into a temp work tree rather than using --bare: a bare clone
# sets no remote.origin.fetch refspec, so remote-tracking branches never work.
# --separate-git-dir puts the history where we want it and leaves a .git
# pointer file behind in the temp dir.
tmp="$(mktemp -d "$HOME/dotfiles-tmp.XXXXXX")"
git clone --separate-git-dir="$git_dir" --branch "$branch" "$repo" "$tmp"

# --separate-git-dir records core.worktree = the temp dir. Leave it in place and
# every later git command dies trying to chdir to a directory we deleted. Edit
# the file directly with --file, since repo discovery would hit the same fault.
git config --file "$git_dir/config" --unset core.worktree
git config --file "$git_dir/config" core.bare true

# Move aside anything the incoming files would overwrite - a fresh macOS ships
# its own ~/.zshrc, for instance.
(cd "$tmp" && find . -path ./.git -prune -o -type f -print) |
  sed 's|^\./||' |
  while IFS= read -r file; do
    [ -e "$HOME/$file" ] || continue
    mkdir -p "$backup/$(dirname "$file")"
    mv "$HOME/$file" "$backup/$file"
    echo "backed up $file -> $backup/$file"
  done

rsync --archive --exclude '.git' "$tmp/" "$HOME/"
rm -rf "$tmp"

"$HOME/scripts/git-initial-setup.sh"

# The index was built against the temp work tree, so stat data is stale. This
# rehashes and reports clean if the contents match, which they should.
git --git-dir="$git_dir" --work-tree="$HOME" status --short --branch

cat <<'EOF'

Done. ~/.zsh_aliases already defines the alias, but for shells started before
this ran:

  alias dgit='git --git-dir=$HOME/dotfiles --work-tree=$HOME'
EOF
