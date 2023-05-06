import 'package:flutter/material.dart';

class ChipSimple extends StatefulWidget {
  _ChipSimpleState createState() => new _ChipSimpleState();
}

class _ChipSimpleState extends State<ChipSimple> with TickerProviderStateMixin {
  static int _selectedIndex = 0;
  List<String> nomi = ['Bassa', 'Media', 'Alta'];

  Widget _buildChips() {
    List<Widget> chips = [];
    for (int i = 0; i < nomi.length; i++) {
      ChoiceChip choiceChip = new ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(
          nomi[i],
          style: TextStyle(color: Colors.black),
        ),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
        },
      );
      chips.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: choiceChip,
      ));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          child: _buildChips(),
        )
      ],
    );
  }
}
