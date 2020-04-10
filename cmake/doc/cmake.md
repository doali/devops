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

**Prérequis**

```bash
sudo apt install -y \
  cmake \
  cmake-curses-gui \
  cmake-gui \
  nsis
```

---

## En bref
_Trois outils, CMake, CTest et CPack._

- `cmake -D CMAKE_INSTALL_PREFIX=./../livrable` : compilation des fichiers de configuration CMakeLists.txt
- `make install` : compilation && installation

---

### CMake

- écriture d'instructions CMake (permettant la génération du MakeFile)
- génération du fichier **MakeFile** via **cmake**
- réalisation de tâches décrites dans le **MakeFile**

### CTest

- génération, gestion, exécution des tests

### CPack

- génération des redistribuables, packages d'installation...
- pilotage via un fichier qui réalisera le déploiement

## Cas d'école complet
*En bref*

- créer un fichier **CMakeLists.txt** à la racine du projet
  > (!) et dans chaque sous répertoires
- écrire en cmake les instructions dans le fichier CMakeLists.txt
- lancer **cmake** qui entrainera la génération du fichier **MakeFile**
- lancer **make** pour exécuter le _Makefile_ généré

### Utilisation de CMake

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

#### Editions des fichiers CMakeLists.txt
Les indispensables

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
cmake_minimum_required(VERSION 2.8)

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
target_link_libraries(calculator lib-calculator)
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

> `src/calculator` est notre executable ainsi généré

#### Installation

_`cmake` et `make` ont participé à la génération de multiplers fichiers dans le `build`._
_Cette section présente la façon de procéder pour obtenir un ***livrable*** que l'on pourra diffuser._

**Les indispensables**

- `install([FILES|TARGETS|DIRECTORY|SCRIPT|CODE|EXPORT] <element> [...])` : selon l'argument `FILES, TARGETS...`, la fonction `install` réalisera une action spécifique au regard de `<element>`. `FILES, TARGETS, ...` permet de définir la nature de `<element>` et ainsi le comportement de `install(...)`

**On vise l'installation suivante**

- `bin` : pour l'exécutable `calculator`
- `lib` : pour la lib `lib-calculator`
- `include` : pour le(s) fichier(s) _headers_

```bash
dist
├── bin
│   └── calculator
├── include
│   └── calculator.h
└── lib
    └── liblib-calculator.a
```

- Cas de `include`

```bash
$ cat projet-c/include/CMakeLists.txt
```

```cmake
file(GLOB headers . *.h)
install(FILES ${headers} DESTINATION include)
```

> on créé une variable `ħeaders` qui contiendra la liste des fichiers `*.h` \
> on copie tous les fichiers contenus dans la variables `headers` dans le répertoire `include`

- Cas de `lib`

```bash
$ cat projet-c/src/lib/CMakeLists.txt
```

```cmake
file(GLOB LIB . *.c)
add_library(lib-calculator ${LIB})
install(TARGETS lib-calculator DESTINATION lib)
```

> On copie la librairie `lib-calculator` dans le répertoire `lib`

- Cas de `bin`

```bash
$ cat projet-c/src/CMakeLists.txt
```

```cmake
add_subdirectory(lib)
add_executable(calculator main.c)
target_link_libraries(calculator lib-calculator)
include(TARGETS calculator DESTINATION bin)
```

> On copie l'exécutable `calculator` dans le répertoire `bin`

Suppression des fichies issus de la compilation

- `make clean` : lancée dans le répertoire `build`
  > supprime `calculator` et `liblib-calculator.a` \
  > i.e. l'exécutable et la librairie

**Modification des _variables de configuration_ de CMake** \
_Variables ayant une valeur par défaut et mises à disposition par CMake pour que l'on configure notre **environnement**._

- `CMAKE_INSTALL_PREFIX` : définition du répertoire d'accueil de l'installation
  > (!) `/usr/local` est la valeur par défaut sur linux

```bash
cmake -D CMAKE_INSTALL_PREFIX=./../dist ..
```

> - (!) au deux points finaux :-)
> - Permet de générer les fichiers propres à CMake en renseignant sa variable de configuration `CMAKE_INSTALL_PREFIX`
> - (!) Les variables de configurations sont **visibles** dans le fichiers `CMakeCache.txt` (contenu dans notre répertoire `build`)

```bash
ccmake ..
```

> - (!) au deux points finaux :-)
> - permet également de configurer la variable de configuration `CMAKE_INSTALL_PREFIX`
> - réalisé en mode **semi-graphique**

```bash
cmake-gui ..
```

> - (!) au deux points finaux :-)
> - permet également de configurer la variable de configuration `CMAKE_INSTALL_PREFIX`
> - réalisé en mode **graphique**

**Installation**
_Prise en compte des fichiers générés précédemment avec la nouvelle valeur de `CMAKE_INSTALL_PREFIX`._

- `make install` : lancée depuis le répertoire `build`
  > va générer l'arborescence telle que définie par les `CMakeLists.txt` et `CMAKE_INSTALL_PREFIX`

### Utilisation de CTest

_Définition et exécution des tests._

#### Activer les tests

- ajouter `enable_testing()` au `CMakeLists.txt` de la racine du projet
```bash
cat projet-c/CMakeLists.txt
```

```cmake
cmake_minimum_required(VERSION 2.8)

project(calculator C)

add_subdirectory(include)
add_subdirectory(src)
include_directories(include)

enable_testing()
```

#### Ajouter des tests

- `add_test(<test_name> <exec> <arg1> <arg2> ...)`
  - `<test_name>` : le nom du test
  - `<exec>` : nom de l'executable / chemin vers l'executable
  - `<argX>` : les arguments

```bash
cat projet-c/CMakeLists.txt
```

```cmake
cmake_minimum_required(VERSION 2.8)

project(calculator C)

add_subdirectory(include)
add_subdirectory(src)

include_directories(include)

enable_testing()

add_test(test_1_add src/calculator 0 + 0) 
add_test(test_2_sub src/calculator 1 - 1) 
add_test(test_3_mul src/calculator 0 * 1) 
add_test(test_4_div src/calculator 0 / 1)
add_test(test_5_add src/calculator 0 + 1) 
add_test(test_6_sub src/calculator 2 - 1) 
add_test(test_7_mul src/calculator 1 * 1) 
add_test(test_8_div src/calculator 1 / 1)
```

> (!) il faut relancer la compilation des fichiers via `cmake` car `CMakeLists.txt` a été modifié

```bash
cmake ..
```

> Toujours depuis le répertoire `build`

#### Lancer les tests

_Depuis le répertoire `build`_
- `make test` : exécute les divers tests introduits par `add_test(...)`
- `projet-c/build/Testing/Temporary/LastTest.log` : contient le resultat des tests

Résultat de la commande : `make test`

```text
Running tests...
Test project /home/blackpc/git-github/devops/cmake/projet-c/build
    Start 1: test_1_add
1/8 Test #1: test_1_add .......................   Passed    0.00 sec
    Start 2: test_2_sub
2/8 Test #2: test_2_sub .......................   Passed    0.00 sec
    Start 3: test_3_mul
3/8 Test #3: test_3_mul .......................   Passed    0.00 sec
    Start 4: test_4_div
4/8 Test #4: test_4_div .......................   Passed    0.00 sec
    Start 5: test_5_add
5/8 Test #5: test_5_add .......................   Passed    0.00 sec
    Start 6: test_6_sub
6/8 Test #6: test_6_sub .......................   Passed    0.00 sec
    Start 7: test_7_mul
7/8 Test #7: test_7_mul .......................   Passed    0.01 sec
    Start 8: test_8_div
8/8 Test #8: test_8_div .......................   Passed    0.01 sec

100% tests passed, 0 tests failed out of 8

Total Test time (real) =   0.03 sec
```

Extrait du fichier : `cat Testing/Temporary/LastTest.log`

```text
Start testing: Apr 01 15:15 CEST
----------------------------------------------------------
1/8 Testing: test_1_add
1/8 Test: test_1_add
Command: "/home/blackpc/git-github/devops/cmake/projet-c/build/src/calculator" "0" "+" "0"
Directory: /home/blackpc/git-github/devops/cmake/projet-c/build
"test_1_add" start time: Apr 01 15:15 CEST
Output:
----------------------------------------------------------
0.000000
<end of output>
Test time =   0.00 sec
----------------------------------------------------------
Test Passed.
"test_1_add" end time: Apr 01 15:15 CEST
"test_1_add" time elapsed: 00:00:00
----------------------------------------------------------
```

### Utilisation de CPack

_Construction d'un paquetage à l'aide de CPack._

#### Déclarations et définitions

**Méthode à la mano**

Les instructions doivent-être définies dans un fichier `CPackConfig.cmake`.
> (!) à la racine du projet

```bash
cat CPackConfig.cmake
```

```cmake
# Definition d'une variable
SET(CCALCULATOR_BUILD "/home/blackpc/git-github/devops/cmake/projet-c/build")

SET(CCALCULATOR_SRC "/home/blackpc/git-github/devops/cmake/projet-c/src")

# Precise le generateur utilise
SET(CPACK_CMAKE_GENERATOR "Unix Makefiles")

# Format des livrables / fichiers a generer et packager
SET(CPACK_GENERATOR "STGZ;TGZ;TZ;DEB")

#  emplacement des fichiers generes par CMake => le build
SET(CPACK_INSTALL_CMAKE_PROJECTS "${CCALCULATOR_BUILD};calculator;ALL;/")

# nom et version du projet
SET(CPACK_NSIS_DISPLAY_NAME "calculator 1.0")

# description du projet
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CCALCULATOR_SRC}/DESC.txt")

# description du package
SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Simple calculator on command line")

# nom du fichier genere
SET(CPACK_PACKAGE_FILE_NAME "calculator-1.0.0-Linux-x86_64")

SET(CPACK_PACKAGE_INSTALL_DIRECTORY "calculator 1.0")
SET(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "calculator 1.0.0")
SET(CPACK_PACKAGE_NAME "calculator")
SET(CPACK_PACKAGE_VENDOR "doali")

# Obligatoire pour le generateur DEB
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "doali")

SET(CPACK_PACKAGE_VERSION "1.0.0")
SET(CPACK_RESOURCE_FILE_LICENSE "${CCALCULATOR_SRC}/LICENCE.txt")
SET(CPACK_RESOURCE_FILE_README "${CCALCULATOR_SRC}/README.md")
SET(CPACK_RESOURCE_FILE_WELCOME "${CCALCULATOR_SRC}/WELCOME.txt")

# Nom des dossiers presents dans build/_CPack_Packages
SET(CPACK_TOP_LEVEL_TAG "Linux-x86_64")

SET(CPACK_SYSTEM_NAME "Linux-x86_64")
```

On lance la compilation des divers fichiers par CPack qui réalisera selon cette configuration le packaging, la création des différents livrables via la commande

- `cpack --config ../CPackConfig.cmake ` : génération des livrables selon la configuration `CPackConfig.cmake`

On peut observer dans `build` les livrables suivants

```bash
calculator-1.0.0-Linux-x86_64.deb
calculator-1.0.0-Linux-x86_64.sh
calculator-1.0.0-Linux-x86_64.tar.gz
calculator-1.0.0-Linux-x86_64.tar.Z
```

**Méthode automatique**
- modifier le fichier `CMakeLists.txt` à la racine du projet (`/projet-c/CMakeLists.txt`)

```cmake
set(CPACK_GENERATOR "STGZ;TGZ;TZ;DEB")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "doali") #required

include(CPack)
```

- `CPACK_GENERATOR` : indique les générateurs à utiliser pour générer les livrables
- `CPACK_DEBIAN_PACKAGE_MAINTAINER` : est obligatoire si l'on souhaite un paquet `DEB`

Le fichier complet étant

```bash
cat /projet-c/CMakeLists.txt
```

```cmake
cmake_minimum_required(VERSION 2.8)

project(calculator C)

add_subdirectory(include)
add_subdirectory(src)

include_directories(include)

enable_testing()

add_test(test_1_add src/calculator 0 + 0) 
add_test(test_2_sub src/calculator 1 - 1) 
add_test(test_3_mul src/calculator 0 * 1) 
add_test(test_4_div src/calculator 0 / 1)
add_test(test_5_add src/calculator 0 + 1) 
add_test(test_6_sub src/calculator 2 - 1) 
add_test(test_7_mul src/calculator 1 * 1) 
add_test(test_8_div src/calculator 1 / 1)

set(CPACK_GENERATOR "STGZ;TGZ;TZ;DEB")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "doali") #required

include(CPack)
```

Il suffit ensuite de lancer la génération des divers fichiers CPack via la commande

```bash
make package
```

- (!) au niveau du répertoire  `build`

qui produit le résultat suivant

```text
[ 50%] Built target lib-calculator
[100%] Built target calculator
Run CPack packaging tool...
CPack: Create package using STGZ
CPack: Install projects
CPack: - Run preinstall target for: calculator
CPack: - Install project: calculator
CPack: Create package
CPack: - package: /home/blackpc/git-github/devops/cmake/projet-c/build/calculator-0.1.1-Linux.sh generated.
CPack: Create package using TGZ
CPack: Install projects
CPack: - Run preinstall target for: calculator
CPack: - Install project: calculator
CPack: Create package
CPack: - package: /home/blackpc/git-github/devops/cmake/projet-c/build/calculator-0.1.1-Linux.tar.gz generated.
CPack: Create package using TZ
CPack: Install projects
CPack: - Run preinstall target for: calculator
CPack: - Install project: calculator
CPack: Create package
CPack: - package: /home/blackpc/git-github/devops/cmake/projet-c/build/calculator-0.1.1-Linux.tar.Z generated.
CPack: Create package using DEB
CPack: Install projects
CPack: - Run preinstall target for: calculator
CPack: - Install project: calculator
CPack: Create package
CPack: - package: /home/blackpc/git-github/devops/cmake/projet-c/build/calculator-0.1.1-Linux.deb generated.
```

Les livrables sont également présents

```bash
calculator-0.1.1-Linux.deb
calculator-0.1.1-Linux.sh
calculator-0.1.1-Linux.tar.gz
calculator-0.1.1-Linux.tar.Z
```
