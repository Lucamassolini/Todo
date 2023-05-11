import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';

import '../Model/List.dart';
import '../Model/ToDo.dart';
import 'Cards.dart';

class ToDoWidget extends StatefulWidget {
  final VoidCallback callback;
  const ToDoWidget({Key? key, required this.callback}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ToDoWidgetState createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  List<ToDo> todoList = [];
  //late Box<ToDo> boxx;
  List<ToDo> carte = [];
  bool longPressFlag = false;
  List<int> indexList = [];
  bool type = true;

  @override
  void initState() {
    //boxx = Hive.box<ToDo>('todos');
    super.initState();
  }

  void longPress() {
    //notificationDefaultSound();
    widget.callback();
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
            "ToDo",
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
          Lista.getLista() == null
              ? const Center(
                  child: Text('Please Add the items'),
                )
              : Expanded(
                  child: FlexibleGridView(
                    /*
                  children: [
                    
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: Lista.getLista().length,
                        itemBuilder: (context, index) {
                          final item = Lista.getLista().getAt(index);
                          return Cards(
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
                              toDo: item!);
                        }),
                  ],*/
                    children: List.generate(
                      Lista.getLista().length,
                      (index) => Cards(
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
                        toDo: Lista.getLista().getAt(index)!,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
