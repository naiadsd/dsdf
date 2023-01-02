import 'package:dsd/state/cart/models/cart_item.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/views/invoice/model/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  //final Supplier supplier;
  //final Customer customer;
  final String custoemrId;
  final List<CartItem> items;
  final String invoiceNumber;

  double? total;

  Invoice({
    required this.info,
    // required this.supplier,
    required this.custoemrId,
    required this.items,
    this.total = 0.0,
    required this.invoiceNumber,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final int quantity;
  final double vat;
  final double unitPrice;

  const InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}
