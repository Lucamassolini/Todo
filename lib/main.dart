import 'package:flutter/material.dart';
import 'package:todo/Model/Note.dart';
import 'Model/Notification_service.dart';
import 'Screens/MyHomePage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/Model/ToDo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    final appDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    Hive.init(appDocDir.path);
    Hive.registerAdapter<ToDo>(ToDoAdapter());
    await Hive.openBox<ToDo>('todos');
    Hive.registerAdapter<Note>(NoteAdapter());
    await Hive.openBox<Note>('notes');
    await NotificationService().init();
    // ignore: empty_catches, unused_local_variable
  } catch (e) {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
