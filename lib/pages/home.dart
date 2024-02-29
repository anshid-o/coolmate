import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:coolmate/database/db.dart';
import 'package:coolmate/database/firestore_db.dart';
import 'package:coolmate/pages/main_page.dart';
// import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:coolmate/colors.dart';
import 'package:coolmate/pages/login.dart';

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
    // initialization();
  }

  // void initialization() async {
  //   FlutterNativeSplash.remove();
  // }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // body: Text('hi'),
      // body: buldPages(),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: <Widget>[
            Container(
              color: col60,
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
                            color: col10,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonsTabBar(
                    backgroundColor: Colors.red,
                    unselectedBackgroundColor: Colors.grey[300],
                    unselectedLabelStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(
                        icon: const Icon(Icons.home_outlined),
                        text: 'Home',
                      ),
                      Tab(
                        icon: const Icon(Icons.event),
                        text: 'Events',
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
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  Dashboard(),
                  Center(
                    child: Icon(Icons.directions_transit),
                  ),
                  Center(
                    child: Icon(Icons.directions_bike),
                  ),
                  Pages(),
                  Center(
                    child: Icon(Icons.directions_transit),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buldPages() {
    switch (_selectedIndex) {
      case 0:
        return const Dashboard();
      case 3:
        return const Pages();

      default:
        Center(
            child: Text(
          '${_selectedIndex + 1}',
          style: const TextStyle(fontSize: 30, color: Colors.black),
        ));
    }
  }
}

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

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
                      MaterialPageRoute(builder: (ctx) => LoginPage()));
                },
                child: const Text('Login Page')),
            ElevatedButton(
                onPressed: () async {
                  getItems();
                },
                child: const Text('Page 1')),
            ElevatedButton(
                onPressed: () {
                  updateFirebaseUsers();
                  // collectFirebaseusers();
                },
                child: const Text('Page 2')),
          ],
        ),
      ],
    );
  }
}
