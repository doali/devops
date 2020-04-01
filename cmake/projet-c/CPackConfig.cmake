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
