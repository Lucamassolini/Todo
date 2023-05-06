import 'package:flutter/material.dart';

class SingleChip {
  String name;
  String icon;
  Color color = Colors.black;
  bool selected = false;

  SingleChip({required this.icon, required this.name});
}
