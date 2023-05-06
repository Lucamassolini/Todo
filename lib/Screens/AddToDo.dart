import 'package:flutter/material.dart';
import 'package:todo/Model/Notification_service.dart';
import 'package:todo/Screens/MyHomePage.dart';
import 'package:todo/Model/ToDo.dart';
import 'package:todo/Widgets/Choice.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);

  @override
  AddToDoFormState createState() {
    return AddToDoFormState();
  }
}

class AddToDoFormState extends State<AddToDo> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  late int value;
  late int selectedIndex;
  late ToDo task;
  late Box<ToDo> boxx;
  late String cat;
  late String more;
  late String tre;
  //DateTime selectedDate = DateTime.now();
  late String date;
  late int colore;
  DateFormat format = DateFormat("dd/MM/yyyy kk:mm:ss");

  late String _hour, _minute, _time;
  late String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
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
  void initState() {
    boxx = Hive.box<ToDo>('todos');
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = DateFormat('kk:mm:a').format(DateTime.now());
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = '$_hour:$_minute';
        _timeController.text = _time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 100.0,
                            child: Choice(
                              callback: (cat) {
                                more = cat;
                              },
                              lista: lista,
                              isSelected: false,
                              onPressed: (int index) {},
                              value: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                  ],
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
                  controller: myController,
                  decoration: const InputDecoration(
                    labelText: 'ToDo',
                    hintText: 'ToDo',
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
                Wrap(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.center,
                      height: 30,
                      child: _buildChips(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (String? val) {},
                      decoration: const InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    //width: _width / 1.7,
                    //height: _height / 9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (String? val) {},
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: const InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          boxx.put(
                              myController.text,
                              ToDo(
                                text: myController.text,
                                secondaryText: myController2.text,
                                categoria: more,
                                priority: _selectedIndex,
                                createion: DateTime.now(),
                                finish: DateTime(
                                    selectedDate.year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    selectedTime.hour,
                                    selectedTime.minute),
                              ));

                          alert = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute);

                          durationAlert = Duration(
                              minutes:
                                  alert.difference(DateTime.now()).inMinutes -
                                      10);
                          NotificationService().bho(myController.text,
                              myController2.text, durationAlert, alert);

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
    );
  }

  void calcTime() {}

  static int _selectedIndex = 0;
  List<String> nomi = ['Bassa', 'Media', 'Alta'];

  Widget _buildChips() {
    List<Widget> chips = [];
    for (int i = 0; i < nomi.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(
          nomi[i],
          style: const TextStyle(color: Colors.black),
        ),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
        },
      );
      chips.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: choiceChip,
      ));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }
}
