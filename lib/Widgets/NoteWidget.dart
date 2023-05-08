import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';

import '../Model/List.dart';
import '../Model/ToDo.dart';
import 'NoteCard.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  List<ToDo> todoList = [];
  //late Box<ToDo> boxx;
  List<ToDo> carte = [];
  bool longPressFlag = false;
  List<int> indexList = [];

  void longPress() {
    //notificationDefaultSound();
    setState(() {
      if (indexList.isEmpty) {
        longPressFlag = false;
      } else {
        longPressFlag = true;
      }
    });
  }

  void redrawList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Text(
            "Notes",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50,
              color: Color(0xFF272343),
              fontFamily: 'Century',
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Color(0x002d334a),
                  blurRadius: 10.0,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
          ),
          // ignore: unnecessary_null_comparison
          Lista.getNotes() == null
              ? const Center(
                  child: Text('Please Add the items'),
                )
              : Expanded(
                  child: FlexibleGridView(
                    children: List.generate(
                      Lista.getNotes().length,
                      (index) => NoteCard(
                        index: index,
                        longPressEnabled: longPressFlag,
                        callback: () {
                          if (indexList.contains(index)) {
                            indexList.remove(index);
                          } else {
                            indexList.add(index);
                          }

                          longPress();
                        },
                        deleting: () {
                          redrawList();
                        },
                        note: Lista.getNotes().getAt(index)!,
                      ),
                    ),
                  ),
                ),

          /*
          !longPressFlag
              ? FloatingActionButton(
                  backgroundColor: const Color(0xFFffd803),
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFF272343),
                  ),
                  onPressed: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => const AddToDo());
                    Navigator.push(context, route);
                  },
                )

              
              : FloatingActionButton.extended(
                  backgroundColor: const Color(0xFFffd803),
                  icon: const Icon(Icons.delete, color: Color(0xFF272343)),
                  label: const Text(
                    "Delete all",
                    style: TextStyle(color: Color(0xFF272343)),
                  ),
                  onPressed: () {
                    setState(() {
                      for (int i in indexList) {
                        Lista.getLista().deleteAt(i);
                      }
                      indexList.clear();
                      longPressFlag = false;
                      //print(boxx.valuesBetween().toString());
                    });
                  },
                )*/
        ],
      ),
    );
  }
}
