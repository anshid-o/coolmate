// import 'package:coolmate/database/db_services.dart';
// import 'package:coolmate/const.dart';
// import 'package:coolmate/database/db.dart';
import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController userCont = TextEditingController();
  String bCategory = 'View by category';
  TextEditingController pasCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // getAllPerson();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Enter Bill details')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                width: size.width * .6,
                height: size.height * .5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User's name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * .3,
                            child: TextFormField(
                              controller: nameCont,
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
                            height: size.height * .075,
                            width: size.width * .1,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('List'),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .075,
                            width: size.width * .1,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('Add new'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      // Username
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * .175,
                            child: TextFormField(
                              controller: userCont,
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
                              controller: userCont,
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
                              controller: userCont,
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
                              controller: userCont,
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
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 203, 174, 253)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton(
                                focusColor:
                                    const Color.fromARGB(255, 73, 73, 73),
                                items: <String>[
                                  'View by category',
                                  'Category 1',
                                  'Category 2',
                                  'Category 3',
                                  'Category 4'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    bCategory = newValue!;
                                  });
                                },
                                value: bCategory,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * .14,
                            child: TextFormField(
                              controller: userCont,
                              decoration: InputDecoration(
                                hintText: 'Item ID',
                                prefixIcon: const Icon(Icons.numbers),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .075,
                            width: size.width * .1,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('Clear'),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      // Password
                      TextFormField(
                        controller: pasCont,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.key),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Register
                      // SizedBox(
                      //   height: size.height * .075,
                      //   width: size.width * .4,
                      //   child: FilledButton(
                      //     style: FilledButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8.0),
                      //       ),
                      //     ),
                      //     onPressed: () {
                      //       // registerDB(
                      //       //     nameCont.text, userCont.text, pasCont.text);
                      //       Navigator.of(context).pop();
                      //       showDone(
                      //           context,
                      //           'Your account created successfully',
                      //           Icons.done,
                      //           Colors.green);
                      //       // Navigator.of(context).push(MaterialPageRoute(
                      //       //     builder: (context) => const LoginScreen()));
                      //     },
                      //     child: const Text('REGISTER'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width * .005,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                width: size.width * .3,
                height: size.height * .5,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: size.width * .7,
                height: size.height * .4,
                child: Column(
                  children: [
                    const Text(
                      'Invoice',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        textDirection: TextDirection.ltr,
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.bottom,
                        border:
                            TableBorder.all(width: 2.0, color: Colors.black),
                        children: const [
                          TableRow(
                            children: [
                              Text(
                                "SINo",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Item ID",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Item name",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Quantity",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Unit",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Rate/Unit",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "",
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * .005,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                width: size.width * .2,
                height: size.height * .4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * .075,
                            height: size.height * .1,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blueAccent)),
                            child: Center(
                              child: Text(
                                'Recall GST B2C',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: (size.height > 840) &&
                                            (size.width > 1500)
                                        ? 25
                                        : 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * .075,
                            height: size.height * .1,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blueAccent)),
                            child: Center(
                              child: Text(
                                'Recall GST B2C',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: (size.height > 840) &&
                                            (size.width > 1500)
                                        ? 25
                                        : 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * .075,
                            height: size.height * .1,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blueAccent)),
                            child: Center(
                              child: Text(
                                'Recall GST B2C',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: (size.height > 840) &&
                                            (size.width > 1500)
                                        ? 25
                                        : 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * .075,
                            height: size.height * .1,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blueAccent)),
                            child: Center(
                              child: Text(
                                'Recall GST B2C',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: (size.height > 840) &&
                                            (size.width > 1500)
                                        ? 25
                                        : 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
