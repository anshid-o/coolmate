import 'package:coolmate/pages/main_page.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.ac_unit_rounded,
          color: col10,
        ),
        title: const Text(
          'Coolmate',
          style: TextStyle(
            color: col10,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: col60,
      ),
      body: buldPages(),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.event),
            title: const Text('Events'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.highlight),
            title: const Text('Highlights'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person_2),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }

  buldPages() {
    switch (_selectedIndex) {
      case 0:
        return Dashboard();
      case 3:
        return Pages();

      default:
        Center(
            child: Text(
          '${_selectedIndex + 1}',
          style: const TextStyle(fontSize: 30),
        ));
    }
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
                      MaterialPageRoute(builder: (ctx) => const LoginPage()));
                },
                child: const Text('Login Page')),
            ElevatedButton(onPressed: () {}, child: const Text('Page 1')),
            ElevatedButton(onPressed: () {}, child: const Text('Page 2')),
          ],
        ),
      ],
    );
  }
}
