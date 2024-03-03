import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:coolmate/database/firestore_db.dart';
import 'package:coolmate/database/mysql_db.dart';
import 'package:coolmate/pages/dashboard_page.dart';
import 'package:coolmate/pages/preload/preloaad_main.dart';

// import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:coolmate/colors.dart';
import 'package:coolmate/pages/input_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    updateFirebaseUsers();
    updateMysqlUsers();
    // initialization();
  }

  // void initialization() async {
  //   FlutterNativeSplash.remove();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Text('hi'),
      // body: buldPages(),
      body: Container(
        decoration: BoxDecoration(
          gradient: bgcol,
        ),
        child: DefaultTabController(
          length: 5,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      // width: size.width * .6,
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.ac_unit_rounded,
                            color: col10,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Coolmate',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: col10,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ButtonsTabBar(
                      backgroundColor: Colors.red,
                      unselectedBackgroundColor: Colors.grey[300],
                      unselectedLabelStyle:
                          const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      tabs: const [
                        Tab(
                          icon: const Icon(Icons.home_outlined),
                          text: 'Home',
                        ),
                        Tab(
                          icon: const Icon(Icons.save),
                          text: 'Preload',
                        ),
                        Tab(
                          icon: const Icon(Icons.search),
                          text: 'Search',
                        ),
                        Tab(
                          icon: const Icon(Icons.highlight),
                          text: 'Highlights',
                        ),
                        Tab(
                          icon: const Icon(Icons.person_2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    const Dashboard(),
                    PreloadPage(),
                    const Center(
                      child: Icon(Icons.directions_bike),
                    ),
                    const Pages(),
                    const Center(
                      child: Icon(Icons.directions_transit),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => InputPage()));
                },
                child: const Text('Login Page')),
            ElevatedButton(
                onPressed: () async {
                  getItems();
                },
                child: const Text('Page 1')),
            ElevatedButton(
                onPressed: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => FluidDialog(
                  //     rootPage: FluidDialogPage(
                  //       alignment: Alignment.center,
                  //       builder: (context) => const TestDialog(),
                  //     ),
                  //   ),
                  // );
                },
                child: const Text('Page 2')),
          ],
        ),
      ],
    );
  }
}
