import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController userCont = TextEditingController();

  TextEditingController pasCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Enter Bill details')),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.deepPurple,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          width: size.width * .9,
          height: size.height * .8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Register a New Account',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 48,
                ),

                // User's name
                TextFormField(
                  controller: nameCont,
                  decoration: InputDecoration(
                    hintText: 'Your name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                // Username
                TextFormField(
                  controller: userCont,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: const Icon(Icons.alternate_email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
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
                  height: 48,
                ),

                // Register
                SizedBox(
                  height: size.height * .075,
                  width: size.width * .2,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      print(nameCont.text);
                      print(userCont.text);
                      print(pasCont.text);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const LoginScreen()));
                    },
                    child: const Text('REGISTER'),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),

                // Back to login
                SizedBox(
                  height: size.height * .075,
                  width: size.width * .1,
                  child: TextButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Back to Home'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
