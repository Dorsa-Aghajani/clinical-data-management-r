# Gestion de données cliniques longitudinales avec R

## Présentation du projet

Ce projet a été réalisé dans le cadre de mon Master en Intelligence des données de santé.

L'objectif est de manipuler et restructurer des données cliniques longitudinales à l'aide de **R**, puis de combiner différentes tables afin d'obtenir un jeu de données exploitable pour des analyses ultérieures.

Les données utilisées proviennent des jeux de données `pbc` et `pbcseq` du package `survival`.

## Objectifs

- Manipuler des données cliniques avec R
- Transformer des données longitudinales du format long vers le format large
- Restructurer les mesures répétées par patient
- Réaliser une jointure entre plusieurs tables
- Identifier les patients sans mesures longitudinales
- Vérifier la structure du jeu de données final

## Méthodologie

Le projet comprend plusieurs étapes :

1. Chargement des données cliniques `pbc` et `pbcseq`
2. Sélection des variables pertinentes
3. Organisation des mesures par patient et par visite
4. Transformation du format long vers le format large avec `pivot_wider()`
5. Jointure des données avec `left_join()`
6. Identification des patients sans suivi longitudinal avec `anti_join()`
7. Vérification du jeu de données final

## Technologies utilisées

- R
- dplyr
- tidyr
- survival

## Compétences développées

`R` · `Data Management` · `Données cliniques` · `Données longitudinales` · `Data Wrangling` · `Jointures` · `Transformation de données`
