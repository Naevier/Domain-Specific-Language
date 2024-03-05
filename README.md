[![License](https://img.shields.io/static/v1?label=License&style=flat-square&message=Apache-2.0&color=c92d3e&logo=apache)](https://www.apache.org/licenses/LICENSE-2.0)
[![GHC version](https://img.shields.io/static/v1?label=GHC&message=9.0.2&style=flat-square&color=8e4e8b&logo=ghc)](https://www.haskell.org/ghc/)
[![Cabal version](https://img.shields.io/static/v1?label=Cabal&message=3.6.2.0&style=flat-square&color=8e4e8b&logo=cabal)](https://www.haskell.org/cabal/)
[![Gloss version](https://img.shields.io/static/v1?label=Gloss&message=1.13.2.2&style=flat-square&color=FF6600&logo=gloss)](https://hackage.haskell.org/package/gloss)


# Drawing Domain Specific Language

## Overview

A DSL for **drawing manipulation**, based on an algebraic approach. Decouples **syntax** and **semantics** for easy customization and modifications for diverse applications. Provides default support for **screen printing** using _Gloss_ library. Project developed as part of the _Programming Paradigms_ university course at [FaMAF](https://www.famaf.unc.edu.ar/) - [UNC](https://www.unc.edu.ar/). Language idea based on the Peter Henderson [paper](https://cs.famaf.unc.edu.ar/~mpagano/henderson-funcgeo2.pdf)

## Getting started

1) Clone the repository

```bash
git clone https://github.com/Naevier/Domain-Specific-Language.git
```

2) Install [ghc](https://www.haskell.org/ghc/) and [cabal](https://www.haskell.org/cabal/). Then install [gloss](https://hackage.haskell.org/package/gloss) via cabal (or via or [stack](https://docs.haskellstack.org/en/stable/))

```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

cabal update
cabal install gloss
```

### Usage

The drawings can be printed from the `src` directory with

```bash
$ ghci Main.hs
ghci> :set args Escher
ghci> main
```

where the argument (`Escher` in the example) represents the name of the drawing that will be displayed on the screen, and can be replaced with the name of any other drawing. New drawings can be added creating a new file in the `Dibujos` directory, importing the new module into the `Main` file, and adding it to the `configs` list in the same file.

_The complete list of available drawings can be consulted by using `--lista` as argument._

<img src="https://cdn.discordapp.com/attachments/924766841837068290/1099400998059004035/image.png?ex=65f5e477&is=65e36f77&hm=0954f1c00352fa88ccac823d0640327be23387abfe9e042ea6962f2729336d58&" alt="Escher drawing image" width="350"/>

> Escher drawing

## Running tests

Drawing DSL uses [HUnit](https://hackage.haskell.org/package/HUnit) as a test framework. It can be installed with

```bash
cabal install HUnit
```

and the tests can be run from the `test` directory over the functions of _Dibujo.hs_ with

```bash
$ ghci TestDibujo.hs -i ../src/Dibujo.hs
ghci> main
```

and over the functions of _Pred.hs_ with

```bash
$ ghci TestPred.hs -i ../src/Dibujo.hs ../src/Pred.hs
ghci> main
```

## Files

| File                                   | Description                            |
| -----------                            | -----------                            |
| [Main.hs](src/Main.hs)                 | Main program                           |
| [Dibujo.hs](src/Dibujo.hs)             | Data structure and operations for _Dibujo_ type (_**syntax**_)         |
| [Interp.hs](src/Interp.hs)             | Geometric interpretation of the drawings (_**semantic**_) using _Gloss_ |
| [FloatinPic.hs](src/FloatinPic.hs)     | Vector data types and geometric interpretation of the grid       |
| [Pred.hs](src/Pred.hs)                 | Predicates over drawings _(deprecated)_ |
| [Grilla.hs](src/Grilla.hs)             | Functions over the grid                |
| [Dibujos/GrillaNumerada.hs](src/Dibujos/GrillaNumerada.hs)                      | Numbered-grid sample drawing   |
| [Dibujos/Feo.hs](src/Dibujos/Feo.hs)                   | Test drawing that demonstrates the functions          |
| [Dibujos/Escher.hs](src/Dibujos/Escher.hs)             | Escher-style recursive drawing         |
| [tests/TestDibujo.hs](tests/TestDibujo.hs)             | Test suite for the _Dibujo_ module  |
| [tests/TestPred.hs](tests/TestPred.hs)                 | Test suite for the _Pred_ module    |

Each drawing is associated with an instance of the _Dibujo_ type, which includes its own set of basic drawings and semantics.
 This approach makes it possible to extend the DSL with new basic figures and interpretations of the semantics, such as adding support for SVG printing for example.

 _The basic figures can be easily changed in the `interpBas` function of each drawing, and the semantics can be changed in the [Interp](src/Interp.hs) file_

## Authors

- [@naevier](https://github.com/naevier)
- [@Gonzalia](https://github.com/Gonzalia)
- [@Conyweasley](https://github.com/Conyweasley)
- [@beta-ziliani](https://github.com/beta-ziliani) (kickstart)
 
## License

This DSL is licensed under the Apache License, Version 2.0 - See the [license](LICENSE) file for more information
