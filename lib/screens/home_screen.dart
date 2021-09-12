import 'package:flutter/material.dart';

import '../widgets/slivers/sliver_body.dart';
import 'tasks_screen.dart';
import '../widgets/bottom_sheet.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var _pages = [];
  @override
  void initState() {
    _pages = [
      SliverBody(inty),
      TasksScreen(),
    ];
    super.initState();
  }

  var inty = 0;
  var _pageIndex = 0;

  void chnagePage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              // isDismissible: false,
              enableDrag: true,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              context: context,
              builder: (ctx) => Bottom(),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: chnagePage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'Tasks')
          ]),
      body: _pages[_pageIndex],
    );
  }
}
