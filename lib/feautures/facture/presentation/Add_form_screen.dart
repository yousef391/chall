import 'package:challenge_fac_app/feautures/facture/data/models/article.dart';
import 'package:challenge_fac_app/feautures/facture/data/models/invoice.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/article_picker_bottom_sheet.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/viewmodels/article_view_model.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/viewmodels/invoice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoiceForm extends StatefulWidget {
  const InvoiceForm({super.key});

  @override
  State<InvoiceForm> createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  DateTime? _selectedDate;
  final List<Map<String, dynamic>> _selectedArticles = [];

  double get totalHT => _selectedArticles.fold(
    0,
    (sum, item) => sum + (item['article'].unitPrice * item['quantity']),
  );
  double get tva => totalHT * 0.2;
  double get totalTTC => totalHT + tva;

  @override
  Widget build(BuildContext context) {
    final articleVM = Provider.of<ArticleViewModel>(context);
    final articles = articleVM.articles;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Créer une facture', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 32 : 12,
              vertical: 18,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Card(
                    color: colorScheme.surfaceContainerHighest,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informations client',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Nom du client',
                              labelStyle: TextStyle(
                                color: colorScheme.onSurface,
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: colorScheme.primary,
                              ),
                              filled: true,
                              fillColor: colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: colorScheme.onSurface,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Veuillez entrer le nom du client';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email du client',
                              labelStyle: TextStyle(
                                color: colorScheme.onSurface,
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: colorScheme.primary,
                              ),
                              filled: true,
                              fillColor: colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 16,
                              color: colorScheme.onSurface,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Veuillez entrer un email';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedDate == null
                                      ? 'Sélectionner une date'
                                      : DateFormat(
                                        'dd/MM/yyyy',
                                      ).format(_selectedDate!),
                                  style: TextStyle(
                                    color:
                                        _selectedDate == null
                                            ? colorScheme.onSurface.withOpacity(
                                              0.5,
                                            )
                                            : colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: _pickDate,
                                icon: const Icon(Icons.calendar_today),
                                label: const Text('Choisir la date'),
                              ),
                            ],
                          ),
                          if (_selectedDate == null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 8),
                              child: Text(
                                'Veuillez choisir une date',
                                style: TextStyle(
                                  color: colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    color: colorScheme.surfaceContainerHighest,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Articles de la facture',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _selectedArticles.isEmpty
                              ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Text(
                                    'Aucun article',
                                    style: TextStyle(
                                      color: colorScheme.onSurface.withOpacity(
                                        0.5,
                                      ),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                              : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _selectedArticles.length,
                                separatorBuilder:
                                    (_, __) => const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final item = _selectedArticles[index];
                                  final article = item['article'] as Article;
                                  final qty = item['quantity'] as int;
                                  return Card(
                                    elevation: 0.7,
                                    color: colorScheme.surface,
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                      leading: CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            colorScheme.primaryContainer,
                                        child: Icon(
                                          Icons.inventory_2,
                                          color: colorScheme.primary,
                                          size: 18,
                                        ),
                                      ),
                                      title: Text(
                                        article.name,
                                        style: textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.description,
                                            style: textTheme.bodySmall
                                                ?.copyWith(
                                                  color: colorScheme.onSurface
                                                      .withOpacity(0.7),
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Wrap(
                                            spacing: 4,
                                            runSpacing: 2,
                                            children: [
                                              Chip(
                                                label: Text(
                                                  'PU: ${article.unitPrice} DZD',
                                                  style: TextStyle(
                                                    color:
                                                        colorScheme.onPrimary,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    colorScheme.primary,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 0,
                                                    ),
                                                visualDensity:
                                                    VisualDensity.compact,
                                              ),
                                              Chip(
                                                label: Text(
                                                  'Qté: $qty',
                                                  style: TextStyle(
                                                    color:
                                                        colorScheme.onPrimary,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    colorScheme.secondary,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 0,
                                                    ),
                                                visualDensity:
                                                    VisualDensity.compact,
                                              ),
                                              Chip(
                                                label: Text(
                                                  'Total: ${(article.unitPrice * qty).toStringAsFixed(2)} DZD',
                                                  style: TextStyle(
                                                    color:
                                                        colorScheme.onPrimary,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    colorScheme.tertiary,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 0,
                                                    ),
                                                visualDensity:
                                                    VisualDensity.compact,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: colorScheme.error,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _selectedArticles.removeAt(index);
                                            articles.firstWhere((a) {
                                              if (a.id == article.id) {
                                                a.quantity += qty;
                                              }
                                              return a.id == article.id;
                                            });
                                          });
                                        },
                                      ),
                                      isThreeLine: false,
                                    ),
                                  );
                                },
                              ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                elevation: 2,
                              ),
                              onPressed: () async {
                                final articleVM = Provider.of<ArticleViewModel>(
                                  context,
                                  listen: false,
                                );
                                final selectedArticle =
                                    await showArticlePickerBottomSheet(
                                      context,
                                      articles,
                                    );
                                if (selectedArticle != null) {
                                  setState(() {
                                    for (var item in selectedArticle) {
                                      final Article article = item['article'];
                                      final int qty = item['quantity'];
                                      final existingIndex = _selectedArticles
                                          .indexWhere(
                                            (e) =>
                                                e['article'].id == article.id,
                                          );
                                      if (existingIndex != -1) {
                                        _selectedArticles[existingIndex]['quantity'] +=
                                            qty;
                                      } else {
                                        _selectedArticles.add({
                                          'article': article,
                                          'quantity': qty,
                                        });
                                      }
                                      articles.firstWhere((a) {
                                        if (a.id == article.id &&
                                            a.quantity >= qty) {
                                          a.quantity -= qty;
                                        } else if (a.id == article.id &&
                                            a.quantity < qty) {
                                          a.quantity = 0;
                                        }
                                        return a.id == article.id;
                                      });
                                    }
                                  });
                                }
                              },
                              icon: const Icon(Icons.add, size: 22),
                              label: const Text('Ajouter un article'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    color: colorScheme.surfaceContainerHighest,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Résumé de la facture',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total HT', style: textTheme.bodyLarge),
                              Text(
                                '${totalHT.toStringAsFixed(2)} DZD',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('TVA (20%)', style: textTheme.bodyLarge),
                              Text(
                                '${tva.toStringAsFixed(2)} DZD',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total TTC', style: textTheme.bodyLarge),
                              Text(
                                '${totalTTC.toStringAsFixed(2)} DZD',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.secondary,
                        foregroundColor: colorScheme.onSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        elevation: 3,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _selectedDate != null) {
                          final invoice = Invoice(
                            clientName: _nameController.text.trim(),
                            clientEmail: _emailController.text.trim(),
                            invoiceDate: _selectedDate!,
                            articles: _selectedArticles,
                          );
                          final invoiceVM = Provider.of<InvoiceListViewModel>(
                            context,
                            listen: false,
                          );
                          invoiceVM.addInvoice(invoice);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Facture créée avec succès !',
                                style: TextStyle(color: colorScheme.onPrimary),
                              ),
                              backgroundColor: colorScheme.primary,
                            ),
                          );
                        } else {
                          if (_selectedDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Veuillez choisir une date',
                                  style: TextStyle(
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                                backgroundColor: colorScheme.error,
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Valider la facture'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        final colorScheme = Theme.of(context).colorScheme;
        return Theme(
          data: Theme.of(context).copyWith(colorScheme: colorScheme),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
