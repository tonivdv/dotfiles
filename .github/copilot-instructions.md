# Copilot instructions

This is a [chezmoi](https://www.chezmoi.io/) source directory (`~/.local/share/chezmoi`) holding macOS dotfiles. Files here are templates/sources; they are not live config until applied to `$HOME`.

## Commands

There is no build, test, or lint suite. Use chezmoi to validate changes:

- `chezmoi diff` – preview what would change in `$HOME`
- `chezmoi apply` (or `chezmoi apply ~/.zshrc` for one target) – apply changes
- `chezmoi execute-template < run_onchange_1-install-packages.sh.tmpl` – render a template to check syntax (also works for `dot_gitconfig.tmpl`, `run_onchange_before_1-system.sh.tmpl`)
- `chezmoi update` – pull and apply the latest from the remote

## Architecture

Naming follows chezmoi's attribute scheme, which drives behavior:

- `dot_foo` → `~/.foo`; `.tmpl` suffix → Go-template rendered with chezmoi data.
- `run_onchange_*` scripts re-run only when their rendered content changes (so editing the Brewfile heredoc in `run_onchange_1-install-packages.sh.tmpl` triggers `brew bundle` on next apply). `run_once_after_*` runs once, after files are applied. `run_onchange_before_*` runs before files are applied. The numeric prefixes (`1-`, `2-`, `3-`) order scripts.
- `.chezmoi.toml.tmpl` defines template data (`fullname`, `gitemail`) used by `dot_gitconfig.tmpl`. Machine-private git config belongs in `~/.gitconfig.local`, which `dot_gitconfig.tmpl` includes; never put it here.
- `.chezmoiexternal.toml` pulls oh-my-zsh, its plugins, and powerlevel10k as archives (`exact = true`, refreshed weekly). Don't vendor them into the repo.
- `.chezmoiignore` excludes `README.md`, `LICENSE`, and zsh cache/`*.zwc` files from being applied.

## Conventions

- macOS-only scripts are wrapped in `{{ if (eq .chezmoi.os "darwin") -}} … {{ end -}}`; keep that guard on new OS-specific scripts.
- Packages are declared in a `brew bundle --file=/dev/stdin <<EOF` heredoc inside `run_onchange_1-install-packages.sh.tmpl`, grouped under `###` section headers (Setup, SOCIAL, SECURITY, etc.) with trailing `#` comments describing each entry. Add new `tap`/`brew`/`cask` lines to the matching section; third-party taps use `trusted: true`.
- Because the heredoc is unquoted, `$` and backticks inside it are expanded by the shell, and `{{ }}` is expanded by chezmoi; escape accordingly.
- Shell scripts must be idempotent (e.g. `ln -sfn`, `mkdir -p`, existence checks before `git clone`), since `run_onchange_*` re-runs them.
- `dot_gitignore` is the global gitignore (`~/.gitignore`, referenced as `core.excludesfile`), not this repo's ignore file.
- Commits use a subject + body format (see the `write-commit-message` skill); no Conventional Commits prefixes.
