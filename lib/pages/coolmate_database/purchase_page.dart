import 'package:coolmate/colors.dart';
import 'package:coolmate/const.dart';
import 'package:coolmate/database/mysql_db.dart';
import 'package:coolmate/pages/coolmate_database/add_item.dart';
import 'package:coolmate/pages/coolmate_database/print_invoice.dart';
import 'package:fluid_dialog/fluid_dialog.dart';

import 'package:flutter/material.dart';

class PurchasePage extends StatefulWidget {
  PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  TextEditingController invCont = TextEditingController();
  List<List<String>> listSup = [];

  List<String> invIds = [];
  bool isCredit = false;
  bool isOne = false;
  bool isTranfEns = false;
  bool isInterState = false;
  bool isBranchTransIn = false;
  String dropdown3value = '';
  List<String> listSupNames = [];

  TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate;

  bool isOk = false;
  final _formKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setList();
  }

  setList() async {
    listSup = await getPreloadCustomerDB('supplier');
    brands = await getSingleFromDB('brand');
    invIds = await getSingleFromDB('stocks', col: 'invNo');
    categories = await getSingleFromDB('category');
    for (var element in listSup) {
      listSupNames.add(element[0]);
    }
    dropdown3value = listSupNames[0];
    setState(() {
      listSup = listSup;
    });
  }

  setStock(String inv) async {
    stockList.value = await getStocksDB(inv);
    setState(() {
      stockList = stockList;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text =
            '${picked.day} - ${picked.month} - ${picked.year}'; // Format the date as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              stockList.value = [];
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text('New Purchase'),
        actions: [
          isOne
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrintInvoice(),
                            ));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber)),
                      child: const Text(
                        'Print invoice',
                        style: TextStyle(color: Colors.black),
                      )),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () {
                  _showInputDialog(context, 'Brand');
                },
                child: const Text(
                  'Add Brand',
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () {
                  _showInputDialog(context, 'Category');
                },
                child: const Text(
                  'Add Category',
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddItemPage(),
                      ));
                },
                child: const Text(
                  'Add Item',
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: bgcol,
        ),
        child: ListView(
          children: [
            Form(
              key: _formKey1,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .025,
                            vertical: size.height * .05),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * .2,
                                    child: TextFormField(
                                      controller: invCont,
                                      validator: (value) {
                                        if (value == '') {
                                          return 'Enter Purch.Inv number';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Purch.Inv Number',
                                        prefixIcon: const Icon(Icons.person),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        surfaceTintColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.black)),
                                    onPressed: () {
                                      if (_formKey1.currentState!.validate()) {
                                        if (invIds.contains(invCont.text)) {
                                          showDone(
                                              context,
                                              'Invoice number already exist',
                                              Icons.error,
                                              Colors.red);
                                        } else {
                                          setState(() {
                                            isOk = true;
                                          });
                                        }
                                      }
                                    },
                                    child: const Text('Open')),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .025,
                            vertical: size.height * .05),
                        child: Row(
                          children: [
                            const Text(
                              'Select Supplier :',
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .025,
                                  vertical: size.height * .05),
                              child: DropdownButton(
                                onTap: () {},
                                // Initial Value
                                borderRadius: BorderRadius.circular(20),
                                value: dropdown3value,
                                // dropdownColor: Colors.black,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: listSupNames.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Center(child: Text(items)),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdown3value = newValue!;
                                  });
                                  if (isOne == false) {
                                    print('first stock');
                                    showDialog(
                                      context: context,
                                      builder: (context) => FluidDialog(
                                        rootPage: FluidDialogPage(
                                          alignment: Alignment.center,
                                          builder: (context) => TestDialog(
                                            param1: [
                                              invCont.text,
                                              _dateController.text,
                                              isCredit.toString(),
                                              isTranfEns.toString(),
                                              isInterState.toString(),
                                              isBranchTransIn.toString(),
                                              dropdown3value
                                            ],
                                          ),
                                        ),
                                      ),
                                    );

                                    setState(() {
                                      isOne = true;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      isOne
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .025,
                                  vertical: size.height * .05),
                              child: ElevatedButton.icon(
                                  label: Text('Add extra stock'),
                                  onPressed: () {
                                    // setState(() {
                                    //   setStock(invCont.text);
                                    // });
                                    print(stockList);

                                    showDialog(
                                      context: context,
                                      builder: (context) => FluidDialog(
                                        rootPage: FluidDialogPage(
                                          alignment: Alignment.center,
                                          builder: (context) => TestDialog(
                                            param1: [
                                              invCont.text,
                                              _dateController.text,
                                              isCredit.toString(),
                                              isTranfEns.toString(),
                                              isInterState.toString(),
                                              isBranchTransIn.toString(),
                                              dropdown3value
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.add)),
                            )
                          : SizedBox()
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      isOk
                          ? SizedBox(
                              width: size.width * .14,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * .12,
                                    child: GestureDetector(
                                      onTap: () => _selectDate(context),
                                      child: AbsorbPointer(
                                        child: TextField(
                                          controller: _dateController,
                                          decoration: const InputDecoration(
                                            labelText: 'Invoice Date',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isCredit,
                                        onChanged: (value) {
                                          setState(() {
                                            isCredit = value!;
                                          });
                                        },
                                      ),
                                      const Text('Credit'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isTranfEns,
                                        onChanged: (value) {
                                          setState(() {
                                            isTranfEns = value!;
                                          });
                                        },
                                      ),
                                      const Text('Tranf to Enstimate'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isInterState,
                                        onChanged: (value) {
                                          setState(() {
                                            isInterState = value!;
                                          });
                                        },
                                      ),
                                      const Text('Inter State'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isBranchTransIn,
                                        onChanged: (value) {
                                          setState(() {
                                            isBranchTransIn = value!;
                                          });
                                        },
                                      ),
                                      const Text('Branch Trans In'),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  )
                ],
              ),
            ),
            isOne
                ? ValueListenableBuilder(
                    valueListenable: stockList,
                    builder: (context, value, child) => SizedBox(
                      width: size.width * .55,
                      height: size.height * .4,
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * .025, 0, size.width * .05, 0),
                            child: Table(
                              columnWidths: const {
                                0: FractionColumnWidth(0.15),
                                1: FractionColumnWidth(0.125),
                                2: FractionColumnWidth(0.125),
                                3: FractionColumnWidth(0.15),
                                4: FractionColumnWidth(0.05),
                                5: FractionColumnWidth(0.10),
                                6: FractionColumnWidth(0.05),
                                7: FractionColumnWidth(0.05),
                                8: FractionColumnWidth(0.10),
                              },
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.circular(7.5)),
                              children: loadData(stockList),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> _showInputDialog(BuildContext context, String name) async {
    TextEditingController textEditingController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a $name'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: "Enter $name name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (name == 'Brand'
                    ? brands.contains(textEditingController.text)
                    : categories.contains(textEditingController.text)) {
                  showDone(context, '$name already exist', Icons.error,
                      Colors.green);
                } else {
                  name == 'Brand'
                      ? brands.add(textEditingController.text)
                      : categories.add(textEditingController.text);
                  storeSingleDB(textEditingController.text,
                      name == 'Brand' ? 'brand' : 'category');
                  showDone(context, '$name Added', Icons.done, Colors.red);
                }
                // showDone(context, 'Brand Added', Icons.done, Colors.green);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<TableRow> loadData(
    ValueNotifier<List<List<String>>> list,
  ) {
    var k = [
      loadRow([
        'Product ID',
        'Price',
        'Qty',
        'discount',
        'cess',
        'credit',
        'transfEst',
        'interState',
        'branchTransIn',
      ], isHeader: true)
    ];
    for (var element in list.value) {
      k.add(loadRow([
        element[0],
        element[1],
        element[2],
        element[3],
        element[4],
        element[5] == '1' ? 'true' : 'false',
        element[6] == '1' ? 'true' : 'false',
        element[7] == '1' ? 'true' : 'false',
        element[8] == '1' ? 'true' : 'false'
      ]));

      print(element);
    }

    return k;
  }

  // TableRow loadRow(List<String> list, {bool isHeader = false}) {
  //   final myStyle = TextStyle(
  //     fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
  //     fontSize: isHeader ? 20 : 18,
  //   );

  //   return TableRow(
  //     children: [
  //       GestureDetector(
  //         onTap: () {
  // if (_dateController.text == '') {
  //   showDone(context, 'Choose invoice date', Icons.error, Colors.red);
  // } else if (invCont.text == '') {
  //   showDone(
  //       context, 'Enter invoice number', Icons.error, Colors.red);
  // } else {
  //   showDialog(
  //     context: context,
  //     builder: (context) => FluidDialog(
  //       rootPage: FluidDialogPage(
  //         alignment: Alignment.center,
  //         builder: (context) => TestDialog(
  //           param1: [
  //             invCont.text,
  //             _dateController.text,
  //             isCredit.toString(),
  //             isTranfEns.toString(),
  //             isInterState.toString(),
  //             isBranchTransIn.toString(),
  //             list[0]
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  //   invCont.text = '';
  // }
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: isHeader
  //               ? Center(child: Text(list[0], style: myStyle))
  //               : Text(list[0],
  //                   style: const TextStyle(
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: 22,
  //                       color: col10)),
  //         ),
  //       ),
  //       // Repeat for other cells in the row
  //       for (int i = 1; i < list.length; i++)
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: isHeader
  //               ? Center(child: Text(list[i], style: myStyle))
  //               : Text(list[i], style: myStyle),
  //         ),
  //     ],
  //   );
  // }
  TableRow loadRow(List<String> list, {bool isHeader = false}) {
    final myStyle = TextStyle(
      fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
      fontSize: isHeader ? 16 : 14,
    );

    return TableRow(
      children: [
        GestureDetector(
          onTap: () {
            print('hi');
            if (_dateController.text == '') {
              showDone(context, 'Choose invoice date', Icons.error, Colors.red);
            } else if (invCont.text == '') {
              showDone(
                  context, 'Enter invoice number', Icons.error, Colors.red);
            } else {
              showDialog(
                context: context,
                builder: (context) => FluidDialog(
                  rootPage: FluidDialogPage(
                    alignment: Alignment.center,
                    builder: (context) => TestDialog(
                      param1: [
                        invCont.text,
                        _dateController.text,
                        isCredit.toString(),
                        isTranfEns.toString(),
                        isInterState.toString(),
                        isBranchTransIn.toString(),
                        list[0]
                      ],
                    ),
                  ),
                ),
              );
              invCont.text = '';
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isHeader
                ? Center(child: Text(list[0], style: myStyle))
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
}
