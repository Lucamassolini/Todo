import 'package:hive/hive.dart';

import 'Note.dart';
import 'ToDo.dart';

class Lista {
  static final Box<ToDo> _lista = Hive.box<ToDo>('todos');
  static final Box<Note> _notes = Hive.box<Note>('notes');

  static Box<ToDo> getLista() {
    return _lista;
  }

  static Box<Note> getNotes() {
    return _notes;
  }
}
