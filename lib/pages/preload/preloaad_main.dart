import 'package:coolmate/colors.dart';
import 'package:coolmate/const.dart';
import 'package:coolmate/database/mysql_db.dart';
import 'package:coolmate/pages/preload/show_users.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PreloadPage extends StatefulWidget {
  PreloadPage({super.key});

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  List<List<String>> listCust = [];
  List<List<String>> listSup = [];
  bool isAdmin = false;
  bool isEditable = false;
  String oldName = '';
  ValueNotifier<bool> isChoosedOne = ValueNotifier(false);
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController nameCont = TextEditingController();
  TextEditingController addrCont = TextEditingController();

  TextEditingController stateCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  pw.Font font = pw.Font();
  TextEditingController gstCont = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setList();
  }

  setList() async {
    listCust = await getPreloadCustomerDB('customer');
    listSup = await getPreloadCustomerDB('supplier');
    setState(() {
      listCust = listCust;
      listSup = listSup;
    });

    PdfGoogleFonts.nunitoExtraLight().then((f) {
      // Use the loaded font here
      font = f;
      // Add the text widget to your PDF document
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Preload customer",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Tab(
                child: Text(
                  "Preload supplier",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: bgcol),
          child: TabBarView(
            children: [
              buildPreloadBody(size, true),
              buildPreloadBody(size, false)
            ],
          ),
        ),
      ),
    );
  }

  ListView buildPreloadBody(Size size, bool isCustomer) {
    return ListView(
      children: [
        Form(
          key: isCustomer ? _formKey1 : _formKey2,
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),

              // Username
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: size.width * .3,
                      child: TextFormField(
                        controller: nameCont,
                        validator: (value) {
                          if (value == '') {
                            return 'Enter Party name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Party name',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * .175,
                      child: TextFormField(
                        controller: addrCont,
                        validator: (value) {
                          if (value == '') {
                            return 'Enter address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Address',
                          prefixIcon: const Icon(Icons.place_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * .14,
                      child: TextFormField(
                        controller: phoneCont,
                        validator: (value) {
                          if (value == '') {
                            return 'Enter phone number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * .12,
                      child: TextFormField(
                        controller: stateCont,
                        validator: (value) {
                          if (value == '') {
                            return 'Enter state name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'State',
                          prefixIcon: const Icon(Icons.location_city),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * .12,
                      child: TextFormField(
                        controller: gstCont,
                        validator: (value) {
                          if (value == '') {
                            return 'Enter TIN';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'TIN',
                          prefixIcon: const Icon(Icons.percent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    onPressed: () async {
                      if (isCustomer
                          ? _formKey1.currentState!.validate()
                          : _formKey2.currentState!.validate()) {
                        setState(() {
                          isCustomer
                              ? listCust.add([
                                  nameCont.text,
                                  addrCont.text,
                                  phoneCont.text,
                                  stateCont.text,
                                  gstCont.text
                                ])
                              : listSup.add([
                                  nameCont.text,
                                  addrCont.text,
                                  phoneCont.text,
                                  stateCont.text,
                                  gstCont.text
                                ]);
                          storePreloadCustomerDB(
                              nameCont.text,
                              addrCont.text,
                              phoneCont.text,
                              stateCont.text,
                              gstCont.text,
                              isCustomer ? 'customer' : 'supplier');
                          nameCont.text = '';
                          addrCont.text = '';
                          phoneCont.text = '';
                          stateCont.text = '';
                          gstCont.text = '';
                        });
                      } else {}
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    onPressed: () async {
                      if (isAdmin && isEditable && isChoosedOne.value) {
                        await updatePreloadData(
                            isCustomer ? 'customer' : 'supplier',
                            nameCont.text,
                            addrCont.text,
                            phoneCont.text,
                            stateCont.text,
                            gstCont.text,
                            oldName);
                        if (isCustomer) {
                          listCust = await getPreloadCustomerDB('customer');
                          // print(x);
                          setState(() {
                            listCust = listCust;
                          });
                        } else {
                          listSup = await getPreloadCustomerDB('supplier');
                          print(listSup);
                          setState(() {
                            listSup = listSup;
                          });
                        }
                      }
                      if (isAdmin) {
                        !isEditable
                            ? showDone(
                                context,
                                'Select One ${isCustomer ? 'Customer' : 'Supplier'}',
                                Icons.person,
                                Colors.green)
                            : showDone(
                                context,
                                'Updated ${isCustomer ? 'Customer' : 'Supplier'}',
                                Icons.done,
                                Colors.green);
                        setState(() {
                          isEditable = !isEditable;
                        });
                        isChoosedOne.value = false;
                        nameCont.text = '';
                        addrCont.text = '';
                        phoneCont.text = '';
                        stateCont.text = '';
                        gstCont.text = '';
                      } else {
                        _showInputDialog(context);
                      }
                    },
                    child: ValueListenableBuilder(
                        valueListenable: isChoosedOne,
                        builder: (context, value, child) => Text(
                              !isEditable
                                  ? 'Edit'
                                  : !isChoosedOne.value
                                      ? 'Choose'
                                      : 'Update',
                              style: const TextStyle(fontSize: 20),
                            )),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    onPressed: () async {
                      if (isAdmin && isEditable && isChoosedOne.value) {
                        await deletePreloadData(
                            isCustomer ? 'customer' : 'supplier', oldName);
                        if (isCustomer) {
                          listCust = await getPreloadCustomerDB('customer');
                          // print(x);
                          setState(() {
                            listCust = listCust;
                          });
                        } else {
                          listSup = await getPreloadCustomerDB('supplier');
                          print(listSup);
                          setState(() {
                            listSup = listSup;
                          });
                        }
                      }
                      if (isAdmin) {
                        !isEditable
                            ? showDone(
                                context,
                                'Select One ${isCustomer ? 'Customer' : 'Supplier'}',
                                Icons.person,
                                Colors.green)
                            : showDone(
                                context,
                                'Deleted ${isCustomer ? 'Customer' : 'Supplier'}',
                                Icons.done,
                                Colors.green);
                        setState(() {
                          isEditable = !isEditable;
                        });
                        isChoosedOne.value = false;
                        nameCont.text = '';
                        addrCont.text = '';
                        phoneCont.text = '';
                        stateCont.text = '';
                        gstCont.text = '';
                      } else {
                        _showInputDialog(context);
                      }
                    },
                    child: ValueListenableBuilder(
                        valueListenable: isChoosedOne,
                        builder: (context, value, child) => Text(
                              !isEditable
                                  ? 'Delete'
                                  : !isChoosedOne.value
                                      ? 'Choose'
                                      : 'Delete',
                              style: const TextStyle(fontSize: 20),
                            )),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      isChoosedOne.value = false;
                      nameCont.text = '';
                      addrCont.text = '';
                      phoneCont.text = '';
                      stateCont.text = '';
                      gstCont.text = '';
                    },
                    child: const Text('Drop'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        isAdmin = false;
                        setState(() {
                          isEditable = false;
                        });
                        isChoosedOne.value = false;
                        nameCont.text = '';
                        addrCont.text = '';
                        phoneCont.text = '';
                        stateCont.text = '';
                        gstCont.text = '';
                      },
                      child: const Text('Reset')),
                  ElevatedButton(
                      onPressed: () {
                        // _printPdf(context, isCustomer);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ViewUsers(
                                isCustomer: isCustomer,
                                listUsers: isCustomer ? listCust : listSup);
                          },
                        ));
                      },
                      child: const Text('Print'))
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Table(
            columnWidths: const {
              0: FractionColumnWidth(0.3),
              1: FractionColumnWidth(0.3),
              2: FractionColumnWidth(0.15),
              3: FractionColumnWidth(0.15),
              4: FractionColumnWidth(0.1),
            },
            border: TableBorder.all(borderRadius: BorderRadius.circular(7.5)),
            children: loadData(
              isCustomer ? listCust : listSup,
            ),
          ),
        )
      ],
    );
  }

  Future<void> _showInputDialog(BuildContext context) async {
    TextEditingController _textEditingController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter password'),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: "Enter admin password"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                if (_textEditingController.text == '123456') {
                  isAdmin = true;
                  showDone(context, 'Access granted', Icons.done, Colors.green);
                } else {
                  showDone(context, 'Access denied', Icons.error, Colors.red);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<TableRow> loadData(
    List<List<String>> list,
  ) {
    var k = [
      loadRow(['Party name', 'Address', 'Phone', 'State', 'TIN'],
          isHeader: true)
    ];
    list.forEach((element) {
      k.add(loadRow(element));
    });
    return k;
  }

  TableRow loadRow(List<String> list, {bool isHeader = false}) {
    final myStyle = TextStyle(
      fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
      fontSize: isHeader ? 20 : 18,
    );

    return TableRow(
      children: [
        GestureDetector(
          onTap: () {
            if (isEditable) {
              oldName = list[0];
              nameCont.text = list[
                  0]; // Set the value of nameCont to the first element of the row
              addrCont.text = list[1];
              phoneCont.text = list[2];
              stateCont.text = list[3];
              gstCont.text = list[4];
              isChoosedOne.value = true;
            }
          },
          child: Padding(
            padding: isEditable
                ? const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
                : const EdgeInsets.all(8.0),
            child: isHeader
                ? Center(child: Text(list[0], style: myStyle))
                : isEditable
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_right_alt_rounded,
                                size: 20,
                              )),
                          Text(list[0],
                              style: TextStyle(
                                color: col10,
                                fontWeight: isHeader
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                fontSize: isHeader ? 20 : 20,
                              )),
                        ],
                      )
                    : Text(list[0], style: myStyle),
          ),
        ),
        // Repeat for other cells in the row
        for (int i = 1; i < list.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isHeader
                ? Center(child: Text(list[i], style: myStyle))
                : Text(list[i], style: myStyle),
          ),
      ],
    );
  }

//-----------PDF
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
        pageFormat: format,
        build: (context) {
          return pw.Padding(
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: pw.Table(
              columnWidths: const {
                0: pw.FractionColumnWidth(0.3),
                1: pw.FractionColumnWidth(0.3),
                2: pw.FractionColumnWidth(0.15),
                3: pw.FractionColumnWidth(0.15),
                4: pw.FractionColumnWidth(0.1),
              },
              border: pw.TableBorder.all(),
              children: loadDataForPDF(isCustomer ? listCust : listSup, font),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> _printPdf(BuildContext context, bool isCustomer) async {
    await Printing.layoutPdf(
        onLayout: (format) => _generatePdfAll(format, isCustomer));
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
    fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.bold,
    fontSize: isHeader ? 20 : 18,
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



////---------------------------------------
////
////
///////
////      when change tab, clear fields
///////
////////
////