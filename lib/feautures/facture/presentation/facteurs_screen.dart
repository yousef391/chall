// lib/feautures/facture/presentation/screens/invoice_list_screen.dart

import 'package:challenge_fac_app/feautures/facture/presentation/invoice_details_screen.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/viewmodels/invoice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

class InvoiceListScreen extends StatelessWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceListVM = Provider.of<InvoiceListViewModel>(context);

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Toutes les Factures', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body:
          invoiceListVM.invoices.isEmpty
              ? Center(
                child: Text(
                  "Aucune facture disponible.",
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              )
              : ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                itemCount: invoiceListVM.invoices.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final invoice = invoiceListVM.invoices[index];
                  return Card(
                    elevation: 2,
                    color: colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: colorScheme.primaryContainer,
                        child: Icon(
                          Icons.receipt_long,
                          color: colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        invoice.clientName,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            invoice.clientEmail,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Date : ${DateFormat('dd/MM/yyyy').format(invoice.invoiceDate)}',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 8,
                            children: [
                              Chip(
                                label: Text(
                                  'Articles: ${invoice.articles.length}',
                                  style: TextStyle(
                                    color: colorScheme.onPrimary,
                                    fontSize: 11,
                                  ),
                                ),
                                backgroundColor: colorScheme.primary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 0,
                                ),
                              ),
                              Chip(
                                label: Text(
                                  'Total TTC: ${invoice.totalTTC.toStringAsFixed(2)} DZD',
                                  style: TextStyle(
                                    color: colorScheme.onPrimary,
                                    fontSize: 11,
                                  ),
                                ),
                                backgroundColor: colorScheme.secondary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    InvoiceDetailScreen(invoice: invoice),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
