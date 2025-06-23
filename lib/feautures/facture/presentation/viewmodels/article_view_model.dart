// lib/viewmodels/article_view_model.dart

import 'package:challenge_fac_app/feautures/facture/data/models/article.dart';
import 'package:flutter/material.dart';

class ArticleViewModel extends ChangeNotifier {
  List<Article> articles = [
    Article(
      id: 1,
      name: 'Service Mobile App',
      description: 'Développement Flutter complet',
      unitPrice: 150.0,
      quantity: 2,
    ),
    Article(
      id: 2,
      name: 'UI/UX Design',
      description: 'Conception des maquettes',
      unitPrice: 100.0,
      quantity: 1,
    ),
  ];

  void addArticle(Article article) {
    articles.add(article);
    notifyListeners();
  }

  void removeArticle(int index) {
    if (index >= 0 && index < articles.length) {
      articles.removeAt(index);
      notifyListeners();
    }
  }

  void updateArticle(int index, Article updatedArticle) {
    if (index >= 0 && index < articles.length) {
      articles[index] = updatedArticle;
      notifyListeners();
    }
  }

  double get totalHT => articles.fold(0.0, (sum, item) => sum + item.totalHT);

  double get tva => totalHT * 0.20;

  double get totalTTC => totalHT + tva;
}
