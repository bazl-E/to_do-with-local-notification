import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/tasks.dart';
import '../helper/time_Org.dart' as t;

class UpComing extends StatelessWidget {
  const UpComing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final upComingTask = Provider.of<Tasks>(context);

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Colors.indigo.shade300.withOpacity(.8),
            Colors.indigo.shade400.withOpacity(.6),
            Colors.blue.shade500.withOpacity(.4),
          ],
        ),
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // FittedBox(
              //   child:
              Flexible(
                flex: 6,
                child: StreamBuilder(
                  stream: Stream.periodic(
                      Duration(seconds: 10), (_) => DateTime.now()).take(10),
                  builder: (ctx, snap) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: upComingTask.upcoming.isEmpty ? 0 : 1,
                            duration: Duration(milliseconds: 1000),
                            child: Text(
                              'UpComing Task',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: upComingTask.upcoming.isEmpty ? 1 : 0,
                            duration: Duration(milliseconds: 1000),
                            child: Text(
                              'Time to re-shedule your tasks',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      if (upComingTask.upcoming.isEmpty)
                        Text(
                          'Add more tasks !',
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      if (upComingTask.upcoming.isNotEmpty)
                        Text(
                          Provider.of<Tasks>(context).upcoming[0].title!,
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      SizedBox(
                        height: 6,
                      ),
                      if (upComingTask.upcoming.isNotEmpty)
                        Text(
                          '${DateFormat.yMMMd().format(upComingTask.taks[0].date!)},${t.formatedTime(upComingTask.taks[0].time!)}',
                          style: TextStyle(
                            fontSize: 12,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                    ],
                  ),
                ),
              ),
              // ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(right: 14),
                  child: Image(
                    image: AssetImage('assets/images/clipart185824.png'),
                    fit: BoxFit.scaleDown,
                    color: Colors.yellow.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
