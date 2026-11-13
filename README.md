# My .files

My dotfiles, managed by [chezmoi](https://www.chezmoi.io/)

## Setup

1. Install command line tools

   ```sh
   xcode-select --install
   ```

2. Install Homebrew, GPG, Chezmoi and launch configuration

   ```sh
   # Install Homebrew
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   [[ $(arch) == "arm64" ]] && eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"

   # Install GPG and Chezmoi
   brew install gpg chezmoi

   # Use configuration from this repo
   chezmoi init tonivdv --apply
   ```

### Manage Homebrew packages

Package declarations live in `.chezmoitemplates/Brewfile`. Every `chezmoi apply` runs `brew bundle cleanup` without `--force`, followed by `brew bundle`.

Run apply from an interactive terminal so Homebrew can prompt before uninstalling anything. Declining cleanup, or any failure, stops the package script.

Use these switches to skip steps for a single apply:

```sh
SKIP_BREW=1 chezmoi apply          # Skip all Homebrew operations
SKIP_BREW_CLEANUP=1 chezmoi apply  # Install/update without cleanup
chezmoi apply --exclude=scripts   # Skip all chezmoi scripts
```

To run cleanup alone, run these commands from the chezmoi source directory:

```sh
(
  set -e
  brewfile="$(mktemp)"
  trap 'rm -f "$brewfile"' EXIT
  chezmoi execute-template < .chezmoitemplates/Brewfile > "$brewfile"
  brew bundle cleanup --file="$brewfile"
)
```

Cleanup considers packages installed manually too; keep everything you want to retain in the Brewfile. It also synchronizes Homebrew's trust entries with those declared in the Brewfile.

### Pull and apply latest changes from this repo

```sh
chezmoi update
```

### Edit files and push changes

For example, modify `~/.vimrc` (already managed by chezmoi)

```sh
chezmoi edit ~/.vimrc
```

Apply changes

```sh
chezmoi apply
```

Commit changes

```sh
chezmoi git add .
chezmoi git commit
chezmoi git push
```