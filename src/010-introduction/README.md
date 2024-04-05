---
description: Unix ... c'est quoi exactement ?
---

# Introduction

<figure><img src="../../.gitbook/assets/Unix.png" alt=""><figcaption></figcaption></figure>

Qu'est-ce que c'est ?

* Un système d'exploitation
* Inventé en 1969

Une philosophie unique :

> Un système d’exploitation devrait fournir un ensemble d’outils, chacun limité et bien défini. C’est la bonne enchaînement de ses outils qui fait émerger de la complexité.

Donc, au cœur des systèmes basés sur Unix :

* Le principe de **communication inter-processus** (`pipes`)
* Scripting

C’est la première système d’exploitation multiplateforme (entièrement codé en C). La création et adoption des normes (POSIX, SUS, ELF) incite de la compatibilité sur plusieurs « parfums » de Unix.

## Unix vs BSD vs Linux

UNIX a été initialement propriétaire.

Il y a eu un mouvement pour rendre « ouvert » et « gratuit » (GNU) des systèmes similaires à Unix.

Linus Torvalds invente Linux, qui est considéré « Unix-Like » Un émergence de plusieurs distributions (en ensemble d’outils livré sous une marque) : Ubuntu, Suse, Debian, Gentoo, Fedora, ...

L’université de Californie et Berkeley invente BSD

Certaines entreprises adopte les normes Unix :

* OpenSolaris (Sun Microsystems)
* Apple : Apple intègre et améliore progressivement des éléments de BSD et FreeBSD. Aujourd’hui MacOS est considéré _Unix-Like_.
* Android est basé sur Linux (son  « kernel »)

## Vocabulaire

|              |                                                                                                                                                                                                                                                                                                                    |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Distribution | Le « kernel » ainsi qu’un ensemble d’outils qui peuvent être installés comme un système d’exploitation sur une machine                                                                                                                                                                                             |
| Kernel       | Le « noyau » du système d’exploitation qui gère le fonctionnalités centrales à l’ordinateurs : Gestion du RAM ; Gestion des processus (planification, programmation); Drivers ou « pilotes » pour la médiation entre le matériel et les processus, « System calls » : des requêtes des services du noyau; Sécurité |
| Shell        | L’environnement et interprète textuel permettant de lancer des exécutables ou les enchaîner                                                                                                                                                                                                                        |
