import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/views/invoice/api/pdf_api.dart';
import 'package:dsd/views/invoice/api/pdf_invoice_api.dart';
import 'package:dsd/views/invoice/model/inovice.dart';
import 'package:dsd/views/invoice/model/supplier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

final date = DateTime.now();
final dueDate = date.add(const Duration(days: 7));

final invoice = Invoice(
    custoemrId: '',
    info: InvoiceInfo(
      date: date,
      dueDate: dueDate,
      description: 'My description...',
      number: '${DateTime.now().year}-9999',
    ),
    items: []);

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Consumer(
          builder: (context, ref, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: (() async {
                      final pdfFile = await PdfInvoiceApi.generate(invoice);
                      PdfApi.openFile(pdfFile);
                    }),
                    child: const Text('Generate Invocie PDF')),
              ],
            );
          },
        ),
      ),
    );
  }
}
