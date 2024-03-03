import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TempPdf extends StatelessWidget {
  const TempPdf({super.key});

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
                    build: (format) =>
                        _generatePdfAll(format, ['title1', 'title2', 'tile3']),
                    canChangeOrientation: false,
                    canDebug: false,
                    maxPageWidth: MediaQuery.of(context).size.width * .3,
                    dynamicLayout: true,
                    initialPageFormat: PdfPageFormat.legal,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _printPdf(context),
            child: Text('Print All Pages'),
          ),
        ],
      ),
    );
  }

  // Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
  //   final pdf = pw.Document(
  //     version: PdfVersion.pdf_1_5,
  //     compress: true,
  //     pageMode: PdfPageMode.outlines,
  //   );

  //   final font = await PdfGoogleFonts.nunitoExtraLight();

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: format,
  //       build: (context) {
  //         return pw.Column(
  //           mainAxisAlignment: pw.MainAxisAlignment.center,
  //           crossAxisAlignment: pw.CrossAxisAlignment.center,
  //           children: [
  //             pw.SizedBox(
  //               width: 100,
  //               child: pw.FittedBox(
  //                 child: pw.Text(
  //                   title,
  //                   style: pw.TextStyle(font: font, fontSize: 20),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );

  //   return pdf.save();
  // }

  Future<Uint8List> _generatePdfAll(
      PdfPageFormat format, List<String> titles) async {
    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
      pageMode: PdfPageMode.outlines,
    );

    final font = await PdfGoogleFonts.nunitoExtraLight();

    titles.forEach((element) {
      pdf.addPage(
        pw.Page(
          pageFormat: format,
          build: (context) {
            return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(
                  width: 100,
                  child: pw.Center(
                    child: pw.Text(
                      element,
                      style: pw.TextStyle(font: font, fontSize: 20),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });

    return pdf.save();
  }

  Future<void> _printPdf(BuildContext context) async {
    await Printing.layoutPdf(
        onLayout: (format) =>
            _generatePdfAll(format, ['title1', 'title2', 'tile3']));
  }
}
