# Test Swift avec Docker

Ce test sert à tester un programme Swift dans un container.

Pour le moment, il y a un problème avec URLSession sur linux.
La lib Foundation est séparée pour les autres plateformes que Darwin, ce qui pose problème.

## Reproduce

Init with `swift package init --type executable`

## Launch

`swift run server`

## Build

`swift build`