import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/payment/airtel.dart';
import 'package:pregnancy_tracking_app/Screens/payment/mobile.dart';

class PayHome extends StatefulWidget {
  @override
  _PayHomeState createState() => _PayHomeState();
}

class _PayHomeState extends State<PayHome> {
  int _currentIndex = 0;
  final List<Widget> _children = [
   Mobile(),
   Airtel()
 ];
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black45,
          selectedLabelStyle: TextStyle(fontSize: 20,color: Colors.orange,fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),

          backgroundColor: Colors.teal,
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'M-Pesa',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Airtel-Money',
            ),
          ],
        ),
      );
  }
}