import 'package:dsd/views/invoice/model/customer.dart';
import 'package:dsd/views/invoice/api/pdf_api.dart';
import 'package:dsd/views/invoice/api/pdf_invoice_api.dart';
import 'package:dsd/views/invoice/model/inovice.dart';
import 'package:dsd/views/invoice/model/supplier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

final date = DateTime.now();
final dueDate = date.add(const Duration(days: 7));

final invoice = Invoice(
  supplier: const Supplier(
    name: 'Sarah Field',
    address: 'Sarah Street 9, Beijing, China',
    paymentInfo: 'https://paypal.me/sarahfieldzz',
  ),
  customer: const Customer(
    name: 'Apple Inc.',
    address: 'Apple Street, Cupertino, CA 95014',
  ),
  info: InvoiceInfo(
    date: date,
    dueDate: dueDate,
    description: 'My description...',
    number: '${DateTime.now().year}-9999',
  ),
  items: [
    InvoiceItem(
      description: 'Coffee',
      date: DateTime.now(),
      quantity: 3,
      vat: 0.19,
      unitPrice: 5.99,
    ),
    InvoiceItem(
      description: 'Water',
      date: DateTime.now(),
      quantity: 8,
      vat: 0.19,
      unitPrice: 0.99,
    ),
    InvoiceItem(
      description: 'Orange',
      date: DateTime.now(),
      quantity: 3,
      vat: 0.19,
      unitPrice: 2.99,
    ),
    InvoiceItem(
      description: 'Apple',
      date: DateTime.now(),
      quantity: 8,
      vat: 0.19,
      unitPrice: 3.99,
    ),
    InvoiceItem(
      description: 'Mango',
      date: DateTime.now(),
      quantity: 1,
      vat: 0.19,
      unitPrice: 1.59,
    ),
    InvoiceItem(
      description: 'Blue Berries',
      date: DateTime.now(),
      quantity: 5,
      vat: 0.19,
      unitPrice: 0.99,
    ),
    InvoiceItem(
      description: 'Lemon',
      date: DateTime.now(),
      quantity: 4,
      vat: 0.19,
      unitPrice: 1.29,
    ),
    InvoiceItem(
      description: 'Coffee',
      date: DateTime.now(),
      quantity: 3,
      vat: 0.19,
      unitPrice: 5.99,
    ),
    InvoiceItem(
      description: 'Water',
      date: DateTime.now(),
      quantity: 8,
      vat: 0.19,
      unitPrice: 0.99,
    ),
    InvoiceItem(
      description: 'Orange',
      date: DateTime.now(),
      quantity: 3,
      vat: 0.19,
      unitPrice: 2.99,
    ),
    InvoiceItem(
      description: 'Apple',
      date: DateTime.now(),
      quantity: 8,
      vat: 0.19,
      unitPrice: 3.99,
    ),
    InvoiceItem(
      description: 'Mango',
      date: DateTime.now(),
      quantity: 1,
      vat: 0.19,
      unitPrice: 1.59,
    ),
    InvoiceItem(
      description: 'Blue Berries',
      date: DateTime.now(),
      quantity: 5,
      vat: 0.19,
      unitPrice: 0.99,
    ),
    InvoiceItem(
      description: 'Lemon',
      date: DateTime.now(),
      quantity: 4,
      vat: 0.19,
      unitPrice: 1.29,
    ),
  ],
);

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Generate Invoice...'),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: (() async {
                    print('file creating');
                    final pdfFile = await PdfInvoiceApi.generate(invoice);
                    PdfApi.openFile(pdfFile);
                  }),
                  child: const Text('Generate Invocie PDF')),
            ],
          ),
        ),
      ),
    );
  }
}
