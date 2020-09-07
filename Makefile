SHELL := /bin/bash

all: update

update:
	chezmoi apply

ubuntu-install-packages:
	sudo apt-get update
	sudo apt-get install -y \
		curl \
		build-essential \
		git \
		git-lfs \
		unattended-upgrades \
		units \
		vim-gtk3 \
		pass \
		mosh \
		tmux \
		htop \
		gnupg2

ubuntu-install-node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

ubuntu-install-chezmoi:
	curl --proto '=https' --tlsv1.2 -sSLO https://github.com/twpayne/chezmoi/releases/download/v1.7.15/chezmoi_1.7.15_linux_amd64.deb
	sudo dpkg -i chezmoi_1.7.15_linux_amd64.deb
	sudo apt-get install -f
	rm chezmoi_1.7.15_linux_amd64.deb

ubuntu-install-plug.vim:
	curl --proto '=https' --tlsv1.2 -sSLf https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > $$(chezmoi source-path ~/.vim/autoload/plug.vim)

ubuntu-install-prettyping:
	curl --proto '=https' --tlsv1.2 -sSO https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping	
	install	-m755 prettyping ~/.local/bin/
	rm prettyping

ubuntu-install-git-sizer:
	curl --proto '=https' --tlsv1.2 -sSLO https://github.com/github/git-sizer/releases/download/v1.3.0/git-sizer-1.3.0-linux-amd64.zip
	unzip -o git-sizer-1.3.0-linux-amd64.zip -d tmp-git-sizer
	install -m755 tmp-git-sizer/git-sizer ~/.local/bin/
	rm -r git-sizer-1.3.0-linux-amd64.zip tmp-git-sizer

ubuntu-install-magick:
	curl --proto '=https' --tlsv1.2 -sSO https://imagemagick.org/download/binaries/magick
	install -m755 magick ~/.local/bin/
	rm magick

ubuntu-install-latex:
	sudo apt-get install -y texlive-full latexmk

ubuntu-install-mendeley:
	curl --proto '=https' --tlsv1.2 -sSL https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest -o mendeley.deb
	sudo dpkg -i mendeley.deb
	rm mendeley.deb

ubuntu-install-alacritty:
	curl --proto '=https' --tlsv1.2 -sSL https://github.com/jwilm/alacritty/releases/download/v0.4.3/Alacritty-v0.4.3-ubuntu_18_04_amd64.deb -o alacritty.deb
	sudo dpkg -i alacritty.deb
	rm alacritty.deb

ubuntu-install-google-chrome:
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	sudo apt-get update
	sudo apt-get install google-chrome-stable
