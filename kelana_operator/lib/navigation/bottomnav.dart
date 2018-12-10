import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
 final Color color;

 PlaceholderWidget(this.color);

 @override
 Widget build(BuildContext context) {
   return Container(
     color: color,
   );
 }
}

class Bottomnav extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _BottomnavState();
  }
}

class _BottomnavState extends State<Bottomnav> {
  int _currentIndex = 0;
  final List<Widget> _children = [
   PlaceholderWidget(Colors.white),
   PlaceholderWidget(Colors.deepOrange),
   PlaceholderWidget(Colors.green),
   PlaceholderWidget(Colors.blue)
 ];
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Kuntul'),
     ),
     body: _children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       type: BottomNavigationBarType.fixed,
       onTap: onTabTapped,
       currentIndex: _currentIndex, // this will be set when a new tab is tapped
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.search),
           title: new Text('Search'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.navigation),
           title: new Text('Agenda'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.chat),
           title: new Text('Chat'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('Profile')
         )
       ],
     ),
   );
 }

 void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}

