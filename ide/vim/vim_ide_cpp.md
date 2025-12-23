# 🚀 Guide de Configuration : Vim IDE C++ (AlmaLinux)

Ce document récapitule la mise en place d'un environnement de développement professionnel C++ sous Vim, avec une gestion hybride des dépendances.

## 1. Installation des dépendances Système (via DNF)
Ces outils servent de moteurs de fond pour Vim et doivent être installés en priorité.

```bash
# Le serveur de langage C++ (complétion et détection d'erreurs)
sudo dnf install clang-tools-extra

# Le moteur d'analyse de symboles (structure du code pour Tagbar)
sudo dnf install ctags

# Le moteur de recherche de texte ultra-rapide (utilisé par le raccourci ,f)
sudo dnf install ripgrep
```

## 2. Configuration Graphique (Polices Nerd Fonts)
Pour que les icônes (Git, Erreurs, Airline) s'affichent correctement dans Tilix, vous devez installer une police "patchée".

```bash
# 1. Créer le répertoire local pour les polices utilisateur
mkdir -p ~/.local/share/fonts

# 2. Télécharger la police JetBrains Mono Nerd Font (version Regular)
cd ~/.local/share/fonts && curl -OL [https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf)

# 3. Mettre à jour le cache des polices du système
fc-cache -fv ~/.local/share/fonts
```

**Action requise dans Tilix :**
1. Ouvrez **Tilix** > **Préférences** > **Profils** > **Default**.
2. Dans l'onglet **Apparence**, cochez "Police personnalisée".
3. Sélectionnez **JetBrainsMono Nerd Font Regular**.

## 3. Déploiement de l'IDE (via Vim-Plug)
Une fois le fichier `~/.vimrc` créé, tout le reste de l'installation se fait de manière autonome.

### La commande : `:PlugInstall`
Dès l'ouverture de Vim, tapez `:PlugInstall`. 
* **FZF** : Vim-Plug téléchargera automatiquement le binaire `fzf` dans `~/.vim/plugged/fzf/bin/` grâce à l'instruction `do` présente dans le fichier `.vimrc`.

---

## 4. Les Commandes du Quotidien

### 📂 Navigation et Recherche
| Raccourci | Action | Outil utilisé |
| :--- | :--- | :--- |
| `Ctrl + p` | Chercher un fichier par son nom | FZF |
| `,s` | Chercher une méthode dans le fichier actuel | FZF + BTags |
| `,f` | Chercher un texte dans tout le projet | FZF + Ripgrep |
| `Ctrl + n` | Ouvrir/Fermer l'explorateur de fichiers | NERDTree |
| `F8` | Ouvrir/Fermer la structure des classes | Tagbar |

### 💡 Intelligence de Code (LSP)
Ces raccourcis sont actifs dès qu'un fichier C++ est ouvert :
* **`gd`** : Sauter à la définition (Go to Definition).
* **`gr`** : Lister les références (où la variable est utilisée).
* **`K`** : Afficher la documentation/signature (Hover).
* **`F2`** : Renommer une variable de manière globale.

### 🪟 Gestion des Fenêtres (Splits)
* **`,v`** : Diviser l'écran verticalement.
* **`,h`** : Diviser l'écran horizontalement.
* **`,x`** : Fermer la fenêtre active.
* **`Ctrl + Flèches`** : Naviguer entre les fenêtres splits.

---

## 5. Compilation & Conteneurisation (Docker)
Pour garder un `.vimrc` générique, la logique de compilation Docker doit être placée dans un `Makefile` à la racine de votre projet.

### Mise en place (Makefile)
```makefile
# Exemple de Makefile pour compiler via Docker
build:
	docker run --rm -v $(shell pwd):/src -w /src mon_image_cpp sh -c "mkdir -p build && cd build && cmake .. && make"
```

### Utilisation dans Vim
* **Raccourci suggéré** : `:wa | !make build` (Sauvegarde tout et lance le build).
* **Quickfix** : Si la compilation échoue, tapez `:copen` pour voir les erreurs et naviguer vers les lignes fautives.

---

## 6. Débogage (GDB / Termdebug)
Vim intègre nativement un pilotage pour GDB.

### Lancement
1. Chargez l'outil : `:packadd termdebug`
2. Lancez le débugger : `:Termdebug path/to/executable`

### Commandes d'inspection mémoire
* **`:Asm`** : Affiche le code assembleur.
* **`:Evaluate` (ou `K`)** : Affiche la valeur de la variable sous le curseur.
* **Console GDB (Fenêtre du bas)** :
    * `p &maVar` : Affiche l'adresse d'une variable.
    * `p monPtr` : Affiche l'adresse contenue dans un pointeur.
    * `x/16xb ptr` : Examine 16 octets en hexadécimal à l'adresse ptr.
    * `display var` : Affiche la valeur à chaque étape (Step/Next).
* **Interface visuelle** : Dans la fenêtre GDB, tapez `layout next` pour cycler vers la vue des registres ou des variables locales.

### 🧠 Inspection Mémoire (GDB)
* `bt full` : Affiche la pile d'appels avec les valeurs des variables locales.
* `x/32xw $sp` : Affiche les 32 prochains mots sur la Stack à partir du pointeur de pile.
* `p *ptr@10` : Affiche les 10 premiers éléments d'un tableau pointé par `ptr`.
* `watch -l *0x7fffffffe040` : Arrête le programme si la valeur à cette adresse change (très utile pour traquer les corruptions sur la Heap).

---

## 7. Sauvegarde de l'environnement (Sessions)
Le plugin `vim-session` permet de mémoriser votre disposition :
* **Sauvegarder** : `:SaveSession nom` (ou raccourci `,ss`).
* **Restaurer** : `:OpenSession nom` (ou raccourci `,os`).

---

## 8. Maintenance
* **Mise à jour des plugins** : `:PlugUpdate`.
* **Vérification de l'état** : `:PlugStatus`.
* **Nettoyage (si plugin supprimé)** : `:PlugClean`.

---

## 9. Fichier `~/.vimrc` complet

```bash
" ============================================================================
" CONFIGURATION IDE C++ ULTIME - VIM
" ============================================================================

set nocompatible
set encoding=utf-8

" --- CONFIGURATION DU LEADER (IMPÉRATIF AU DÉBUT) ---
let mapleader = ","
set timeoutlen=500             " Laisse 500ms pour taper la suite du raccourci

" --- Paramètres Système ---
set number
set relativenumber
set laststatus=2
set updatetime=500
set signcolumn=yes
set hidden
set noshowmode
set mouse=a

" --- Section Plugins ---
call plug#begin('~/.vim/plugged')
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'preservim/nerdtree'
  Plug 'preservim/tagbar'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'xolox/vim-session'
  Plug 'xolox/vim-misc'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()

filetype plugin indent on
syntax on

" --- Configuration FZF (Recherche) ---
" Les raccourcis fonctionnent maintenant car le leader est défini plus haut
nnoremap <silent> <leader>s :BTags<CR>
nnoremap <silent> <leader>f :Rg<CR>
nnoremap <C-p> :Files<CR>

" --- Raccourcis de Navigation & Splits ---
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
nnoremap <leader>x :close<CR>

" Navigation entre splits avec Ctrl + flèches
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-l>

" Autres outils
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <F8> :TagbarToggle<CR>

" --- Configuration Interface & Signes LSP ---
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'
let g:airline#extensions#tabline#enabled = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_error = {'text': "\uf057"}
let g:lsp_diagnostics_signs_warning = {'text': "\uf071"}
let g:tagbar_ctags_bin = '/usr/bin/ctags'

" --- Fonctions LSP (gd, gr, K...) ---
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <f2> <plug>(lsp-rename)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Nettoyage automatique des espaces en fin de ligne
autocmd BufWritePre * %s/\s\+$//e
```
