import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'tasks.dart';

class TaskModel {
  final String? id;
  final String? title;
  final DateTime? comparedate;
  final DateTime? date;
  final String? field;
  final TimeOfDay? time;
  bool isFinished;
  TaskModel({
    @required this.date,
    @required this.id,
    @required this.title,
    @required this.time,
    @required this.comparedate,
    this.field = 'other',
    this.isFinished = false,
  });

  // void finishedStatus() {
  //   isFinished = !isFinished;

  // }

  // TaskModel upcoming(BuildContext context) {
  //   final _tasks = Provider.of<Tasks>(context).taks;
  //   return _tasks.firstWhere(
  //     (element) => isFinished != true,
  //   );
  // }
}
