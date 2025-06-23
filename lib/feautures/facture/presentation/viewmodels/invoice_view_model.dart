// lib/viewmodels/invoice_list_view_model.dart
import 'package:challenge_fac_app/feautures/facture/data/models/invoice.dart';
import 'package:flutter/material.dart';

class InvoiceListViewModel extends ChangeNotifier {
  List<Invoice> invoices = [];

  void addInvoice(Invoice invoice) {
    invoices.add(invoice);
    notifyListeners();
  }

  void removeInvoice(int index) {
    invoices.removeAt(index);
    notifyListeners();
  }

  Invoice getInvoice(int index) {
    return invoices[index];
  }
}
