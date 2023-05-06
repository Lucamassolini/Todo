import 'package:hive/hive.dart';

part 'ToDo.g.dart';

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  DateTime createion;
  @HiveField(1)
  DateTime finish;
  @HiveField(2)
  String secondaryText;
  @HiveField(3)
  String text;
  @HiveField(4)
  String categoria;
  @HiveField(5)
  int priority;

  ToDo({
    required this.text,
    required this.secondaryText,
    required this.categoria,
    required this.priority,
    required this.createion,
    required this.finish,
  });
}
