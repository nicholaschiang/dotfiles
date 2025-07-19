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

# Dependencies

There are a couple external dependencies you'll have to install for some of the
configurations in those dotfiles (namely `.vimrc`):

## MacOS

### Tooling

First, install [`brew`](https://brew.sh):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then, you can install my preferred development tooling:

```bash
brew install atuin bat btop eza fastfetch fish fzf git-delta kubectx k9s mise neovim rust starship tmux uv zoxide
```

You can then use [`mise`](https://mise.jdx.dev) to configure global `node` and `python` installations:

```bash
mise use --global node@22 python@3
```

When you first launch `vim` (or, rather, [`neovim`](https://github.com/neovim/neovim)), you will need to:

```
:PlugInstall
```

...to install of my `vim` plugins (configured via [`vim-plug`](https://github.com/junegunn/vim-plug)).

I also install `rust` CLI tooling directly using `cargo`:

```bash
cargo install just ruplacer
```

### Applications

You can use `brew` to install my preferred GUI applications on MacOS:

```bash
brew install --cask docker-desktop firefox figma font-iosevka notion-calendar raycast wezterm alacritty
```

I typically use `wezterm` with `tmux` on MacOS, but `alacritty` is also very good.
From my experience, `alacritty` is faster than `wezterm` but is less feature rich (e.g. it does not support ligatures).

## Arch Linux

My preferred distro of choice is currently [Arch Linux](https://en.wikipedia.org/wiki/Arch_Linux), primarily because (a) I love that it comes with essentially nothing baked-in, (b) it has absolutely stellar documentation, and (c) it has an incredible package ecosystem in [AUR](https://en.wikipedia.org/wiki/Arch_Linux#AUR).

From [a fresh Arch installation](https://wiki.archlinux.org/title/Installation_guide), install [`yay`](https://github.com/Jguer/yay?tab=readme-ov-file#installation):

```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Then, you can install my preferred development tooling:

```bash
yay -S \
  alacritty \
  atuin \
  base \
  base-devel \
  bat \
  bottom \
  btop \
  btrfs-progs \
  chezmoi \
  chromium \
  dnsmasq \
  dunst \
  efibootmgr \
  eza \
  fastfetch \
  firefox \
  fish \
  fzf \
  git \
  git-delta \
  git-lfs \
  grub \
  gst-plugin-pipewire \
  intel-ucode \
  iwd \
  just \
  k9s \
  kanshi \
  less \
  libpulse \
  libvirt \
  linux \
  linux-firmware \
  man-db \
  mise \
  neovim \
  openssh \
  pipewire \
  pipewire-alsa \
  pipewire-jack \
  pipewire-pulse \
  postgresql \
  python-poetry \
  qemu-full \
  ripgrep \
  rofi-bluetooth-git \
  rofi-wayland \
  rust \
  sof-firmware \
  starship \
  sway \
  swaybg \
  swayidle \
  swaylock \
  swtpm \
  tldr \
  ttc-iosevka \
  ttf-font-awesome \
  ttf-iosevka-nerd \
  usage \
  uv \
  virt-manager \
  waybar \
  wezterm \
  wget \
  wireplumber \
  wl-clipboard \
  yay \
  yay-debug \
  zoxide \
  zram-generator
```

I use [`fish`](https://fishshell.com/) as my default shell:

```bash
chsh -s /usr/bin/fish
```

Finally, you'll probably want to launch [`sway`](https://swaywm.org/):

```bash
sway
```
