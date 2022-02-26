SHELL := /bin/bash

all: update

update:
	chezmoi apply

basic:
	sudo apt-get update
	sudo apt-get install -y \
		curl \
		build-essential \
		checkinstall \
		git \
		git-lfs \
		unattended-upgrades \
		units \
		neovim \
		pass \
		mosh \
		tmux \
		htop \
		gnupg2 \
		ripgrep \
		imagemagick \
		ffmpeg \
		nmap \
		cpulimit
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

cypress:
	sudo apt-get install -y \
		libgtk2.0-0 \
		libgtk-3-0 \
		libgbm-dev \
		libnotify-dev \
		libgconf-2-4 \
		libnss3 \
		libxss1 \
		libasound2 \
		libxtst6 \
		xauth \
		xvfb

bettercap:
	sudo apt-get install -y libpcap libusb-1.0-0 libnetfilter-queue
	curl --proto '=https' --tlsv1.2 -sSLO https://github.com/bettercap/bettercap/releases/download/v2.29/bettercap_linux_amd64_v2.29.zip
	unzip -o bettercap_linux_amd64_v2.29.zip -d tmp-bettercap
	install -m755 tmp-bettercap/bettercap ~/.local/bin/
	rm -r bettercap_linux_amd64_v2.29.zip tmp-bettercap

adb:
	sudo apt-get install -y \
		android-tools-adb \
		android-tools-fastboot

java:
	sudo apt-get install -y openjdk-14-jre-headless

node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm i 16.14.0

chezmoi:
	curl --proto '=https' --tlsv1.2 -sSLO https://github.com/twpayne/chezmoi/releases/download/v1.7.15/chezmoi_1.7.15_linux_amd64.deb
	sudo dpkg -i chezmoi_1.7.15_linux_amd64.deb
	sudo apt-get install -f
	rm chezmoi_1.7.15_linux_amd64.deb

plug.vim:
	curl --proto '=https' --tlsv1.2 -sSLf https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > $$(chezmoi source-path ~/.vim/autoload/plug.vim)

prettyping:
	curl --proto '=https' --tlsv1.2 -sSO https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping	
	install	-m755 prettyping ~/.local/bin/
	rm prettyping

git-delta:
	curl --proto '=https' --tlsv1.2 -sSLO https://github.com/dandavison/delta/releases/download/0.5.1/git-delta_0.5.1_amd64.deb
	sudo dpkg -i git-delta_0.5.1_amd64.deb
	sudo apt-get install -f
	rm git-delta_0.5.1_amd64.deb

git-sizer:
	curl --proto '=https' --tlsv1.2 -sSLO https://github.com/github/git-sizer/releases/download/v1.3.0/git-sizer-1.3.0-linux-amd64.zip
	unzip -o git-sizer-1.3.0-linux-amd64.zip -d tmp-git-sizer
	install -m755 tmp-git-sizer/git-sizer ~/.local/bin/
	rm -r git-sizer-1.3.0-linux-amd64.zip tmp-git-sizer

latex:
	sudo apt-get install -y texlive-full latexmk

google-chrome:
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	sudo apt-get update
	sudo apt-get install google-chrome-stable
