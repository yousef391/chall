import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:challenge_fac_app/feautures/facture/presentation/viewmodels/article_view_model.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/article_dialog.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articleVM = Provider.of<ArticleViewModel>(context);
    final articles = articleVM.articles;
    final isWide = MediaQuery.of(context).size.width > 700;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gestion du Stock', style: textTheme.titleLarge),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 40 : 12,
              vertical: 18,
            ),
            child:
                articles.isEmpty
                    ? Center(
                      child: Text(
                        'Aucun article en stock',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    )
                    : ListView.separated(
                      itemCount: articles.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.zero,
                          color: colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: colorScheme.primaryContainer,
                                child: Icon(
                                  Icons.inventory_2,
                                  color: colorScheme.primary,
                                ),
                              ),
                              title: Text(
                                article.name,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.description,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurface.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Wrap(
                                    spacing: 8,
                                    children: [
                                      Chip(
                                        label: Text(
                                          'Prix: ${article.unitPrice ?? 0} DZD',
                                          style: TextStyle(
                                            color: colorScheme.onPrimary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        backgroundColor: colorScheme.primary,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 0,
                                        ),
                                      ),
                                      Chip(
                                        label: Text(
                                          'Stock: ${article.quantity ?? 0}',
                                          style: TextStyle(
                                            color: colorScheme.onPrimary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        backgroundColor: colorScheme.secondary,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: colorScheme.secondary,
                                    ),
                                    tooltip: 'Modifier',
                                    onPressed:
                                        () => showArticleDialog(
                                          context,
                                          article: article,
                                          index: index,
                                        ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: colorScheme.error,
                                    ),
                                    tooltip: 'Supprimer',
                                    onPressed:
                                        () => articleVM.removeArticle(index),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        icon: const Icon(Icons.add, size: 28),
        label: const Text(
          'Ajouter',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        onPressed: () => showArticleDialog(context),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
