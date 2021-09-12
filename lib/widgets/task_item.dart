import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/task_model.dart';
import 'package:to_do/providers/tasks.dart';
import '../helper/time_Org.dart' as t;

class TaskItem extends StatelessWidget {
  TaskItem(this.task);
  final TaskModel task;
  final now = DateTime.now();

  // var _value = false;
  // void changevalue(newValue) {
  //   setState(() {
  //     _value = newValue;
  //   });
  // }

  Color _color(String object) {
    if (object == 'Personal') {
      return Colors.purpleAccent;
    }
    if (object == 'Work') {
      return Colors.greenAccent;
    }
    if (object == 'Meeting') {
      return Colors.pink;
    }
    if (object == 'Study') {
      return Colors.cyan;
    }
    if (object == 'Shopping') {
      return Colors.orange;
    }
    return Colors.indigoAccent;
  }

  @override
  Widget build(BuildContext context) {
    // final task = Provider.of<TaskModel>(context);
    final taskFunction = Provider.of<Tasks>(context);

    return Container(
        width: double.infinity,
        height: 63,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        // height: 80,
        child: Dismissible(
          direction: DismissDirection.endToStart,
          //just desable above line to get archive back
          //also have to add function for it
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              taskFunction.deleteTask(task.id ?? '');
              // ScaffoldMessenger.of(context).hideCurrentSnackBar();
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Task Deleted'),
              //   duration: Duration(milliseconds: 600),
              //   backgroundColor: Colors.red,
              // ));
            }
          },
          secondaryBackground: Container(
            // color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              backgroundColor: Colors.red.shade100,
              child: Icon(
                Icons.delete_forever_outlined,
                color: Colors.red,
              ),
            ),
          ),
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundColor: Colors.green.shade300,
              child: Icon(
                Icons.archive,
                color: Colors.white,
              ),
            ),
          ),
          key: ValueKey(task.id),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, 3),
                  color: Colors.black12.withOpacity(.1),
                  // spreadRadius: 2,
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _color(task.field ?? ''),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  height: 63,
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 5,
                      bottom: 5,
                    ),
                    child: Row(
                      children: [
                        // SizedBox(
                        //   width: 5,
                        // ),
                        Checkbox(
                            shape: CircleBorder(
                              side: BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            value: task.isFinished,
                            onChanged: (_) {
                              taskFunction.setCompletion(task.id!);
                            }),

                        Container(
                          width: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                t.formatedTime(task.time!),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.withOpacity(.6),
                                  fontSize: 12,
                                ),
                              ),
                              // if (
                              // // (
                              // // task.comparedate!.isBefore(DateTime.now()
                              // //     // )
                              // //     //  ||
                              //     // task.comparedate!
                              //     //     .isAtSameMomentAs(DateTime.now()
                              //     // )
                              //     // )
                              //     //          &&
                              //     // task.time!.hour <= DateTime.now().hour &&
                              //     // task.time!.minute < DateTime.now().minute
                              //     )
                              Text(
                                'Expired',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.withOpacity(.6),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            task.title ?? '',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            textWidthBasis: TextWidthBasis.longestLine,
                            softWrap: true,
                            // textScale Factor: .7,

                            // overflow: TextOverflow.fade,
                            // softWrap: true,
                            style: TextStyle(
                                inherit: true,
                                decoration: task.isFinished
                                    ? TextDecoration.lineThrough
                                    : null,
                                fontWeight: FontWeight.bold,
                                color: task.isFinished
                                    ? Colors.grey
                                    : Colors.blue.shade900,
                                fontSize: 15),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Icon(
                            Icons.notifications,
                            size: 20,
                            color: Colors.grey.withOpacity(.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
