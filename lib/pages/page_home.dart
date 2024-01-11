import 'package:flutter/material.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (ctx) => const LoginPage()));
            },
            child: const Text('Login Page')),
        ElevatedButton(onPressed: () {}, child: const Text('Page 1')),
        ElevatedButton(onPressed: () {}, child: const Text('Page 2')),
      ],
    );
  }
}
