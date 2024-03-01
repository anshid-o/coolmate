import 'package:flutter/material.dart';

const col10 = Color(0xff272e81);
const col60 = Color(0xff9496c1);
var bgcol = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFFFFFFF), // White
    Color.fromARGB(255, 217, 221, 224), // Light blue

    Color.fromARGB(255, 211, 221, 231), // Light blue
  ],
  stops: [0.25, 0.5, 0.75],
);
