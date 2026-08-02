# dotfiles

Personal macOS development environment: zsh, tmux, and a couple of helper scripts.

Neovim is **not** configured here — that lives in [ai-dotfiles](https://github.com/arukompas/ai-dotfiles), which owns `~/.config/nvim`.

## Contents

| Path        | What it is                                                                  |
| ----------- | --------------------------------------------------------------------------- |
| `zsh/`      | zshrc — oh-my-zsh + powerlevel10k, git/Laravel aliases and helper functions; `p10k.zsh` holds the generated prompt theme |
| `tmux/`     | tmux config — vi mode, mouse support, 1-based window numbering               |
| `vim/`      | Minimal vimrc (used over SSH) and spell files                               |
| `phpactor/` | phpactor config for PHP language server                                     |
| `worktrunk/`| [worktrunk](https://worktrunk.dev) (`wt`) — worktree paths, commit-message generation, per-project approved commands |
| `herdr/`    | [herdr](https://herdr.dev) agent multiplexer — keybindings and theme, mirroring `tmux/tmux.conf` |
| `scripts/t` | fzf-based tmux session switcher over `~/Sites` and `~/Projects`             |
| `install`   | Symlinks everything into `$HOME`                                            |

## Install

```sh
git clone https://github.com/<user>/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
./install
```

If a target already exists as a real file or directory, it is moved aside to `<target>.bak` (`.bak.1`, `.bak.2`, … if that name is taken) rather than deleted, so a machine's own configs survive. Existing symlinks are replaced. Re-running the script is safe. It links:

- `zsh/zshrc` → `~/.zshrc`
- `zsh/zshrcprivate` → `~/.zshrcprivate`
- `zsh/p10k.zsh` → `~/.p10k.zsh`
- `vim` → `~/.vim`
- `tmux/tmux.conf` → `~/.tmux.conf`
- `scripts/t` → `~/.local/bin/t`
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

## Dependencies

Everything below assumes [Homebrew](https://brew.sh) is installed.

### Core

Needed for the configs in this repo to work at all:

```sh
brew install tmux fzf jq
```

- `fzf` and `tmux` — required by `scripts/t`
- `jq` — used by worktrunk's commit-message command

`zshrc` sets `EDITOR` to `nvim` (`vim` over SSH), so install Neovim too — its config comes from [ai-dotfiles](https://github.com/arukompas/ai-dotfiles), not this repo:

```sh
brew install neovim
```

### Shell

`zsh/zshrc` sources oh-my-zsh and the powerlevel10k theme; without them the shell errors on startup.

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

The generated prompt config is tracked here as `zsh/p10k.zsh`, so there is no need to run `p10k configure` on a new machine. If you do re-run it, it rewrites the file and may replace the symlink with a regular file — re-run `./install` afterwards to relink.

The prompt expects a Nerd Font:

```sh
brew install --cask font-fira-code-nerd-font
```

### Worktrunk and herdr

```sh
brew install worktrunk
curl -fsSL https://herdr.dev/install.sh | sh
```

`worktrunk` conflicts with the `wiredtiger` formula — both install a `wt` binary. herdr has no Homebrew formula in use here; the install script drops the binary in `~/.local/bin`.

### Node

`zshrc` sources nvm from Homebrew and puts bun on `PATH`:

```sh
brew install nvm
curl -fsSL https://bun.sh/install | bash
```

### PHP / Laravel

Most aliases (`art`, `tinker`, `work`, `mfs`, …) and the phpactor config target Laravel projects:

```sh
brew install php composer
composer global require laravel/valet && valet install
```

### Optional

Only needed by specific aliases and functions — skip any you do not use:

```sh
brew install lazygit yazi gh libpq   # lg, y, gitcommiturl, psql client
npm install -g @mariozechner/pi-coding-agent backlog.md  # inspire, update
```

The `impl` function and worktrunk's commit generation shell out to [`codex`](https://developers.openai.com/codex/cli); `cc`/`update` shell out to [`claude`](https://claude.com/product/claude-code). Install those separately if you use them.
