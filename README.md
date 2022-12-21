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