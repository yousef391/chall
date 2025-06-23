# Module de Facturation Mobile (Flutter)

## Brève description

Ce projet est une application Flutter de facturation mobile, permettant de :
- Gérer dynamiquement un inventaire d’articles (stock)
- Créer des factures avec ajout/suppression d’articles
- Calculer automatiquement les totaux (HT, TVA, TTC)
- Afficher un aperçu structuré de la facture en temps réel
- Profiter d’une interface moderne, responsive et adaptée au thème clair/sombre

## Captures d’écran

> *(Ajoutez ici des captures d’écran de l’écran de création de facture, gestion des articles, et aperçu de facture)*

---

## Explication des choix techniques

- **Architecture MVVM** :  
  Le projet est structuré autour du pattern MVVM pour une meilleure séparation des responsabilités et une évolutivité facilitée.
- **Provider** :  
  J’ai choisi Provider pour le state management car la tâche est simple et cela permet une gestion efficace et lisible de l’état global (stock, factures).
- **Inventaire centralisé** :  
  Les articles sont gérés comme un inventaire (stock), ce qui permet une UX plus réaliste et professionnelle. L’utilisateur sélectionne les articles du stock pour les ajouter à la facture.
- **Formulaires dynamiques et validation** :  
  Les champs sont validés en temps réel (nom, email, quantité, prix), et les totaux sont recalculés à chaque modification.
- **UI responsive et moderne** :  
  Utilisation de ListView, Card, Divider, etc. pour une interface claire et agréable, adaptée au mode paysage/portrait et au thème sombre/clair.
- **Composants modulaires** :  
  Les écrans sont séparés (`InvoiceForm`, `StockScreen`, etc.) pour une meilleure lisibilité et réutilisabilité du code.

---

## Fonctionnalités principales

### 1. Création de facture
- Formulaire avec nom, email, date, liste dynamique d’articles
- Ajout/suppression d’articles via un bouton dédié
- Calcul automatique du total HT, TVA (20%), et TTC
- Validation des champs et feedback utilisateur

### 2. Gestion des articles (stock/inventaire)
- Ajout, édition et suppression d’articles dans le stock
- Chaque article possède une description, quantité en stock, prix unitaire
- Sélection d’articles depuis le stock lors de la création de facture

### 3. Aperçu facture en temps réel
- Affichage structuré des détails client, date, articles, totaux
- Design inspiré d’une facture réelle

### Bonus
- Thème clair/sombre avec bouton flottant pour basculer
- Responsive (mobile/tablette, portrait/paysage)
- Messages conditionnels (“Aucun article ajouté”, etc.)

---

## Respect du cahier des charges

- **Dynamique des formulaires** : ✔️
- **Ajout/suppression/modification d’articles** : ✔️
- **Calculs automatiques** : ✔️
- **Aperçu structuré** : ✔️
- **Gestion d’état simple (Provider)** : ✔️
- **UI épurée et responsive** : ✔️
- **Composants séparés** : ✔️
- **Thème clair/sombre** : ✔️

### Choix UX/UI
J’ai choisi de gérer les articles comme un inventaire centralisé pour une expérience utilisateur plus professionnelle et réaliste. Cela permet de sélectionner facilement les articles existants lors de la création d’une facture, tout en gardant la possibilité d’ajouter/éditer/supprimer des articles du stock.

### Pourquoi Provider ?
J’utilise habituellement Cubit/BLoC pour des projets plus complexes, mais ici Provider est suffisant, simple et parfaitement adapté à la taille du projet.

---

## Lancer le projet

```
flutter pub get
flutter run
```

---

## Structure du projet

- `lib/feautures/facture/data/models/` : Modèles de données (`Article`, `Invoice`)
- `lib/feautures/facture/presentation/viewmodels/` : Providers (MVVM)
- `lib/feautures/facture/presentation/` : Écrans principaux (`InvoiceForm`, `StockScreen`, etc.)
- `lib/root.dart` : Navigation principale avec BottomNavigationBar

---

## Remarques

- Le projet respecte l’ensemble des critères du challenge.
- L’architecture et l’UX sont pensées pour être évolutives et professionnelles.


---

**N’hésitez pas à me contacter pour toute question ou amélioration !**
