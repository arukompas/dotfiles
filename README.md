# dotfiles

Personal macOS development environment: Neovim, zsh, tmux, and a couple of helper scripts.

## Contents

| Path        | What it is                                                                  |
| ----------- | --------------------------------------------------------------------------- |
| `nvim/`     | Neovim config (Lua, [packer.nvim](https://github.com/wbthomason/packer.nvim)) — LSP, Telescope, Treesitter, nvim-tree, lualine |
| `zsh/`      | zshrc — oh-my-zsh + powerlevel10k, git/Laravel aliases and helper functions  |
| `tmux/`     | tmux config — vi mode, mouse support, 1-based window numbering               |
| `vim/`      | Minimal vimrc (used over SSH) and spell files                               |
| `phpactor/` | phpactor config for PHP language server                                     |
| `worktrunk/`| [worktrunk](https://github.com/badlogic/worktrunk) (`wt`) — worktree paths, commit-message generation, per-project approved commands |
| `herdr/`    | herdr terminal multiplexer keybindings and theme, mirroring `tmux/tmux.conf` |
| `scripts/t` | fzf-based tmux session switcher over `~/Sites` and `~/Projects`             |
| `install`   | Symlinks everything into `$HOME`                                            |

## Install

```sh
git clone https://github.com/<user>/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
./install
```

The script replaces existing files at each target, so back anything up first. It links:

- `zsh/zshrc` → `~/.zshrc`
- `zsh/zshrcprivate` → `~/.zshrcprivate`
- `vim` → `~/.vim`
- `tmux/tmux.conf` → `~/.tmux.conf`
- `scripts/t` → `~/.local/bin/t`
- `nvim` → `~/.config/nvim`
- `phpactor` → `~/.config/phpactor`
- `worktrunk` → `~/.config/worktrunk`
- `herdr/config.toml` → `~/.config/herdr/config.toml`

`worktrunk` is linked as a whole directory because `wt` rewrites `approvals.toml` in place as commands are approved; its `.lock` files are gitignored. Only herdr's `config.toml` is linked, so its logs and `session.json` stay out of the repo.

## Local secrets

`zsh/zshrcprivate` is gitignored and sourced by `zshrc`. Create it before opening a new shell:

```sh
touch ~/Projects/dotfiles/zsh/zshrcprivate
```

Put machine-specific exports and credentials there.

## Requirements

zsh with [oh-my-zsh](https://ohmyz.sh) and [powerlevel10k](https://github.com/romkatv/powerlevel10k), Neovim, tmux, fzf, and Homebrew. Neovim bootstraps packer on first launch — run `:PackerSync` to install plugins.
