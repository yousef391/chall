// lib/models/invoice.dart

class Invoice {
  String clientName;
  String clientEmail;
  DateTime invoiceDate;
  List<Map<String, dynamic>> articles;

  Invoice({
    required this.clientName,
    required this.clientEmail,
    required this.invoiceDate,
    required this.articles,
  });

  double get totalHT => articles.fold(
    0,
    (sum, item) => sum + (item['article']!.unitPrice * item['quantity']!),
  );

  double get tva => totalHT * 0.2;

  double get totalTTC => totalHT + tva;
}
