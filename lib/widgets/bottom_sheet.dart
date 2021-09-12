import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/tasks.dart';
import '../helper/time_Org.dart' as t;

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

// final now = DateTime.now();

class _BottomState extends State<Bottom> {
  final Map colorCode = {
    'Other': Colors.indigoAccent,
    'Personal': Colors.purpleAccent,
    'Work': Colors.greenAccent,
    'Meeting': Colors.pink,
    'Study': Colors.cyan,
    'Shopping': Colors.orange,
  };

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    selectedDate = now;
  }

  var now;
  DateTime? selectedDate;

  //use to make testDate

  var selectedTime; //toshow after date has choosen
  TimeOfDay initialTime = TimeOfDay(
    hour: 23,
    minute: 59,
  ); //share to taskItem
  DateTime? testDate; //share to taskItem
  var warningColor = Colors.black;
  var _currentButton = 0;
  var field = 'Other';
  var title;
  final formKey = GlobalKey<FormState>();

  Future<void> _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final _pickDate = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(now.day, now.month, now.year),
      lastDate: DateTime(2050),
    );
    if (_pickDate == null) {
      return;
    }
    // initialDate = _pickDate;
    setState(() {
      selectedDate = DateTime(_pickDate.year, _pickDate.month, _pickDate.day);
    });
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final _pickTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_pickTime == null) {
      return;
    }

    initialTime = _pickTime;
    // testDate = DateTime(
    //   selectedDate!.day,
    //   selectedDate!.month,
    //   selectedDate!.year,
    //   _pickTime.hour,
    //   _pickTime.minute,
    // );
    setState(() {
      warningColor = Colors.black;
      selectedTime = t.formatedTime(_pickTime);
    });
    // testDate = DateTime.parse(
    //   "${selectedDate!.year}-0${selectedDate!.month}-0${selectedDate!.day} 0${_pickTime.hour}:0${_pickTime.minute}:${DateTime.now().second}",
    // );
    final fm = DateFormat('yyyy-MM-dd').format(selectedDate!);
    DateTime tempDate = DateFormat("hh:mm").parse(
        initialTime.hour.toString() + ":" + initialTime.minute.toString());
    var dateformat = DateFormat('hh:mm:ss').format(tempDate);

    testDate = DateTime.parse("$fm $dateformat");
  }

  void saveForm() {
    final isValid = formKey.currentState!.validate();
    if (selectedTime == null) {
      setState(() {
        warningColor = Colors.red;
      });
      return;
    }

    if (!isValid || selectedDate == null) {
      return;
    }

    formKey.currentState!.save();

    Provider.of<Tasks>(context, listen: false).addTask(
      title,
      field,
      selectedDate!,
      initialTime, //we cant set formated time here (as we have to show for mated date)
      testDate!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add new Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Task Title',
                  ),
                  onSaved: (value) {
                    title = value;
                  },
                  validator: (inpu) {
                    if (inpu!.isEmpty) {
                      return 'Give a tile';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var i = 0; i < colorCode.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _currentButton = i;
                                field = colorCode.keys.toList()[i];
                              });
                            },
                            splashColor: Colors.blue,
                            radius: 5,
                            child: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                color: _currentButton == i
                                    ? colorCode.values.toList()[i]
                                    : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_currentButton != i)
                                    CircleAvatar(
                                      maxRadius: 5,
                                      backgroundColor:
                                          colorCode.values.toList()[i],
                                    ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    colorCode.keys.toList()[i],
                                    style: TextStyle(
                                      color: _currentButton != i
                                          ? Colors.blueGrey
                                          : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.black),
                  onPressed: () {
                    _showDatePicker(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        selectedDate == now
                            ? 'Today'
                            : '${DateFormat.yMMMd().format(selectedDate!)}, ',
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.black),
                  onPressed: () {
                    _showTimePicker(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        selectedTime == null
                            ? 'Choose a time to get reminded'
                            : '$selectedTime',
                        style: TextStyle(color: warningColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.alarm_add,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: saveForm,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, 1],
                          colors: [
                            Colors.indigo.shade400,
                            Colors.blue.shade300,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Add Task',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
