## RÉGLAGE POUR LE TERMINAL VS CODE

**Objectif :** Configurer la police / font dans VS Code

### Précondition : installer une font "Nerd"

```bash
mkdir -p ~/.local/share/fonts
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip Hack.zip -d ~/.local/share/fonts/HackNerd
fc-cache -fv
```

### Configurer VS Code
> Si les icônes ne s'affichent pas dans VS Code :

1. Ouvrir les Paramètres (Ctrl + ,).
2. Rechercher : "Terminal Integrated Font Family".
3. Saisir la valeur : `'Hack Nerd Font Mono'`
4. Rechercher : "Terminal Integrated GPU Acceleration".
5. Régler sur : "on".

