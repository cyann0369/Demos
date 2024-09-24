# Projet Demos - La Plateforme
## Analyse en Language **`R`** des taux d'abstensions à la participation électorale de 2017 en France
## Membres du projet 
- Xavier Trentin
- Yann Sasse
- Julien Ract-Mugnerot
- Amina Sadio
  

## Etapes du projets

1. Import des Données
   - fichier .xlsx shape (96,20)
   - Une seule entrée par département

3. Exploration du dataset
   - `Analyse univariée et bivariée approfondie` avec interprétations et représentations grarphiques
   - Gestion des valeurs manquantes et outliers avec contrainte d'un dataset à faible dimensions
   
4. Analyse approfondie des données compositionnelles
   - Choix d'une technique transformation Logratio
   - Test comparatifs des trois transformations (Etape 4 à 6)

5. Feature Selection, Réduction de Dimensionalité &  Scaling
   - **`PCA`** sur les variables résultants de la transformation Logratio
   - Feature Selection sur l'ensemble des features déterminées comme pertinente lors de l'analyse bivarié
   - Utilisation d'un Scaler, `MinMaxScaler` ?

6. régression pour modéliser la relation entre le taux d'abstention et les autres variables socio-économiques
   - Optimisation des hyper-paramètres de la régression linéaire
   - Evaluation des résultats du modèle
  
7. Clustering par département
   - Sélection d'une méthode de classification afin de regrouper les départements en fonction de leurs caractéristiques socio-économiques et de leur taux d’abstention
   - Identification du nombre de clusters optimal
  
8. Synthèse de l'analyse
   -  présentation des features les plus importantes
   - Nos suggestions aux départements avec un fort taux d'abstension (purge des abstentionistes)
   
9. Pistes d'amélioration du projet
   - Récolte de nouvelles données propres aux abstentionistes, âge, profession, condition de vie et niveau d'éducation actuel ...
   - Sondages d'envergure pour complémenter les données actuelles
  


## Contenu IMPLEMENTE UNE FOIS LA STRUCTURE VALIDE PAR L EQUIPE

### Etape 1
### Etape 2
### Etape 3
### Etape 4
### Etape 5
### Etape 6
### Etape 7
### Etape 8
### Etape 9

## To do list 

- rendre public le repo

- ajouter valeur non significative aux vars compositionelles

- Partie 6 du ReadMe vérifier le scaler qu'on utilise
- 

## Notes pour l'équipe

- utiliser Stargazer pour les tableaux

- Enoncé: "Les différents scripts et notebooks R propre et commenté(introduction, conclusion, etc)" `**Markdown nécessaire dans les notebooks**`

- PARTIE 5 vérifier l'intérêt de la démarche: **`PCA`** sur les variables résultants de la transformation Logratio

