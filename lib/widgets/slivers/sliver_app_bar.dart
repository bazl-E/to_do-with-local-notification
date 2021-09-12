import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/tasks.dart';
import '../upcoming.dart';

class SAppBar extends StatelessWidget {
  const SAppBar({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    final gtask = Provider.of<Tasks>(context);
    return SliverAppBar(
      floating: true,
      // pinned: true,
      expandedHeight: 180,
      title: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello Bernna!'),
            SizedBox(
              height: 5,
            ),
            if (gtask.todaysTaks.isEmpty)
              Text(
                'No tasks for Today',
                style: TextStyle(fontSize: 12),
              ),
            if (gtask.todaysTaks.isNotEmpty)
              Text(
                'Today you have ${gtask.lenghofTodaysTask} tasks',
                style: TextStyle(fontSize: 12),
              ),
          ],
        ),
      ),
      elevation: 3,
      actions: [
        Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 20,
                child: Text(
                  'B',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ],
        )
      ],

      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // if (gtask.taks.isEmpty)
            Center(
              child: Container(
                // duration: Duration(milliseconds: 300),
                height: gtask.taks.isEmpty ? 80 : 0,
                padding: EdgeInsets.only(top: 50),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: gtask.taks.isEmpty ? 1 : 0,
                  child: Text(
                    'Start Manging Your Day',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(50),
                          blurRadius: 20,
                        )
                      ],
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // if (gtask.taks.isNotEmpty)
            Container(
              height: gtask.taks.isEmpty ? 0 : 250,
              alignment: Alignment(0, 1),
              // height: 250,
              width: double.infinity,
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
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: AnimatedContainer(
                  duration: Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.easeInSine,
                  height: gtask.taks.isEmpty ? 0 : 100,
                  width: gtask.taks.isEmpty ? 0 : 530,
                  child: Card(
                    // alignment: Alignment.center,
                    // padding: EdgeInsets.all(50),s
                    // height: 10,
                    // width: 50,

                    child:
                        // gtask.taks.isEmpty ? null :
                        UpComing(),
                  ),
                ),
              ),
            ),
            Container(
              child: Container(
                transform: Matrix4.rotationZ(6),
                height: 200,
                width: 200,
              ),
              transform: Matrix4.rotationZ(1)..translate(-110.0, -100, 50),
              decoration: BoxDecoration(
                  color: Colors.blue.shade300.withOpacity(.4),
                  shape: BoxShape.circle),
            ),
            Container(
              child: Container(
                transform: Matrix4.rotationZ(6),
                height: 100,
                width: 100,
              ),
              transform: Matrix4.rotationZ(1)..translate(180.0, -360, 50),
              decoration: BoxDecoration(
                  color: Colors.blue.shade300.withOpacity(.6),
                  shape: BoxShape.circle),
            ),
          ],
        ),
      ),
    );
  }
}
