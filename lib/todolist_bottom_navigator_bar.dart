import 'package:flutter/material.dart';
import 'package:todo_app_v1/todolist_home_page.dart';
import 'package:todo_app_v1/todolist_setting_page.dart';

class TodolistBottomNavigatorBar extends StatefulWidget {
  const TodolistBottomNavigatorBar({super.key});

  @override
  State<TodolistBottomNavigatorBar> createState() => _TodolistBottomNavigatorBarState();
}

class _TodolistBottomNavigatorBarState extends State<TodolistBottomNavigatorBar> {

  int selectedIndex = 0;

  static List<Widget> _widgetOption = <Widget>[
    TodolistHomePage(),
    TodolistSettingPage()
  ];

  void _onSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOption.elementAt(selectedIndex),
      ),

      bottomNavigationBar:BottomNavigationBar(
          backgroundColor: Colors.blueAccent,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black38,
          onTap: _onSelection,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Setting'
            )
          ]
      ),
    );
  }
}
