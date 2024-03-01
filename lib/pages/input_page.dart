import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:coolmate/database/mysql_db.dart';
import 'package:coolmate/database/firestore_db.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController em = TextEditingController();

  TextEditingController kk = TextEditingController();

  // Firestore firestore = Firestore.initialize(projectId);

  List<List<String>> list = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ConnectivityWidgetWrapper(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: em,
                        decoration: const InputDecoration(
                            hintText: 'Enter Mess ID',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: kk,
                        decoration: const InputDecoration(
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)))),
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () async {
                          setState(() {
                            list.add([em.text, kk.text]);
                          });
                          if (await ConnectivityWrapper.instance.isConnected) {
                            print('send to cloud and local');
                            setUsers(em.text, kk.text);
                            registerDB(em.text, kk.text);
                          } else {
                            print('not connected ----- send local');
                            registerDB(em.text, kk.text);
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Table(
                  columnWidths: const {
                    0: FractionColumnWidth(0.7),
                    1: FractionColumnWidth(0.3),
                  },
                  border: TableBorder.all(),
                  children: buildData(list),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<TableRow> buildData(List<List<String>> list) {
  var k = [
    buildRow(['Name', 'Password'], isHeader: true)
  ];
  list.forEach((element) {
    k.add(buildRow(element));
  });
  return k;
}

TableRow buildRow(List<String> list, {bool isHeader = false}) => TableRow(
        children: list.map((e) {
      TextStyle myStyle = TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
          fontSize: isHeader ? 20 : 18);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          e,
          style: myStyle,
        )),
      );
    }).toList());
