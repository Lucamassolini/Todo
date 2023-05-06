import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../Model/List.dart';
import '../Model/ToDo.dart';

class Cards extends StatefulWidget {
  final bool longPressEnabled;
  final VoidCallback callback;
  final VoidCallback deleting;
  final int index;
  final ToDo toDo;

  const Cards(
      {Key? key,
      required this.toDo,
      required this.index,
      required this.longPressEnabled,
      required this.callback,
      required this.deleting})
      : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> with AutomaticKeepAliveClientMixin {
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.grey),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade100,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: selectCat(widget.toDo.categoria)
                              //child: Icon(item.value.icon),
                              )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        widget.toDo.text,
                        style: const TextStyle(
                            color: Color(0xFF272343),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    widget.toDo.priority != 0
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              alignment: Alignment.topRight,
                              width: 50,
                              height: 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                        "contents/images/icons8-high-priority-96.png")),
                              ),
                            ),
                          ) //child: Icon(item.value.icon),
                        : const Text('')
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.toDo.secondaryText,
                          style: const TextStyle(
                            color: Color(0xFF272343),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SlideCountdown(
                        duration: tooLate(widget.toDo.finish)
                            ? Duration(
                                seconds: widget.toDo.finish
                                    .difference(DateTime.now())
                                    .inSeconds)
                            : const Duration(),
                        separator: ':',
                        textStyle: const TextStyle(
                          color: Color(0xFF272343),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        onDone: () => {},
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                      foregroundColor: const Color(0xFF272343),
                      radius: 20,
                      backgroundColor: const Color(0xFFFFD803),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            Lista.getLista().delete(widget.toDo.text);
                            widget.deleting();
                          });
                        },
                        icon: selected
                            ? const Icon(Icons.delete)
                            : const Icon(Icons.done),
                        color: const Color(0xFF272343),
                      )),
                ),
              ]),
            )));
  }

  double widthT() {
    final size = _key.currentContext!.size;
    return size!.width;
  }

  static Widget selectCat(String cat) {
    if (cat == "work") {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset("contents/images/icons8-business-96.png")),
      );
    } else if (cat == "school") {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset("contents/images/icons8-book-96.png")),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset("contents/images/icons8-dumbbell-96.png")),
      );
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM kk:mm').format(date);
  }

  String calcTime(DateTime fine) {
    int minuti = fine.difference(DateTime.now()).inMinutes;
    int ore = fine.difference(DateTime.now()).inHours;
    int real = minuti - (ore * 60);
    return "$ore:$real";
  }

  int seconds(DateTime fine) {
    return fine.difference(DateTime.now()).inSeconds;
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

  bool tooLate(DateTime fine) {
    if (DateTime.now().isBefore(fine) ||
        DateTime.now().isAtSameMomentAs(fine)) {
      return true;
    }
    return false;
  }

  @override
  bool get wantKeepAlive => true;
}
