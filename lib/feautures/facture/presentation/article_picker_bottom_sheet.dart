import 'package:flutter/material.dart';
import 'package:challenge_fac_app/feautures/facture/data/models/article.dart';

Future<List<Map<String, dynamic>>?> showArticlePickerBottomSheet(
  BuildContext context,
  List<Article> articles,
) {
  final Map<Article, int> quantities = {for (var a in articles) a: 0};
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return showModalBottomSheet<List<Map<String, dynamic>>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 12,
          right: 12,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 6,
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Text(
              'Sélectionner des articles',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  articles.isEmpty
                      ? Center(
                        child: Text(
                          "Aucun article disponible",
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                      )
                      : ListView.separated(
                        itemCount: articles.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, idx) {
                          final article = articles[idx];
                          return StatefulBuilder(
                            builder: (context, setState) {
                              int qty = quantities[article]!;
                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                color: colorScheme.surfaceContainerHighest,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 14,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            colorScheme.primaryContainer,
                                        child: Icon(
                                          Icons.inventory_2,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              article.name,
                                              style: textTheme.titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              article.description,
                                              style: textTheme.bodySmall
                                                  ?.copyWith(
                                                    color: colorScheme.onSurface
                                                        .withOpacity(0.7),
                                                  ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Chip(
                                                  label: Text(
                                                    '${article.unitPrice} DZD',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          colorScheme.onPrimary,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      colorScheme.primary,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 0,
                                                      ),
                                                ),
                                                const SizedBox(width: 8),
                                                Chip(
                                                  label: Text(
                                                    'Stock: ${article.quantity}',
                                                    style: TextStyle(
                                                      color:
                                                          colorScheme.onPrimary,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      colorScheme.secondary,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.remove_circle_outline,
                                                ),
                                                color:
                                                    qty <= 0
                                                        ? colorScheme.onSurface
                                                            .withOpacity(0.3)
                                                        : colorScheme.error,
                                                onPressed: () {
                                                  if (qty > 0) {
                                                    setState(() {
                                                      quantities[article] =
                                                          qty - 1;
                                                    });
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Quantité minimale est 0',
                                                          style: TextStyle(
                                                            color:
                                                                colorScheme
                                                                    .onPrimary,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            colorScheme.error,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      qty > 0
                                                          ? colorScheme
                                                              .primaryContainer
                                                          : colorScheme
                                                              .surfaceContainerHighest,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  '$qty',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        qty > 0
                                                            ? colorScheme
                                                                .primary
                                                            : colorScheme
                                                                .onSurface
                                                                .withOpacity(
                                                                  0.5,
                                                                ),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.add_circle_outline,
                                                ),
                                                color:
                                                    qty >= article.quantity
                                                        ? colorScheme.onSurface
                                                            .withOpacity(0.3)
                                                        : Colors.green,
                                                onPressed: () {
                                                  if (qty < article.quantity) {
                                                    setState(() {
                                                      quantities[article] =
                                                          qty + 1;
                                                    });
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Quantité maximale atteinte (${article.quantity} disponibles)',
                                                          style: TextStyle(
                                                            color:
                                                                colorScheme
                                                                    .onPrimary,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            colorScheme.error,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 3,
                ),
                onPressed: () {
                  final selected =
                      quantities.entries
                          .where((e) => e.value > 0)
                          .map((e) => {'article': e.key, 'quantity': e.value})
                          .toList();
                  Navigator.pop(context, selected);
                },
                label: const Text('Valider la sélection'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}
