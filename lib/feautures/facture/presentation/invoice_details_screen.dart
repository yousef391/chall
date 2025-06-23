import 'package:challenge_fac_app/feautures/facture/data/models/article.dart';
import 'package:challenge_fac_app/feautures/facture/data/models/invoice.dart';
import 'package:flutter/material.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final Invoice invoice;
  const InvoiceDetailScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la facture'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 40 : 16,
          vertical: isWide ? 24 : 16,
        ),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.blue[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    invoice.clientName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isWide ? 20 : 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.email, color: Colors.blueGrey[400], size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    invoice.clientEmail,
                    style: TextStyle(
                      fontSize: isWide ? 16 : 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.deepPurple, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Date : ${invoice.invoiceDate.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(fontSize: isWide ? 16 : 14),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Articles',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),
            ...invoice.articles.map<Widget>((item) {
              final Article article = item['article'];
              final int qty = item['quantity'];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                elevation: 1,
                child: ListTile(
                  dense: !isWide,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isWide ? 20 : 10,
                    vertical: isWide ? 12 : 6,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[50],
                    child: Icon(
                      Icons.inventory_2,
                      color: Colors.blue[700],
                      size: isWide ? 26 : 20,
                    ),
                  ),
                  title: Text(
                    article.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: isWide ? 16 : 14,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isWide ? 13 : 11,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Wrap(
                        spacing: 6,
                        runSpacing: 2,
                        children: [
                          Chip(
                            label: Text(
                              'PU: ${article.unitPrice} DZD',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 0,
                            ),
                          ),
                          Chip(
                            label: Text(
                              'Qté: $qty',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 0,
                            ),
                          ),
                          Chip(
                            label: Text(
                              'Total: ${(article.unitPrice * qty).toStringAsFixed(2)} DZD',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Total HT : ${invoice.totalHT.toStringAsFixed(2)} DZD',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    'TVA (20%) : ${invoice.tva.toStringAsFixed(2)} DZD',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Total TTC : ${invoice.totalTTC.toStringAsFixed(2)} DZD',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
