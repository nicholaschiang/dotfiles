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

...to install all of my `vim` plugins (configured via [`vim-plug`](https://github.com/junegunn/vim-plug)).

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

First, [install Arch](https://wiki.archlinux.org/title/Installation_guide).
I referenced these two guides ([1](https://gist.github.com/mjkstra/96ce7a5689d753e7a6bdd92cdc169bae), [2](https://gist.github.com/uosyph/bb7db7606c4916535081ae7b0f6bff2d)) when I installed Arch alongside an existing Windows 11 installation.
I had to resolve an issue with GRUB and LUKS encryption [this way](https://unix.stackexchange.com/questions/764872/luks-password-correct-but-not-accepted).

### Boot Sequence

I no longer use GRUB (it is [slow](https://wiki.cachyos.org/installation/boot_managers/#cons-2) and [bloated](https://github.com/limine-bootloader/limine/blob/v8.x/PHILOSOPHY.md#why-not-support-filesystem-x-or-feature-y-eg-luks-lvm)).
I no longer encrypt the kernel `.img` files ([doing so is unnecessary](https://github.com/limine-bootloader/limine/blob/v8.x/PHILOSOPHY.md#what-about-luks-what-about-security-encrypt-the-kernel)).

I was going to setup [Limine](https://github.com/limine-bootloader/limine) instead (which [Omarchy uses](https://learn.omacom.io/2/the-omarchy-manual/101/system-snapshots?search=limine)), but Limine [lacks the ability to select the next boot entry programmatically](https://github.com/limine-bootloader/limine/issues/531), which is a must-have for me to [create a Windows desktop shortcut in Arch](https://bbs.archlinux.org/viewtopic.php?id=140049).
I also do not use many of the features of Limine (e.g. [snapshots](https://github.com/basecamp/omarchy/issues/1068)).
The CachyOS Wiki has [a good bootloader comparison table](https://wiki.cachyos.org/installation/boot_managers/#quick-feature-comparison).

Instead, I use `systemd-boot`.
I configured `systemd-boot` via `bootctl` by referencing the [Arch Linux Wiki](https://wiki.archlinux.org/title/Systemd-boot) and [this guide](https://allthings.how/replace-grub-with-systemd-boot-on-linux/).
I copied the necessary kernel options to load my encrypted [BTRFS](https://btrfs.readthedocs.io/en/latest/) volume from my previous `grub.cfg`.
I could have also gotten the necessary [persistent block device](https://wiki.archlinux.org/title/Persistent_block_device_naming) UUIDs from `lsblk -f` or [`blkid`](https://linuxhandbook.com/get-uuid-disk/).

In `/boot/efi/loader/entries/arch.conf`:

```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=2bdd61b8-be29-44b5-a699-a2118aa6305e rw rootflags=subvol=@ cryptdevice=UUID=1459c007-fe70-4092-a22b-363eda9eaede:root zswap.enabled=0 rootfstype=btrfs
```

In `/boot/efi/loader/entries/arch-fallback.conf`:

```
title   Arch Linux (fallback initramfs)
linux   /vmlinuz-linux
initrd  /initramfs-linux-fallback.img
options root=UUID=2bdd61b8-be29-44b5-a699-a2118aa6305e rw rootflags=subvol=@ cryptdevice=UUID=1459c007-fe70-4092-a22b-363eda9eaede:root zswap.enabled=0 rootfstype=btrfs
```

My BTRFS setup aligns with the default provided by the `archinstall` TUI:

```
❯ sudo btrfs subvolume list /
[sudo] password for nchiang:
ID 256 gen 174764 top level 5 path @
ID 257 gen 174764 top level 5 path @home
ID 258 gen 174764 top level 5 path @log
ID 259 gen 174617 top level 5 path @pkg
ID 260 gen 7603 top level 256 path var/lib/portables
ID 261 gen 7603 top level 256 path var/lib/machines
❯ lsblk -f
NAME        FSTYPE      FSVER            LABEL       UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda
├─sda1
└─sda2      exfat       1.0              X9 Pro      ACA5-33DF
sdb         iso9660     Joliet Extension ARCH_202509 2025-09-01-16-37-02-00
├─sdb1      iso9660     Joliet Extension ARCH_202509 2025-09-01-16-37-02-00
└─sdb2      vfat        FAT32            ARCHISO_EFI 68B5-CBAE
zram0       swap        1                zram0       585a6947-4e2d-48fe-8411-448e13116955                [SWAP]
nvme0n1
├─nvme0n1p1 vfat        FAT32            SYSTEM      48EA-8E84
├─nvme0n1p2
├─nvme0n1p3 BitLocker   2                            79e130d4-0616-41ff-b4ed-9fa641aff8a9
├─nvme0n1p4 ntfs                                     8CE06ED7E06EC754
├─nvme0n1p5 ntfs                         RESTORE     4EEC1B1BEC1AFD41
├─nvme0n1p6 vfat        FAT32            MYASUS      341B-2A97
├─nvme0n1p7 vfat        FAT32                        FFBD-D04F                             150.3M    50% /boot/efi
├─nvme0n1p8 swap        1                            27a98047-7832-4e79-b613-5b536d5bc626                [SWAP]
└─nvme0n1p9 crypto_LUKS 2                            1459c007-fe70-4092-a22b-363eda9eaede
  └─root    btrfs                                    2bdd61b8-be29-44b5-a699-a2118aa6305e   75.3G    50% /var/log
                                                                                                         /var/cache/pacman/pkg
                                                                                                         /home
                                                                                                         /
❯ sudo findmnt -nt btrfs
/                       /dev/mapper/root[/@]     btrfs rw,relatime,compress=zstd:3,ssd,space_cache=v2,subvolid=256,subvol=/@
├─/home                 /dev/mapper/root[/@home] btrfs rw,relatime,compress=zstd:3,ssd,space_cache=v2,subvolid=257,subvol=/@home
├─/var/cache/pacman/pkg /dev/mapper/root[/@pkg]  btrfs rw,relatime,compress=zstd:3,ssd,space_cache=v2,subvolid=259,subvol=/@pkg
└─/var/log              /dev/mapper/root[/@log]  btrfs rw,relatime,compress=zstd:3,ssd,space_cache=v2,subvolid=258,subvol=/@log
```

...the extra partitions on my SSD (`nvme0n1`) are used by the existing Windows installation.

I copied the kernel files from `/boot` (which lives on the encrypted BTRFS partition) to `/boot/efi` (which is the 300MB EFI partition).
Previously, `grub` handled decrypting `/boot` before loading the kernel.
This was very slow, required entering the same decryption passphrase twice, and `systemd-boot` does not support loading encrypted kernel files.
I was unable to copy the `initramfs-linux-fallback.img` file from the `/boot` directory (on my encrypted BTRFS partition) due to lack of space (on my 300MB EFI partition mounted to `/boot/efi`).

While `systemd-boot` will [automatically check](https://wiki.archlinux.org/title/Systemd-boot#Adding_loaders) at boot time for `/EFI/Microsoft/Boot/Bootmgfw.efi`, my "Windows Boot Manager" was located in a separate EFI partition and thus [required configuration](https://wiki.archlinux.org/title/Systemd-boot#Boot_from_another_disk).
I determined the FS alias of the EFI partition by using the [UEFI shell](https://wiki.archlinux.org/title/UEFI_shell) (installed via [`edk2-shell`](https://wiki.archlinux.org/title/Systemd-boot#UEFI_Shells_or_other_EFI_applications)) and comparing the output with `sudo blkid`:

```
Shell> map
Mapping table
FSO: Alias(s):CD0f0b:;BLK2:
    PciRoot(0x0)/Pci(0x14,0x0)/USB(0x5,0x0)/CDROM(0x1)
FS1: Alias(s):HD1b:;BLK7:
    PciRoot(0x0)/Pci(0xE,0x0)/NVMe(0x1,C2-96-5C-3C-01-75-A0-00)/HD(1,GPT,DECF284C-0B62-4D09-A598-8B06198A20EE,0x800,0X82000)
FS2: Alias(s):HD1g:;BLK12:
    PciRoot(0x0)/Pci(0xE,0X0)/NVMe(0x1,C2-96-5C-3C-01-75-A0-00)/HD(6,GPT,FF98FCA0-7E96-4279-92FF-C24D7B0A4ED1,0X7733B000,0x82000)
...
```

```
❯ sudo blkid
/dev/nvme0n1p9: UUID="1459c007-fe70-4092-a22b-363eda9eaede" TYPE="crypto_LUKS" PARTUUID="143b6881-0878-4534-a943-70e763abb1ea"
/dev/nvme0n1p7: UUID="FFBD-D04F" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="86c94f64-f9d3-49a5-ac2c-ea4f1b26b93e"
/dev/nvme0n1p5: LABEL="RESTORE" BLOCK_SIZE="512" UUID="4EEC1B1BEC1AFD41" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="2b42c37e-564a-4ae0-98e7-973d50744b62"
/dev/nvme0n1p3: UUID="79e130d4-0616-41ff-b4ed-9fa641aff8a9" TYPE="BitLocker" PARTLABEL="Basic data partition" PARTUUID="7ffde51e-2f89-449b-9675-4d3c2fcac1a6"
/dev/nvme0n1p1: LABEL="SYSTEM" UUID="48EA-8E84" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="EFI system partition" PARTUUID="decf284c-0b62-4d09-a598-8b06198a20ee"
/dev/nvme0n1p8: UUID="27a98047-7832-4e79-b613-5b536d5bc626" TYPE="swap" PARTUUID="4b56fe9c-b512-4c31-8929-e9804f9a0a55"
/dev/nvme0n1p6: LABEL="MYASUS" UUID="341B-2A97" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="Basic data partition" PARTUUID="ff98fca0-7e96-4279-92ff-c24d7b0a4ed1"
/dev/nvme0n1p4: BLOCK_SIZE="512" UUID="8CE06ED7E06EC754" TYPE="ntfs" PARTUUID="5f93ca63-50b1-441d-a0e7-f7535faa0b95"
/dev/nvme0n1p2: PARTLABEL="Microsoft reserved partition" PARTUUID="660bc4ee-985b-4a71-bb21-da13bc2a17c9"
/dev/sdb2: LABEL_FATBOOT="ARCHISO_EFI" LABEL="ARCHISO_EFI" UUID="68B5-CBAE" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="2d9d5c0b-02"
/dev/sdb1: BLOCK_SIZE="2048" UUID="2025-09-01-16-37-02-00" LABEL="ARCH_202509" TYPE="iso9660" PARTUUID="2d9d5c0b-01"
/dev/mapper/root: UUID="2bdd61b8-be29-44b5-a699-a2118aa6305e" UUID_SUB="4b804401-8ba4-4014-a088-67feca675a34" BLOCK_SIZE="4096" TYPE="btrfs"
/dev/sda2: LABEL="X9 Pro" UUID="ACA5-33DF" BLOCK_SIZE="512" TYPE="exfat" PARTLABEL="Basic data partition" PARTUUID="80b33855-35c4-4a15-8e81-f0430ec2e66b"
/dev/sda1: PARTLABEL="Microsoft reserved partition" PARTUUID="ecfc4322-72f3-4cc1-b3e6-8d3f63ef2cf0"
/dev/zram0: LABEL="zram0" UUID="585a6947-4e2d-48fe-8411-448e13116955" TYPE="swap"
```

In `/boot/efi/loader/entries/windows.conf`:

```
title   Windows
efi     /shellx64.efi
options -nointerrupt -nomap -noversion HD1b:EFI\Microsoft\Boot\Bootmgfw.efi
```

In `/boot/efi/loader/loader.conf`, I configured `systemd-boot` to load `arch.conf` by default:

```
default arch.conf
timeout 0
console-mode max
```

After confirming `systemd-boot` worked as expected, I removed `grub`:

```
sudo pacman -Rcnsu grub
sudo rm -rf /boot/grub /boot/efi/grub
```

I booted from a USB to move `/boot/efi` to `/boot` by editing `/etc/fstab` and removing the contents of `/boot`.

### Tooling

Then, from your fresh Arch installation, install [`yay`](https://github.com/Jguer/yay?tab=readme-ov-file#installation):

```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Then, you can install my preferred development tooling.
You can either run the script I made:

```bash
./install.sh
```

Or, run the command yourself manually (cherry-picking which tools to install):

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
  brightnessctl \
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
  pamixer \
  pipewire \
  pipewire-alsa \
  pipewire-jack \
  pipewire-pulse \
  playerctl \
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
  sway-contrib \
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

I also [disable Bluetooth reconnecting](https://askubuntu.com/questions/1416933/ubuntu-22-04-keeps-reconnecting-to-airpods-when-you-connect-to-them-with-another) to avoid erroneously reconnecting my earbuds after I switch to my phone:

```
# /etc/bluetooth/main.conf
ReconnectAttempts=0
```

To quickly set a system-wide [dark theme](https://wiki.archlinux.org/title/Dark_mode_switching):

```bash
yay -S gnome-themes-extra adwaita-qt5-git adwaita-qt6-git
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark
```

...these are also set in the `fish` configuration.

To configure the default browser:

```
/usr/share/applications🔒
❯ xdg-mime default firefox.desktop x-scheme-handler/http
/usr/share/applications🔒
❯ xdg-mime default firefox.desktop x-scheme-handler/https
```

Finally, you'll probably want to launch [`sway`](https://swaywm.org/):

```bash
sway
```

### Fan Curves

I configure fan curves on my laptop with [`asusctl`](https://asus-linux.org/):

```fish
❯ asusctl fan-curve -m Balanced -e true
Starting version 6.1.12
~
❯ asusctl fan-curve -g
Starting version 6.1.12
CPU: enabled: true, 30c:9%,62c:17%,66c:23%,70c:30%,74c:45%,78c:53%,78c:53%,78c:53%
GPU: enabled: true, 30c:9%,62c:16%,66c:22%,70c:29%,74c:44%,78c:51%,78c:51%,78c:51%
MID: enabled: true, 30c:0%,62c:0%,66c:0%,70c:0%,74c:0%,78c:80%,78c:80%,78c:80%
~
❯ asusctl fan-curve -m Performance -g
Starting version 6.1.12
CPU: enabled: true, 30c:9%,62c:17%,66c:23%,70c:30%,74c:45%,78c:53%,78c:53%,78c:53%
GPU: enabled: true, 30c:9%,62c:16%,66c:22%,70c:29%,74c:44%,78c:51%,78c:51%,78c:51%
MID: enabled: true, 30c:0%,62c:0%,66c:0%,70c:0%,74c:0%,78c:80%,78c:80%,78c:80%

Fan curves for Performance

[
    (
        fan: CPU,
        pwm: (45, 79, 117, 137, 175, 234, 234, 234),
        temp: (30, 64, 68, 72, 76, 80, 80, 80),
        enabled: false,
    ),
    (
        fan: GPU,
        pwm: (45, 79, 117, 137, 175, 242, 242, 242),
        temp: (30, 64, 68, 72, 76, 80, 80, 80),
        enabled: false,
    ),
    (
        fan: MID,
        pwm: (2, 2, 2, 2, 206, 206, 206, 206),
        temp: (30, 64, 68, 72, 76, 80, 80, 80),
        enabled: false,
    ),
]
~
❯ asusctl fan-curve -m Balanced -f cpu -D "30c:0%,62c:0%,66c:10%,70c:20%,74c:35%,78c:55%,78c:80%,78c:95%"
Starting version 6.1.12
~
❯ asusctl fan-curve -m Balanced -f gpu -D "30c:0%,62c:0%,66c:10%,70c:20%,74c:35%,78c:55%,78c:80%,78c:95%"
Starting version 6.1.12
~
❯ asusctl fan-curve -g
Starting version 6.1.12
CPU: enabled: false, 30c:0%,62c:0%,66c:10%,70c:20%,74c:34%,78c:54%,78c:80%,78c:94%
GPU: enabled: false, 30c:0%,62c:0%,66c:10%,70c:20%,74c:34%,78c:54%,78c:80%,78c:94%
MID: enabled: true, 30c:0%,62c:0%,66c:0%,70c:0%,74c:0%,78c:80%,78c:80%,78c:80%
```
