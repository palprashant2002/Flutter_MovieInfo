import 'package:dsc/trend.dart';
import 'package:dsc/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/stack.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentindex = 0;
  final screens = [trend(), tvview()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Welcome To Movie Info",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: IndexedStack(
        index: _currentindex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Trending Movies"),
          // BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Movie'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Trendind on TV')
        ],
        onTap: (value) {
          setState(() {
            _currentindex = value;
          });
        },
      ),
    );
  }
}
