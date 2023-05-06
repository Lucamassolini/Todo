import 'package:flutter/material.dart';
import 'package:todo/Widgets/SingleChip.dart';

class Choice extends StatefulWidget {
  Choice({
    Key? key,
    required this.callback,
    required this.lista,
    required this.isSelected,
    required this.onPressed,
    required this.value,
  }) : super(key: key);

  static String getName() {
    return name;
  }

  static String name = "";
  final List<IconData> lista;
  final int value;
  final ValueSetter<String> callback;

  final bool isSelected;
  final void Function(int index) onPressed;
  final List<SingleChip> pippo = [
    SingleChip(icon: "contents/images/icons8-book-96.png", name: 'school'),
    SingleChip(icon: "contents/images/icons8-business-96.png", name: 'work'),
    SingleChip(icon: "contents/images/icons8-dumbbell-96.png", name: 'gym')
  ];
  final List<SingleChip> selectedPippi = [];

  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  Color color = Colors.black;
  Color color2 = Colors.red;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: widget.key,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: widget.pippo.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              widget.selectedPippi.clear();
              widget.selectedPippi.add(widget.pippo[index]);
              Choice.name = widget.pippo[index].name;

              setState(() {
                for (int p = 0; p < widget.pippo.length; p++) {
                  if (widget.selectedPippi.contains(widget.pippo[p])) {
                    widget.pippo[p].selected = false;
                  } else {
                    widget.pippo[p].selected = true;
                  }
                }
                widget.callback(widget.pippo[index].name);
              });

              //_multiSelectKey.currentState.validate();
            },
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                    width: 100,
                    height: 200,
                    //clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.circular(360),
                      border: Border.all(
                          color: widget.pippo[index].selected == true
                              ? Colors.black
                              : const Color(0xFFffd803),
                          width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(widget.pippo[index].icon),
                      ),
                    )
                    //child: Icon(item.value.icon),
                    )));
      },
    );
  }
}
