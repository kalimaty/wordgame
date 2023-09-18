import 'package:flutter/material.dart';
import 'dart:math';

var container1;
var container2;
var container3;
var container4;
var container5;
var container6;
var container7;

randomColors() {
  container1 = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  container2 = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  container3 = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  container4 = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  container5 = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  container6 = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  container7 = Colors.primaries[Random().nextInt(Colors.primaries.length)];
}