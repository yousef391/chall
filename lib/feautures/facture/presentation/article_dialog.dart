import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:challenge_fac_app/feautures/facture/data/models/article.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/viewmodels/article_view_model.dart';

Future<void> showArticleDialog(
  BuildContext context, {
  Article? article,
  int? index,
}) async {
  final isEdit = article != null;
  final nameController = TextEditingController(text: article?.name ?? '');
  final descController = TextEditingController(
    text: article?.description ?? '',
  );
  final priceController = TextEditingController(
    text: article?.unitPrice.toString() ?? '',
  );
  final qtyController = TextEditingController(
    text: article?.quantity.toString() ?? '',
  );
  final colorScheme = Theme.of(context).colorScheme;
  final formKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder:
        (ctx) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isEdit ? 'Modifier l\'article' : 'Ajouter un article',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        labelStyle: TextStyle(color: colorScheme.onSurface),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.label,
                          color: colorScheme.primary,
                        ),
                      ),
                      style: TextStyle(color: colorScheme.onSurface),
                      validator:
                          (value) =>
                              value == null || value.trim().isEmpty
                                  ? 'Nom requis'
                                  : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: descController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: colorScheme.onSurface),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.description,
                          color: colorScheme.primary,
                        ),
                      ),
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Prix unitaire (DZD)',
                        labelStyle: TextStyle(color: colorScheme.onSurface),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: colorScheme.primary,
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(color: colorScheme.onSurface),
                      validator: (value) {
                        final price = double.tryParse(value ?? '');
                        if (price == null || price <= 0) {
                          return 'Prix valide requis';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: qtyController,
                      decoration: InputDecoration(
                        labelText: 'Quantité en stock',
                        labelStyle: TextStyle(color: colorScheme.onSurface),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.numbers,
                          color: colorScheme.primary,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: colorScheme.onSurface),
                      validator: (value) {
                        final qty = int.tryParse(value ?? '');
                        if (qty == null || qty < 0) {
                          return 'Quantité valide requise';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Annuler'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              final name = nameController.text.trim();
                              final desc = descController.text.trim();
                              final price =
                                  double.tryParse(priceController.text) ?? 0;
                              final qty = int.tryParse(qtyController.text) ?? 0;
                              final newArticle = Article(
                                id:
                                    isEdit
                                        ? article.id
                                        : DateTime.now().millisecondsSinceEpoch,
                                name: name,
                                description: desc,
                                unitPrice: price,
                                quantity: qty,
                              );
                              final articleVM = Provider.of<ArticleViewModel>(
                                context,
                                listen: false,
                              );
                              if (isEdit && index != null) {
                                articleVM.updateArticle(index, newArticle);
                              } else {
                                articleVM.addArticle(newArticle);
                              }
                              Navigator.pop(ctx);
                            }
                          },
                          child: Text(isEdit ? 'Enregistrer' : 'Ajouter'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
  );
}
