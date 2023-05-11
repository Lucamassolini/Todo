// ignore: file_names
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:todo/Model/ToDo.dart';
import 'package:todo/Screens/AddNote.dart';
import '../Model/List.dart';
import '../Widgets/Cards.dart';
import '../Widgets/NoteCard.dart';
import 'AddToDo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<ToDo> todoList = [];
  List<ToDo> carte = [];
  bool longPressFlag = false;
  List<int> indexList = [];
  List<int> indexListNote = [];
  bool type = true;
  var currentBackPressTime;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Tab Changed tapping on new tab
        onTabTap();
      } else if (_tabController.index != _tabController.previousIndex) {
        // Tab Changed swiping to a new tab
        onTabTap();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: GestureDetector(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffe3f6f5),
              title: TabBar(
                indicatorColor: const Color(0xFF272343),
                controller: _tabController,
                //onTap: () => DefaultTabController.of(context).animateTo(1),
                tabs: const [
                  Tab(
                      icon: Icon(
                    Icons.today_outlined,
                    color: Color(0xFF272343),
                  )),
                  Tab(
                      icon: Icon(Icons.note_add_outlined,
                          color: Color(0xFF272343))),
                ],
              ),
            ),
            body: WillPopScope(
                onWillPop: onWillPop,
                child: TabBarView(controller: _tabController, children: [
                  SafeArea(
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
                              )
                      ],
                    ),
                  ),
                  SafeArea(
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
                                        if (indexListNote.contains(index)) {
                                          indexListNote.remove(index);
                                        } else {
                                          indexListNote.add(index);
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
                      ],
                    ),
                  )
                ])),
            floatingActionButton: FloatingActionButton(
              //Floating action button on Scaffold
              onPressed: () {
                if (!longPressFlag) {
                  if (type) {
                    Route route = MaterialPageRoute(
                        builder: (context) => const AddToDo());
                    Navigator.push(context, route);
                  } else {
                    Route route = MaterialPageRoute(
                        builder: (context) => const AddNote());
                    Navigator.push(context, route);
                  }
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
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }

  void longPress() {
    //notificationDefaultSound();
    //widget.callback();
    setState(() {
      if (indexList.isEmpty) {
        longPressFlag = false;
      } else {
        longPressFlag = true;
      }
    });
  }

  void longPressNote() {
    //notificationDefaultSound();
    //widget.callback();
    setState(() {
      if (indexListNote.isEmpty) {
        longPressFlag = false;
      } else {
        longPressFlag = true;
      }
    });
  }

  void redrawList() {
    setState(() {});
  }

  void onTabTap() {
    if (_tabController.index == 0) {
      type = true;
    } else {
      type = false;
    }
  }
}
