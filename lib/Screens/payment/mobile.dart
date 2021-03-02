import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/payment/payment.dart';

class Mobile extends StatefulWidget {
  @override
  _MobileState createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('images/mpesa3.png',fit: BoxFit.cover,)),
              Text('Piga *150*00#',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.teal)),
              SizedBox(height: 7,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Chagua ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                        Text('4.Lipa Kwa M-Pesa',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.teal[200]))
                      ],
                    ),
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Chagua ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                        Text('6.M-Pesa MasterCard',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.teal[200]))
                      ],
                    ),
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Chagua ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                        Text('3.Tengeneza Card',
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.teal[200]))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text('Utapokea Ujumbe wenye number yako ya Card CVV na Expire Date',
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.teal[200])),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Payment()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Endelea',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.white)),
                  ),
                ),
              )
          ],
        )
      ),
    );
  }
}