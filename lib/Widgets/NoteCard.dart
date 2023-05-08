import 'package:flutter/material.dart';
import 'package:todo/Screens/NoteExpanded.dart';
import '../Model/Note.dart';

class NoteCard extends StatefulWidget {
  final bool longPressEnabled;
  final VoidCallback callback;
  final VoidCallback deleting;
  final int index;
  final Note note;

  const NoteCard(
      {Key? key,
      required this.note,
      required this.index,
      required this.longPressEnabled,
      required this.callback,
      required this.deleting})
      : super(key: key);

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard>
    with AutomaticKeepAliveClientMixin {
  late Color pippo;
  bool selected = false;
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
        onLongPress: () {
          setState(() {
            selected = !selected;
          });
          widget.callback();
        },
        onTap: () {
          if (widget.longPressEnabled) {
            setState(() {
              selected = !selected;
            });
            widget.callback();
          } else {
            Route route = MaterialPageRoute(
                builder: (context) => NoteExpanded(
                      note: widget.note,
                    ));
            Navigator.push(context, route);
          }
        },
        child: Card(
            key: _key,
            color: const Color(0xFFe3f6f5),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(4.0)),
            elevation: selected ? 30 : 1,
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.note.text,
                            style: const TextStyle(
                                color: Color(0xFF272343),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.note.secondaryText,
                          style: const TextStyle(
                            color: Color(0xFF272343),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            )));
  }

  double widthT() {
    final size = _key.currentContext!.size;
    return size!.width;
  }

  RoundedRectangleBorder selColor(int prio) {
    if (prio == 0) {
      return RoundedRectangleBorder(
          side: const BorderSide(color: Colors.green, width: 2.0),
          borderRadius: BorderRadius.circular(4.0));
    } else if (prio == 1) {
      return RoundedRectangleBorder(
          side: const BorderSide(color: Colors.yellow, width: 2.0),
          borderRadius: BorderRadius.circular(4.0));
    } else {
      return RoundedRectangleBorder(
          side: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(4.0));
    }
  }

  @override
  bool get wantKeepAlive => true;
}
