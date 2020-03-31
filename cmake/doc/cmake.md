# CMake
***cmake, ctest, cpack***

_Outil de construction d'applications sur plusieurs systèmes d'exploitations..._

CMake permet d'**organiser** son projet, de **réaliser** des tests, et de **déployer** sur différentes plateformes.
L'interaction avec CMake s'effecture via un **langage propre à CMake** afin de lui _addresser des instructions._
- fichier d'instructions : **.cmake** ou **CMakeLists.txt** (fonctions, commandes, variables, structures de contrôle)

**Remarques**
- open source
- initié par Kitware en 2000
- traitement automatique des dépendances en C / C++
- équivalent : SCons, QMake, Autotools, Premake

## Installation
- Linux : `sudo apt install cmake`

## En bref
### CMake
- écriture d'instructions CMake (permettant la génération du MakeFile)
- génération du fichier **MakeFile** via **cmake**
- réalisation de tâches décrites dans le **MakeFile**

### CTest
- génération, gestion, exécution des tests

### CPack
- génération des redistribuables, packages d'installation...
- pilotage via un fichier qui réalisera le déploiement

## En pratique
- créer un fichier **CMakeLists.txt** à la racine du projet
- écrire en cmake les instructions dans le fichier CMakeLists.txt
- lancer **cmake** qui entrainera la génération du fichier **MakeFile**

### Exemple
_Creation d'un projet `projet-c`_
#### Création de la hiérarchie du file system
```bash
projet-c/
├── build
├── CMakeLists.txt
├── include
│   ├── calculator.h
│   └── CMakeLists.txt
└── src
    ├── CMakeLists.txt
    ├── lib
    │   ├── calculator.c
    │   └── CMakeLists.txt
    └── main.c
```
- `build` : cible des fichiers générés par cmake
- `src` : sources...
- `include` : les fichiers headers
- `lib` : implémentation des fonctions définies dans les headers

#### Exemple avec nos sources...
```bash
projet-c/
├── build
├── CMakeLists.txt
├── include
│   ├── calculator.h
│   └── CMakeLists.txt
└── src
    ├── CMakeLists.txt
    ├── lib
    │   ├── calculator.c
    │   └── CMakeLists.txt
    └── main.c
```
#### Configuration de notre projet
Edition d'un fichier CMakeLists.txt
- `project(<project_name>, [language_1, language_2, ...])` : nom du projet et les langages utilisés
- `add_subdirectory(<directory_name>)` : nom des répertoires à inclure depuis CMakeLists.txt
  > Tout répertoire devra contenir un fichier CMakeLists.txt
- `file(GLOB variable [RELATIVE path] [globing expression]...)`
  - `GLOB` : génération d'une **liste** de fichiers à partir d'une expression régulière
  - `variable` : variable créée contenant fichiers de la liste
  - `RELATIVE path` : chemin du dossier où se trouve les fichiers
  - `globing expression` : expression régulière
- `set(<variable> <value>... [PARENT_SCOPE])` : affecte `<value>` à `<variable>`
  > `${<variable>}` : pour utiliser `<variable>`
- `add_library(<name> [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL] [source1] [source2 ...])` : ajout (définition) d'une librairie
- `add_executable(<name> [WIN32] [MACOSX_BUNDLE] [EXCLUDE_FROM_ALL] [source1] [source2 ...])` : ajout (définition) de la cible de la compilation avec `<name>` le nom de l'exécutable et `[sourceX]` les sources utilisées
- `target_link_libraries(<target> ... <item>... ...)` : édition des liens, `<item>` est lié à l'exécutable `<target>`
- `include(...)` : inclusion des **headers** via leurs fichiers, uniquement les noms des fichiers sont considérés
- `include_directories([AFTER|BEFORE] [SYSTEM] dir1 [dir2 ...])` : inclusion des **headers** via une liste de répertoires contenant les fichiers

_Ce qui donne pour notre exemple_

`$ cat ./projet-c/CMakeLists.txt`

```cmake
cmake__minimum_required(VERSION 2.8)

project(calculator C)

add_subdirectory(include)
add_subdirectory(src)
include_directories(include)
```
`$ cat ./projet-c/include/CMakeLists.txt`
```cmake
```

`$ cat ./projet-c/src/CMakeLists.txt`
```cmake
add_subdirectory(lib)
add_executable(calculator main.c)
target_link_libraries(calculator lib)
```
`$ cat ./projet-c/src/lib/CMakeLists.txt`
```cmake
file(GLOB LIB . *.c)
add_library(lib-calculator ${LIB})
```

#### Compilation
- se placer dans le répertoire `build`
- lancer la commande : `cmake ..`
> CMake lit l'ensemble des CMakeLists.txt et en réalise une compilation pour générer le **Makefile** et un ensemble d'autres fichiers
- lancer la commande `make` : compilation -> génération d'un exécutable