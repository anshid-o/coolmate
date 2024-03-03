import 'package:coolmate/colors.dart';
import 'package:coolmate/database/mysql_db.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:flutter_web/material.dart';
const String projectId = 'coolmate-d347d';
// List<MaterialColor> colors = [
//   Colors.teal,
//   Colors.teal,
//   Colors.teal,
//   Colors.teal,
// ];
List<int> newTexts = [0, 1, 2, 3];
List<String> randomNumbers = ["13", "12", "124", "13", "14"];
List<IconData> icons = [
  Icons.menu,
  Icons.track_changes,
  Icons.shopping_cart,
  Icons.question_answer
];

List<String> titles = [
  "Sales Invoice",
  "Sales Return",
  "Database",
  "Coming Soon",
];

List<String> brands = [];
List<String> categories = [];
List<String> units = ['Nos', 'Kg', 'm'];

void showDone(BuildContext ctx, String name, IconData icon, Color c) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 1500),
    behavior: SnackBarBehavior.floating,
    elevation: 5,
    content: Row(
      children: [
        Text(
          name,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Icon(
          icon,
          color: c,
        ),
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  ));
}

class TestDialog extends StatefulWidget {
  const TestDialog({Key? key}) : super(key: key);

  @override
  State<TestDialog> createState() => _TestDialogState();
}

class _TestDialogState extends State<TestDialog> {
  List<List<String>> listItems = [];

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose the item',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            width: size.width * .75,
            height: size.height * .5,
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
                      5: FractionColumnWidth(0.14),
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
          ),
        ],
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: isHeader
              ? Center(child: Text(list[0], style: myStyle))
              : Center(
                  child: Text(list[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
        ),
        // Repeat for other cells in the row
        for (int i = 1; i < list.length; i++)
          GestureDetector(
            onTap: () {
              DialogNavigator.of(context).push(
                FluidDialogPage(
                  alignment: Alignment.topCenter,
                  builder: (context) => SecondDialogPage(
                    name: boxes[0],
                    i: 0,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isHeader
                  ? Center(child: Text(list[i], style: myStyle))
                  : Text(list[i], style: myStyle),
            ),
          ),
      ],
    );
  }
}

List<String> boxes = ['Quantity', 'Price', 'Discount', 'CESS %'];
List<String> boxValues = [];

class SecondDialogPage extends StatefulWidget {
  String name = '';

  int i;
  SecondDialogPage({Key? key, required this.name, required this.i})
      : super(key: key);

  @override
  State<SecondDialogPage> createState() => _SecondDialogPageState();
}

class _SecondDialogPageState extends State<SecondDialogPage> {
  final _formKey1 = GlobalKey<FormState>();

  TextEditingController _fn = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height * .4,
          width: size.width * .4,
          child: Form(
            key: _formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter ${boxes[widget.i]}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * .2,
                      child: TextFormField(
                        controller: _fn,
                        // controller: nameCont,
                        validator: (value) {
                          if (value == '') {
                            return 'Enter ${boxes[widget.i]}';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _fn.text = value ?? '';
                        },
                        decoration: InputDecoration(
                          labelText: '${boxes[widget.i]}',
                          prefixIcon: const Icon(Icons.numbers),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(col10),
                            surfaceTintColor:
                                MaterialStateProperty.all(Colors.black),
                            shadowColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          if (_formKey1.currentState!.validate()) {
                            boxValues.add(_fn.text);
                            if (widget.i == 3) {
                              showDone(context, 'Item Added', Icons.done,
                                  Colors.green);
                              DialogNavigator.of(context).close();
                            } else {
                              _fn.text = '';
                              DialogNavigator.of(context).push(
                                FluidDialogPage(
                                  alignment: Alignment.topCenter,
                                  builder: (context) => SecondDialogPage(
                                    name: boxes[widget.i + 1],
                                    i: widget.i + 1,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => DialogNavigator.of(context).pop(),
                  child: const Text('Go back'),
                ),
                TextButton(
                  onPressed: () => DialogNavigator.of(context).close(),
                  child: const Text('Close the dialog'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
