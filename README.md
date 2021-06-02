# `dotfiles`

Dotfiles managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

Install `chezmoi` with:

```
$ sh -c "$(curl -fsLS git.io/chezmoi)"
```

Install and apply configuration with:

```
$ ./bin/chezmoi init https://github.com/nicholaschiang/dotfiles.git --apply
```

## Dependencies

There are a couple external dependencies you'll have to install for some of the
configurations in those dotfiles (namely `.vimrc`):

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
