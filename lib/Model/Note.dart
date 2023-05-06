import 'package:hive/hive.dart';

part 'Note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String secondaryText;
  @HiveField(1)
  String text;

  Note({
    required this.text,
    required this.secondaryText,
  });
}
