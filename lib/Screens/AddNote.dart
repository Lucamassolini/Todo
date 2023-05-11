import 'package:flutter/material.dart';
import 'package:todo/Model/Note.dart';
import 'package:todo/Screens/MyHomePage.dart';
import 'package:todo/Model/ToDo.dart';
import 'package:intl/intl.dart';
import '../Model/List.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  AddNoteFormState createState() {
    return AddNoteFormState();
  }
}

class AddNoteFormState extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  late int value;
  late int selectedIndex;
  late ToDo task;
  late String cat;
  late String more;
  late String tre;
  //DateTime selectedDate = DateTime.now();
  late String date;
  late int colore;
  DateFormat format = DateFormat("dd/MM/yyyy kk:mm:ss");
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  List<IconData> lista = [Icons.school, Icons.work, Icons.piano];
  late DateTime alert;
  late Duration durationAlert;

  @override
  void dispose() {
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffe3f6f5),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF272343),
            ),
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => const MyHomePage());
              Navigator.push(context, route);
            },
          ),
          title: const Text(
            'Add task',
            style: TextStyle(color: Color(0xFF272343)),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text';
                      } else {
                        return null;
                      }
                    },
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    controller: myController,
                    decoration: const InputDecoration(
                      labelText: 'Note',
                      hintText: 'Note',
                      labelStyle: TextStyle(color: Color(0xFFffd803)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF272343))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFffd803))),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text';
                      } else {
                        return null;
                      }
                    },
                    controller: myController2,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Description',
                      labelStyle: TextStyle(color: Color(0xFFffd803)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF272343))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFffd803))),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Lista.getNotes().put(
                                myController.text,
                                Note(
                                  text: myController.text,
                                  secondaryText: myController2.text,
                                ));

                            Route route = MaterialPageRoute(
                                builder: (context) => const MyHomePage());
                            Navigator.push(context, route);
                          }
                        },
                        child: const Text("OK"),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
