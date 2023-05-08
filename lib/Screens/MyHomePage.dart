// ignore: file_names
import 'package:flutter/material.dart';
import 'package:todo/Model/ToDo.dart';
import 'package:todo/Screens/AddNote.dart';
import 'package:todo/Widgets/NoteWidget.dart';
import 'package:todo/Widgets/ToDoWidget.dart';
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
  List<ToDo> carte = [];
  bool longPressFlag = false;
  List<int> indexList = [];
  bool type = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: type ? const ToDoWidget() : const NoteWidget(),

      floatingActionButton: FloatingActionButton(
        //Floating action button on Scaffold
        onPressed: () {
          if (!longPressFlag) {
            if (type) {
              Route route =
                  MaterialPageRoute(builder: (context) => const AddToDo());
              Navigator.push(context, route);
            } else {
              Route route =
                  MaterialPageRoute(builder: (context) => const AddNote());
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
              onPressed: () {
                setState(() {
                  type = true;
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  type = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
