# Vim

## Installation
```sudo apt install vim```

## Configuration
### Fichier `vimrc`
- `~/.vimrc` : fichier de configuration
Exemple de contenu
  ```
  set nu
  set tabstop=8
  set expandtab
  set shiftwidth=4
  set softtabstop=4
  set autoindent
  set smarttab
  ```
  - `tabstop=8` : déplacement de 8 caractères
  - `expandtab` : insère des espaces au lieu d'un traditionnel `<TAB>`
  - `shiftwidth=4` : nombre d'espaces à utiliser avec '>>' et '<<'
  - `softtabstop=4` : `<TAB>` se déplace de 4 espaces qui sont insérés
  - `autoindent` : indentation automatique selon la ligne précédente
  - `smarttab` : insère des espaces selon la politque de shiftwidth quand `<TAB>` devant une ligne

### Vundle
_Gestionnaire de plugins_

### Preparation installation
```bash
cd ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

### Configuration
_Dans le fichier `~/.vimrc`, il faut ajouter les lignes_
```bash
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
```
### Installation des plugins
- lancer vim et exécuter `:PluginInstall`
- depuis la ligne de commande : `vim +PluginInstall +qall`

### Utilisation
- `:PluginList`       : lists configured plugins
- `:PluginInstall`    : installs plugins; append `!` to update or just :PluginUpdate
- `:PluginSearch foo` : searches for foo; append `!` to refresh local cache
- `:PluginClean`      : confirms removal of unused plugins; append `!` to auto-approve removal
- `:h vundle`         :for more details or wiki for FAQ


## Biblio
- [Vundle tuto](https://blog.pabuisson.com/2014/07/vim-vundle-gestion-plugins/)
- [Gitthub Vundle](https://github.com/VundleVim/Vundle.vim)
- [You complete me](https://github.com/ycm-core/YouCompleteMe)