# IDE - IA

Installation d'une IA pour emacs

1. installer ollama
1. installer mistral depuis ollama

## Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

## Mistral

```bash
ollama pull mistral
```

## Utilisation

### Terminal

```bash
ollama run mistral
```

### Emacs

Dans le fichier ```/home/edf/.doom.d/init.el``` ajouter

```lisp
(use-package ollama
  :ensure t
  :init
  ;; Assurez-vous que Ollama est en cours d'exécution sur localhost:11434
  ;; Si vous avez changé le port ou l'hôte, modifiez cette ligne.
  (setq ollama-host "http://localhost:11434")

  ;; Spécifiez le modèle que vous avez téléchargé avec Ollama.
  ;; Assurez-vous que ce nom correspond exactement à celui que vous avez tiré (ex: "mistral", "llama3", "phi3")
  (setq ollama-model "mistral")

  ;; --- Raccourcis clavier (optionnel mais recommandé) ---
  ;; Ces raccourcis utilisent la touche de préfixe de Doom Emacs (généralement SPC)
  ;; Vous pouvez les adapter à votre convenance.

  ;; Lancer une conversation interactive avec Ollama
  (map! :leader :desc "Ollama Chat" :n "o c" #'ollama-chat)

  ;; Expliquer le texte sélectionné (région)
  (map! :leader :desc "Ollama Explain Region" :n "e o" #'ollama-explain-region)

  ;; Compléter du code (utile dans les buffers de code)
  (map! :leader :desc "Ollama Complete Code" :n "c c" #'ollama-complete-code)

  ;; Générer du code à partir d'un prompt (peut être utilisé dans n'importe quel buffer)
  (map! :leader :desc "Ollama Generate Code" :n "g o" #'ollama-generate-code)
  )
```

et rafraichir la configuration ```doom sync```

> ```M-x doom/reload```

#### Utilisation

- ```SPC o c``` pour chatter dans un buffer (ollama chat)
- sélectionner une région puis ```SPC e o``` pour explain ollama
- ```SPC c c``` pour code complete ollama (avec une extension .gi, .py)
- ```SPC g o``` pour generate ollama dans le buffer

```html
Conseils supplémentaires :

Modèles : Si Mistral 7B n'est pas assez performant pour vos besoins, essayez mixtral (plus lourd) ou llama3 (très bon). Vous devrez les télécharger avec ollama pull <nom_du_modele> et changer la ligne (setq ollama-model "...") dans votre init.el.
Performance : Si c'est lent, assurez-vous que votre machine a suffisamment de RAM. L'utilisation d'un GPU accélère considérablement les choses si Ollama est configuré pour l'utiliser (ce qui est souvent automatique sur les systèmes compatibles).
Raccourcis : N'hésitez pas à modifier les raccourcis map! pour qu'ils correspondent à vos habitudes.
```