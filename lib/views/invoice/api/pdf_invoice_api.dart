import 'dart:io';
import 'package:dsd/db/db_provider.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/views/invoice/api/pdf_api.dart';

import 'package:dsd/views/invoice/model/inovice.dart';
import 'package:dsd/views/invoice/model/supplier.dart';

import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    final ByteData bytes =
        await rootBundle.load('assets/images/invoice_logo.png');

    final Customer customer =
        await DBProvier.db.getCustomerById(invoice.custoemrId);

    pdf.addPage(MultiPage(
      build: (context) => [
        // buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
      header: (context) => buildHeader(invoice, bytes, customer),
    ));

    return PdfApi.saveDocument(name: '${invoice.invoiceNumber}.pdf', pdf: pdf);
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Selling real, Good ice cream.', value: ''),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: 'NAIA DSD', value: ''),
        ],
      );

  static Widget buildTotal(Invoice invoice) {
    final totalItems = invoice.items
        .map((item) => item.reOrderQuantity * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                  child: Row(children: [
                Text('Total Cases : ', style: addressTextStyle),
                Text(
                  totalItems.toString(),
                ),
              ]))),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextRow(
                  title: 'Sub total',
                  value: '\$${invoice.total!.toStringAsFixed(2)}',
                  unite: true,
                ),
                SizedBox(height: 4),
                buildTextRow(
                  title: 'Sales Tax ',
                  value: '',
                  unite: true,
                ),
                Divider(),
                buildTextRow(
                  title: 'Total',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: '\$${invoice.total!.toStringAsFixed(2)}',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildHeader(
          Invoice invoice, ByteData bytes, Customer customer) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildHeaderIcon(bytes),
              buildOfficeAddress(),
              buildInvoiceInfo(invoice.info, invoice.invoiceNumber),

              //buildSupplierAddress(invoice.supplier),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerSoldToAddress(customer),
              buildCustomerShipToAddress(customer),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),

          buildCustomerInfor(customer),
          // buildCustomerInformation(
          //   customer,
          // ),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      );

  static Image buildHeaderIcon(ByteData bytes) {
    final Uint8List byteList = bytes.buffer.asUint8List();
    return Image(
        width: 80,
        height: 80,
        MemoryImage(
          byteList,
        ),
        fit: BoxFit.fill);
  }

  static TextStyle addressTextStyle = TextStyle(fontWeight: FontWeight.bold);
  static Widget buildOfficeAddress() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('736 Alfred Nobel Drive', style: addressTextStyle),
            SizedBox(height: 1 * PdfPageFormat.mm),
            Text('Hercules, CA 94547', style: addressTextStyle),
            SizedBox(height: 1 * PdfPageFormat.mm),
            Text('USA', style: addressTextStyle),
            SizedBox(height: 1 * PdfPageFormat.mm),
            Text('Voice: 510-724-2479', style: addressTextStyle),
            SizedBox(height: 1 * PdfPageFormat.mm),
            // Text('Fax: 510-291-2849', style: addressTextStyle),
            SizedBox(height: 1 * PdfPageFormat.mm),
          ]);
  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.customerName,
              style: TextStyle(fontWeight: FontWeight.bold)),
          customer.shipToAddressLineTwo.isNotEmpty
              ? Text(
                  '${customer.shipToAddressLineOne}\n${customer.shipToAddressLineTwo}\n${customer.shipToCity} \n${customer.shipToSate} - ${customer.shipToZip}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )
              : Text(
                  '${customer.shipToAddressLineOne}\n${customer.shipToCity} \n${customer.shipToSate} - ${customer.shipToZip}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
        ],
      );

  static Widget buildCustomerSoldToAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Sold To :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          SizedBox(height: 10),
          Text(customer.customerName,
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          customer.shipToAddressLineTwo.isNotEmpty
              ? Text(
                  '${customer.shipToAddressLineOne}\n${customer.shipToAddressLineTwo}\n${customer.shipToCity} \n${customer.shipToSate} - ${customer.shipToZip}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )
              : Text(
                  '${customer.shipToAddressLineOne}\n${customer.shipToCity} \n${customer.shipToSate} - ${customer.shipToZip}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
        ],
      );
  static Widget buildCustomerShipToAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ship To :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          SizedBox(height: 10),
          Text(customer.customerName,
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          customer.shipToAddressLineTwo.isNotEmpty
              ? Text(
                  '${customer.shipToAddressLineOne}\n${customer.shipToAddressLineTwo}\n${customer.shipToCity} \n${customer.shipToSate} - ${customer.shipToZip}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )
              : Text(
                  '${customer.shipToAddressLineOne}\n${customer.shipToCity} \n${customer.shipToSate} - ${customer.shipToZip}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
        ],
      );
  static BoxDecoration borders =
      BoxDecoration(border: Border.all(color: PdfColors.black));

  static Widget buildTitle(Invoice invoice) => Column(children: [
        Text('Invoice',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Text(invoice.info.description),
      ]);

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info, String invoiceNumber) {
    final titles = <String>[
      'Invoice',
      'Invoice Number:',
      'Invoice Date:',
    ];
    final data = <String>[
      '',
      invoiceNumber,
      info.date.toString(),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static buildCustomerInfor(Customer customer) {
    const paymentTerms = '30 days';
    final headers = [
      'Customer Id',
      'Customer PO',
      'Payment Terms',
    ];
    final data = [
      [customer.customerId, '', paymentTerms]
    ];
    return Table.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: const BoxDecoration(color: PdfColors.grey200),
        cellHeight: 25,
        headerHeight: 20,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
        });
  }

  static buildCustomerInformation(Customer customer) {
    final headers = [
      'Sales Rep Id',
      'Shipping Method',
      'Ship Date',
      'Due Date'
    ];
    final data = [
      [customer.customerId, '', '', 'Next 30 days']
    ];
    return Table.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: const BoxDecoration(color: PdfColors.grey200),
        cellHeight: 25,
        headerHeight: 20,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
          3: Alignment.centerRight,
        });
  }

  static buildInvoice(Invoice invoice) {
    final headers = [
      'Quantity',
      'Item',
      'Description',
      'Unit Price',
      'Extension',
    ];
    final data = invoice.items.map((item) {
      return [
        item.quantity * item.reOrderQuantity,
        item.itemId,
        item.itemDescription,
        '${item.itemId.substring(4) == "996" ? "- " : ""}\$${item.saleprice.toStringAsFixed(2)}',
        '${item.itemId.substring(4) == "996" ? "- " : ""}\$${item.totalPrice.toStringAsFixed(2)}',
      ];
    }).toList();
    return Table.fromTextArray(
        headers: headers,
        data: data,
        // border: TableBorder(
        //     bottom: BorderSide(
        //   color: PdfColors.black,
        //   width: 2,
        // )),
        cellDecoration: (index, data, rowNum) {
          Border firstRowBorder = const Border(
            bottom: BorderSide.none,
            top: BorderSide.none,
            left: BorderSide(
              color: PdfColors.black,
            ),
            right: BorderSide(
              color: PdfColors.black,
            ),
          );
          Border lastRowBorder = const Border(
            left: BorderSide.none,
            right: BorderSide.none,
            top: BorderSide(
              color: PdfColors.black,
            ),
            bottom: BorderSide(
              color: PdfColors.black,
            ),
          );

          return BoxDecoration(border: firstRowBorder);
        },
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: const BoxDecoration(color: PdfColors.grey200),
        cellHeight: 25,
        headerHeight: 20,
        headerAlignments: {
          0: Alignment.center,
          1: Alignment.center,
          2: Alignment.center,
          3: Alignment.center,
          4: Alignment.center,
        },
        cellAlignments: {
          0: Alignment.centerRight,
          1: Alignment.centerLeft,
          2: Alignment.centerLeft,
          3: Alignment.centerRight,
          4: Alignment.centerRight,
        });
  }

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildTextForCustomerInfo({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: style),
                    Text(value, style: unite ? style : null),
                  ])),
        ],
      ),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: style),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static buildTextRow({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
