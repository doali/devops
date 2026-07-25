# Référence des fichiers indispensables d'un projet C/C++ moderne

## Objectif

Ce document décrit les fichiers que tout projet C/C++ moderne devrait posséder afin d'obtenir :

- une intégration optimale avec Clangd ;
- une expérience LSP de qualité sous Doom Emacs ;
- un formatage homogène ;
- une analyse statique avancée ;
- un débogage efficace ;
- une meilleure maintenabilité du code.

---

# 1. CMakeLists.txt

## Pourquoi ?

Le fichier `CMakeLists.txt` constitue la source de vérité du projet.

Il est utilisé pour :

- la compilation ;
- la génération de `compile_commands.json` ;
- la configuration des dépendances ;
- l'intégration CI/CD ;
- l'analyse Clangd.

Un mauvais `CMakeLists.txt` dégrade directement la qualité des diagnostics LSP.

---

## Configuration minimale recommandée

```cmake
cmake_minimum_required(VERSION 3.22)

project(
    MyProject
    VERSION 1.0.0
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(my_app
    src/main.cpp
)
```

---

## Bonnes pratiques

### Éviter

```cmake
include_directories(...)
add_definitions(...)
```

### Préférer

```cmake
target_include_directories(...)
target_compile_definitions(...)
target_compile_options(...)
```

---

## Warnings de compilation

Pour GCC / Clang :

```cmake
target_compile_options(my_app PRIVATE
    -Wall
    -Wextra
    -Wpedantic
)
```

---

## Debug

```cmake
set(CMAKE_BUILD_TYPE Debug)
```

ou

```bash
cmake -DCMAKE_BUILD_TYPE=Debug
```

---

# 2. compile_commands.json

## Pourquoi ?

C'est le fichier le plus important pour Clangd.

Il contient pour chaque fichier :

- les includes ;
- les macros ;
- les options du compilateur ;
- les chemins système.

Sans lui :

- autocomplétion dégradée ;
- diagnostics incomplets ;
- navigation imprécise.

---

## Génération

Via CMake :

```cmake
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
```

ou :

```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build
```

---

## Emplacement recommandé

```text
project/
├── CMakeLists.txt
├── compile_commands.json
├── src/
└── include/
```

Si le fichier est généré dans :

```text
build/compile_commands.json
```

créer un lien symbolique :

```bash
ln -s build/compile_commands.json .
```

---

## Vérification

```bash
cat compile_commands.json | jq .
```

ou :

```bash
ls -l compile_commands.json
```

---

# 3. .clang-format

## Pourquoi ?

Garantit un style unique au sein d'une équipe.

Évite :

- les guerres de formatage ;
- les différences inutiles dans Git ;
- les styles incohérents.

---

## Exemple recommandé

```yaml
BasedOnStyle: LLVM

IndentWidth: 4
TabWidth: 4
UseTab: Never

ColumnLimit: 120

BreakBeforeBraces: Allman

PointerAlignment: Left

SortIncludes: true
```

---

## Utilisation

Formater un fichier :

```bash
clang-format -i foo.cpp
```

Formater un projet :

```bash
find . \( -name "*.cpp" -o -name "*.hpp" \) \
    -exec clang-format -i {} \;
```

---

## Vérification CI

```bash
clang-format --dry-run --Werror
```

---

# 4. .clang-tidy

## Pourquoi ?

Clang-Tidy fournit une analyse statique avancée.

Il détecte :

- bugs potentiels ;
- problèmes de performance ;
- mauvaise utilisation du langage ;
- opportunités de modernisation.

---

## Exemple recommandé

```yaml
Checks: >
  bugprone-*,
  cppcoreguidelines-*,
  modernize-*,
  performance-*,
  readability-*

WarningsAsErrors: ''

HeaderFilterRegex: '.*'
```

---

## Vérification locale

```bash
clang-tidy src/main.cpp
```

---

## Usage recommandé

Projets modernes :

```text
bugprone-*
cppcoreguidelines-*
modernize-*
performance-*
```

---

## Complément à Clangd

Le couple :

```text
clangd
+
clang-tidy
```

constitue aujourd'hui la référence pour le développement C++ moderne.

---

# 5. .gdbinit

## Pourquoi ?

Personnalise le comportement de GDB.

Permet :

- un affichage plus lisible ;
- une meilleure inspection des objets C++ ;
- un gain de temps en débogage.

---

## Emplacement

```text
~/.gdbinit
```

ou localement dans le projet.

---

## Configuration recommandée

```gdb
set print pretty on
set pagination off
set confirm off

set print object on
set print static-members on
set print vtbl on

set history save on

set disassemble-next-line on
```

---

## Pour les STL modernes

Si disponible :

```gdb
python
import sys
sys.path.insert(0, '/usr/share/gcc/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)
end
```

Permet un affichage lisible de :

- std::vector
- std::map
- std::string
- std::optional
- std::variant
- std::unique_ptr

---

# Arborescence cible d'un projet

```text
project/
├── CMakeLists.txt
├── compile_commands.json
├── .clang-format
├── .clang-tidy
├── src/
├── include/
├── tests/
└── build/
```

Et côté utilisateur :

```text
~
└── .gdbinit
```

---

# Priorité des fichiers

Ordre d'importance pour Doom Emacs + Clangd :

1. compile_commands.json
2. CMakeLists.txt
3. .clang-tidy
4. .clang-format
5. .gdbinit

Sans `compile_commands.json`, Clangd est fortement dégradé.

Avec les cinq éléments correctement configurés, l'environnement C++ devient pleinement exploitable et tire le meilleur parti de Clangd, LSP, Flycheck, Corfu et Doom Emacs.

