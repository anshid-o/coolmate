import 'package:flutter/material.dart';

const col10 = Color(0xff272e81);
const col60 = Color(0xff9496c1);
var bgcol = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.white, // White
    Color.fromARGB(255, 255, 255, 255), // Light blue
    // Color.fromARGB(255, 209, 214, 218), //ht blue
    Color.fromARGB(255, 209, 224, 238), //ht blue
    Color.fromARGB(255, 209, 224, 238), //ht blue
    Color.fromARGB(255, 182, 211, 238), // Light blue
  ],
  stops: [0.2, 0.4, 0.6, .8, 1],
);
