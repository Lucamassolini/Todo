import 'package:flutter/material.dart';

class ChipComplex extends StatefulWidget {
  _ChipComplexState createState() => new _ChipComplexState();
}

class _ChipComplexState extends State<ChipComplex>
    with TickerProviderStateMixin {
  late int _selectedIndex;
  List<String> nomi = ['Bassa', 'Media', 'Alta'];

  Widget _buildImage() {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
            width: 100,
            height: 100,
            //clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'https://picsum.photos/seed/126/600',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  //color: widget.pippo[index].color,
                ),
              ),
            )
            //child: Icon(item.value.icon),
            ));
  }

  Widget _buildChips() {
    List<Widget> chips = [];
    for (int i = 0; i < nomi.length; i++) {
      ChoiceChip choiceChip = new ChoiceChip(
        selected: _selectedIndex == i,
        label: _buildImage(),
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
