import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ViewUsers extends StatelessWidget {
  final bool isCustomer;
  final List<List<String>> listUsers;

  const ViewUsers({Key? key, required this.isCustomer, required this.listUsers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Preview')),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: PdfPreview(
                    build: (format) => _generatePdfAll(format, isCustomer),
                    canChangeOrientation: false,
                    canDebug: false,
                    maxPageWidth: MediaQuery.of(context).size.width * .3,
                    dynamicLayout: true,
                    initialPageFormat: PdfPageFormat.a4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> _generatePdfAll(
      PdfPageFormat format, bool isCustomer) async {
    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
      pageMode: PdfPageMode.outlines,
    );

    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        pageFormat: format,
        build: (context) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Center(
                        child: pw.Text(
                            isCustomer
                                ? 'Preload Customers'
                                : 'Preload Suppliers',
                            style: pw.TextStyle(
                                font: font,
                                fontSize: 40,
                                fontWeight: pw.FontWeight.bold,
                                decoration: pw.TextDecoration.underline))),
                    pw.SizedBox(height: 20),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: pw.Table(
                        tableWidth: pw.TableWidth.max,
                        columnWidths: const {
                          0: pw.FractionColumnWidth(1.5),
                          1: pw.FractionColumnWidth(2),
                          2: pw.FractionColumnWidth(1.5),
                          3: pw.FractionColumnWidth(1),
                          4: pw.FractionColumnWidth(1),
                        },
                        border: pw.TableBorder.all(),
                        children: loadDataForPDF(listUsers, font),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(
                  width: 500, // Adjust width as needed
                  height: 100, // Adjust height as needed
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Coolmate',
                        style: pw.TextStyle(
                            font: font,
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'Address: Street Address, City, Country',
                        style: pw.TextStyle(font: font, fontSize: 12),
                      ),
                      pw.Text(
                        'Phone: +1234567890',
                        style: pw.TextStyle(font: font, fontSize: 12),
                      ),
                      pw.Text(
                        'Email: company@example.com',
                        style: pw.TextStyle(font: font, fontSize: 12),
                      ),
                    ],
                  ),
                )
              ]);
        },
      ),
    );

    return pdf.save();
  }
}

List<pw.TableRow> loadDataForPDF(List<List<String>> list, pw.Font f) {
  var k = [
    loadRowForPDF(['Party name', 'Address', 'Phone', 'State', 'TIN'], f,
        isHeader: true)
  ];
  list.forEach((element) {
    k.add(loadRowForPDF(element, f));
  });
  return k;
}

pw.TableRow loadRowForPDF(List<String> list, pw.Font f,
    {bool isHeader = false}) {
  final myStyle = pw.TextStyle(
    font: f,
    fontWeight: pw.FontWeight.bold,
    fontSize: isHeader ? 20 : 18,
    color: isHeader ? PdfColors.black : PdfColors.grey900,
  );

  return pw.TableRow(
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(8.0),
        child: isHeader
            ? pw.Center(child: pw.Text(list[0], style: myStyle))
            : pw.Text(list[0], style: myStyle),
      ),
      // Repeat for other cells in the row
      for (int i = 1; i < list.length; i++)
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: isHeader
              ? pw.Center(child: pw.Text(list[i], style: myStyle))
              : pw.Text(list[i], style: myStyle),
        ),
    ],
  );
}
