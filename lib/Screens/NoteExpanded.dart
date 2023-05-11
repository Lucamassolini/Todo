import 'package:flutter/material.dart';

import '../Model/Note.dart';
import 'MyHomePage.dart';

class NoteExpanded extends StatelessWidget {
  final Note note;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  NoteExpanded({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    myController.text = note.text;
    myController2.text = note.secondaryText;
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
          centerTitle: true,
          title: TextFormField(
            controller: myController,
            //initialValue: note.text,
            style: const TextStyle(
                color: Color(0xFF272343),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("contents/images/note.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(47),
                  child: TextFormField(
                    controller: myController2,
                    //initialValue: note.secondaryText,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  note.text = myController.text;
                  note.secondaryText = myController2.text;
                  Route route = MaterialPageRoute(
                      builder: (context) => const MyHomePage());
                  Navigator.push(context, route);
                },
                child: const Text("ok"))
          ],
        ),
      ),
    );
  }
}
