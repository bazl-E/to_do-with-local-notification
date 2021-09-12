import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/tasks.dart';
import '../task_item.dart';
import 'sliver_app_bar.dart';

import 'package:sliver_tools/sliver_tools.dart';

class SliverBody extends StatelessWidget {
  final int pageIndex;
  SliverBody(this.pageIndex);
  final controller = ScrollController();

  Widget buidText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
            backgroundColor: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context);
    return CustomScrollView(
      controller: controller,
      slivers: [
        SAppBar(pageIndex: pageIndex),
        MultiSliver(
          pushPinnedChildren: true,
          children: [
            if (tasks.taks.isEmpty)
              Center(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Image.asset('assets/images/200w_s.gif'),
                        color: Theme.of(context).canvasColor,
                      ),
                      // Image(
                      //     image: AssetImage('assets/images/200w_s.gif'))
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Manage Your Day-to-Day: Build Your Routine, Find Your Focus, and Sharpen Your Creative Mind.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            if (tasks.todaysTaks.isNotEmpty)
              SliverPinnedHeader(
                child: buidText('Today'),
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  return TaskItem(tasks.todaysTaks[i]);
                },
                childCount: tasks.todaysTaks.length,
              ),
            ),
            if (tasks.tomorowsTaks.isNotEmpty)
              SliverPinnedHeader(
                child: buidText('Tomorrow'),
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  return TaskItem(tasks.tomorowsTaks[i]);
                },
                childCount: tasks.tomorowsTaks.length,
              ),
            ),
            if (tasks.thisWeek.isNotEmpty)
              SliverPinnedHeader(
                child: buidText('This week'),
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  return TaskItem(tasks.thisWeek[i]);
                },
                childCount: tasks.thisWeek.length,
              ),
            ),
            if (tasks.otherDay.isNotEmpty)
              SliverPinnedHeader(
                child: buidText('ToDo'),
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  return TaskItem(tasks.otherDay[i]);
                },
                childCount: tasks.otherDay.length,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
