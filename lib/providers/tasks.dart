import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'task_model.dart';

class Tasks with ChangeNotifier {
  final List<TaskModel> _tasks = [];
  List<TaskModel> get taks {
    return [..._tasks];
  }

  void addTask(String title, String filed, DateTime date, TimeOfDay time,
      DateTime compareDate) {
    _tasks.add(
      TaskModel(
        id: DateTime.now().toString(),
        title: title,
        date: date,
        time: time,
        field: filed,
        comparedate: compareDate,
      ),
    );
    // _tasks.sort((a, b) => a.comparedate.microsecondsSinceEpoch!.compareTo(b.comparedate!));
    _tasks.sort((a, b) => a.comparedate!.microsecondsSinceEpoch
        .compareTo(b.comparedate!.microsecondsSinceEpoch));
    // _tasks.sort((a, b) => a.date!.compareTo(b.date!));

    // _tasks.sort((a, b) => a.time!.hour.compareTo(b.time!.hour));
    // _tasks.sort((a, b) => a.time!.minute.compareTo(b.time!.minute));

    notifyListeners();
  }

  int get lenghofTodaysTask {
    return todaysTaks
        .where((element) => element.isFinished != true)
        .toList()
        .length;
  }

  List<TaskModel> get todaysTaks {
    return _tasks.where((element) {
      if (element.date!.day == DateTime.now().day &&
          element.date!.month == DateTime.now().month &&
          element.date!.year == DateTime.now().year) {
        return true;
      }
      return false;
    }).toList();
  }

  List<TaskModel> get tomorowsTaks {
    final now = DateTime.now();
    return _tasks.where((element) {
      if (element.date == DateTime(now.year, now.month, now.day + 1)) {
        return true;
      }
      return false;
    }).toList();
  }

  List<TaskModel> get thisWeek {
    final now = DateTime.now();
    return _tasks.where((element) {
      if (element.date!.isAfter(DateTime(now.year, now.month, now.day + 1)) &&
          element.date!.isBefore(
            DateTime(now.year, now.month, now.day + 7),
          )) {
        return true;
      }
      return false;
    }).toList();
  }

  List<TaskModel> get otherDay {
    final now = DateTime.now();
    return _tasks.where((element) {
      if (element.date!.isAfter(DateTime(now.year, now.month, now.day + 6))) {
        return true;
      }
      return false;
    }).toList();
  }

  void setCompletion(String id) {
    final item = _tasks.firstWhere((element) => element.id == id);
    item.isFinished = !item.isFinished;
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  // void runme() {
  //   final current = DateTime.now();

  //   Stream timer = Stream.periodic(Duration(seconds: 1), (i) {
  //     current.add(Duration(seconds: i));
  //   });

  //   timer.listen((event) {
  //     upcoming;
  //   });
  // }

  List<TaskModel> get upcoming {
    final current = DateTime.now();
    return _tasks.where((element) {
      if (element.comparedate!.isBefore(DateTime.now()) &&
              // element.isFinished != true &&
              element.date!.isBefore(DateTime.now()) &&
              element.time!.hour >= current.hour
          // &&
          // element.time!.minute >= current.minute
          ) {
        return true;
      }
      return false;
    }).toList();
  }
}
