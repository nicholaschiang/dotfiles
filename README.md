# `dotfiles`

Dotfiles managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

Install `chezmoi` with:

```bash
sh -c "$(curl -fsLS git.io/chezmoi)"
```

Install and apply configuration with:

```bash
./bin/chezmoi init https://github.com/nicholaschiang/dotfiles.git --apply
```

## Dependencies

There are a couple external dependencies you'll have to install for some of the
configurations in those dotfiles (namely `.vimrc`):

#### Tooling

First, install [`brew`](https://brew.sh):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then, you can install my preferred development tooling:

```bash
brew install atuin bat btop eza fish fzf git-delta k9s mise neovim rust starship tmux zoxide
```

You can then use `mise` to configure global `node` and `python` installations:

```bash
mise use --global node@22 python@3
```

When you first launch `vim` (or, rather, [`neovim`](https://github.com/neovim/neovim)), you will need to:

```
:PlugInstall
```

...to install of my `vim` plugins (configured via [`vim-plug`](https://github.com/junegunn/vim-plug)).

#### Applications

You can use `brew` to install my preferred GUI applications on MacOS:

```bash
brew install --cask docker-desktop firefox figma font-iosevka notion-calendar raycast wezterm alacritty
```

I typically use `wezterm` with `tmux` on MacOS, but `alacritty` is also very good.
From my experience, `alacritty` is faster than `wezterm` but is less feature rich (e.g. `alacritty` does not support ligatures while `wezterm` does).

#### Fonts for Vim Airline

See [these 
instructions](https://github.com/vim-airline/vim-airline#integrating-with-powerline-fonts) 
for how to install (and add) the required powerline fonts:

> For the nice looking powerline symbols to appear, you will need to install a 
> patched font. Instructions can be found in the official powerline  
> documentation. Prepatched fonts can be found in the powerline-fonts repository.

Or, just trust me and run:

```
$ sudo apt-get install fonts-powerline
```

#### Fonts for Terminal

I use [Hack](https://sourcefoundry.org/hack/) as my font of choice. Follow the
instructions on [their website](https://sourcefoundry.org/hack/) to install it.
