import 'package:coolmate/colors.dart';
import 'package:coolmate/const.dart';
import 'package:coolmate/database/mysql_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  String noCont = '';
  String pname = '';
  String gst = '';
  String mrp = '';
  String rprice = '';

  List<List<String>> listItems = [];

  final _formKey = GlobalKey<FormState>();
  String dropdown1value = brands[0];
  String dropdown2value = categories[0];
  String dropdown3value = units[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setList();
  }

  setList() async {
    listItems = await getPreloadCustomerDB('items');
    setState(() {
      listItems = listItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        actions: [
          Text(
            'ITEM LIST (GST)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            width: size.width * .3,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(
              width: size.width * .4,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Select Brand :'),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: DropdownButton(
                            // Initial Value
                            borderRadius: BorderRadius.circular(20),
                            value: dropdown1value,
                            // dropdownColor: Colors.black,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: brands.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Center(child: Text(items)),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdown1value = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Select Category :'),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: DropdownButton(
                            // Initial Value
                            borderRadius: BorderRadius.circular(20),
                            value: dropdown2value,
                            // dropdownColor: Colors.black,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: categories.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Center(child: Text(items)),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdown2value = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Select Unit :'),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: DropdownButton(
                            // Initial Value
                            borderRadius: BorderRadius.circular(20),
                            value: dropdown3value,
                            // dropdownColor: Colors.black,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: units.map((String items) {
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
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * .2,
                          child: TextFormField(
                            // controller: nameCont,
                            validator: (value) {
                              if (value == '') {
                                return 'Enter Product name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              pname = value ?? '';
                            },
                            decoration: InputDecoration(
                              labelText: 'Product name',
                              prefixIcon: const Icon(Icons.ac_unit),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: size.width * .15,
                          child: TextFormField(
                            onSaved: (value) {
                              gst = value ?? '';
                            },
                            validator: (value) {
                              if (value == '') {
                                return 'Enter GST';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'GST',
                              prefixIcon: const Icon(Icons.percent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * .2,
                          child: TextFormField(
                            onSaved: (value) {
                              rprice = value ?? '';
                            },
                            validator: (value) {
                              if (value == '') {
                                return 'Enter retail price';
                              } else if (value != null &&
                                  int.parse(value) < 0) {
                                return 'Wrong Price';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Retail Price',
                              prefixIcon: const Icon(Icons.price_check),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: size.width * .15,
                          child: TextFormField(
                            // controller: nameCont,
                            validator: (value) {
                              if (value == '') {
                                return 'Enter MRP';
                              } else if (value != null &&
                                  int.parse(value) < 0) {
                                return 'Wrong Price';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              mrp = value ?? '';
                            },
                            decoration: InputDecoration(
                              labelText: 'MRP',
                              prefixIcon: const Icon(Icons.price_change),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * .05, vertical: 30),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              // storeItemDB(dropdown1value, dropdown2value,
                              //     dropdown3value, pname, gst, rprice, mrp, '0');
                              setState(() {
                                listItems.add([
                                  (int.parse(listItems.last[0]) + 1).toString(),
                                  dropdown1value,
                                  dropdown2value,
                                  pname,
                                  gst,
                                  rprice,
                                  mrp,
                                  '0',
                                  dropdown3value
                                ]);
                              });
                            }
                          },
                          child: const Text('Save')),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width * .5,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.075),
                        1: FractionColumnWidth(0.125),
                        2: FractionColumnWidth(0.125),
                        3: FractionColumnWidth(0.15),
                        4: FractionColumnWidth(0.1),
                        5: FractionColumnWidth(0.1),
                        6: FractionColumnWidth(0.1),
                        7: FractionColumnWidth(0.1),
                        8: FractionColumnWidth(0.1),
                      },
                      border: TableBorder.all(
                          borderRadius: BorderRadius.circular(7.5)),
                      children: loadData(listItems),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<TableRow> loadData(
    List<List<String>> list,
  ) {
    var k = [
      loadRow([
        'ID',
        'Brand',
        'Category',
        'Name',
        'GST',
        'Retail price',
        'MRP',
        'GST',
        'Unit',
      ], isHeader: true)
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
          onTap: () {},
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
