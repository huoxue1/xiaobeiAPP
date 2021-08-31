import 'package:flutter/material.dart';
import 'package:xiaobei/page/address_book/AddressBook.dart';
import 'package:xiaobei/page/console/console.dart';
import 'package:xiaobei/page/msg/msg.dart';
import 'package:xiaobei/page/my/my.dart';


class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {

  int _index = 3;

  List<Widget> _list = [
    Msg(),
    AddressBook(),
    Console(),
    My()
  ];

  void _onTap(index){
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主页'),
      ),
      body: IndexedStack(
        index: _index,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: _onTap,
        items: [
          _getBottomNavItem(
              '通知', 'static/tabBar2/msg.png', 'static/tabBar2/msg_active.png', 0),
          _getBottomNavItem(
              ' 通讯录', 'static/tabBar2/addressBook.png', 'static/tabBar2/addressBook_active.png', 1),
          _getBottomNavItem(
              '工作台', 'static/tabBar2/console.png', 'static/tabBar2/console_active.png', 2),
          _getBottomNavItem(
              '我的', 'static/tabBar2/my.png', 'static/tabBar2/my_active.png', 3)
        ],
      ),
    );
  }



  BottomNavigationBarItem _getBottomNavItem(
      String title, String normalIcon, String pressedIcon, int index) {
    return BottomNavigationBarItem(
      icon: _index == index
          ? Image.asset(
        pressedIcon,
        width: 32,
        height: 28,
      )
          : Image.asset(
        normalIcon,
        width: 32,
        height: 28,
      ),
      label: title,
    );
  }



}
