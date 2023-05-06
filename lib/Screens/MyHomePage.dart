import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/Screens/NotesScreen.dart';
import 'package:todo/Widgets/Cards.dart';
import 'package:todo/Model/ToDo.dart';
import '../Model/List.dart';
import 'AddToDo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDo> todoList = [];
  //late Box<ToDo> boxx;
  List<ToDo> carte = [];
  bool longPressFlag = false;
  List<int> indexList = [];

  @override
  void initState() {
    //boxx = Hive.box<ToDo>('todos');
    super.initState();
  }

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
    setState(() {
      print('pippo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
      ),

      floatingActionButton: FloatingActionButton(
        //Floating action button on Scaffold
        onPressed: () {
          if (!longPressFlag) {
            Route route =
                MaterialPageRoute(builder: (context) => const AddToDo());
            Navigator.push(context, route);
          } else {
            setState(() {
              for (int i in indexList) {
                Lista.getLista().deleteAt(i);
              }
              indexList.clear();
              longPressFlag = false;
              //print(boxx.valuesBetween().toString());
            });
          }
          //code to execute on button press
        }, //icon inside button
        backgroundColor: const Color(0xFFffd803),
        child: !longPressFlag
            ? const Icon(
                Icons.add,
                color: Color(0xFF272343),
              )
            : const Icon(
                Icons.delete,
                color: Color(0xFF272343),
              ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floating action button position to center

      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: const Color(0xFFffd803),
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => const NotesScreen());
                Navigator.push(context, route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
