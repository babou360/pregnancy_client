import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/payment/mobile.dart';
import 'package:pregnancy_tracking_app/Screens/payment/payHome.dart';
import 'package:pregnancy_tracking_app/Screens/payment/payment.dart';

class Sorry extends StatefulWidget {
  @override
  _SorryState createState() => _SorryState();
}

class _SorryState extends State<Sorry> {

 void bottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            child: new Wrap(
            children: <Widget>[
          new ListTile(
              leading: new Icon(Icons.mobile_friendly),
              title: new Text('Card',
              style: TextStyle(fontWeight: FontWeight.w500,color: Colors.teal,fontSize: 25,fontFamily: 'Economica')),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (_) => Payment()))
              },          
            ),
            new ListTile(
              leading: new Icon(Icons.mobile_friendly),
              title: new Text('Mobile',
              style: TextStyle(fontWeight: FontWeight.w500,color: Colors.teal,fontSize: 25,fontFamily: 'Economica')),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (_) => PayHome()))
              },          
            ),
            ],
          ),
          );
      }
    );
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 350,
              child: Image.asset('images/soory.jpg',fit: BoxFit.cover,)),
            Center(
            child: Text('Samahani',
            style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 25,fontFamily: 'Economica')),
          ),
          Center(
            child: Text('Usajili Wako umesitishwa',
            style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white,fontSize: 20,fontFamily: 'Economica')),
          ),
          Center(
            child: Text('Lipia Uendelea Kufurahia',
            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 20,fontFamily: 'Economica')),
          ),
          SizedBox(height: 40,),
          GestureDetector(
            onTap:()=> bottomSheet(context),
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Pay Now',
                style: TextStyle(fontWeight: FontWeight.w500,color: Colors.teal,fontSize: 18,fontFamily: 'Economica')),
              ),
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}