import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pregnancy_tracking_app/Screens/dimensions.dart';
import 'package:pregnancy_tracking_app/Screens/today/charts/blood/blood-home.dart';
import 'package:pregnancy_tracking_app/Screens/childDimensions.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodayScreen extends StatefulWidget {
  User1 currentUser;
  TodayScreen(this.currentUser);
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  Pregnancy pregnancy = Pregnancy();
  bool exasta = false;
  List quotes=[
    'Ujauzito ni uumbaji wenye nguvu zaidi unaokua ndani ya mwili wako Hakuna zawadi kubwa zaidi ya hii',
    'Mwili wako umekupa zawadi kubwa zaidi ya maisha yako Furahia',
    'Mimba yako ni matende ya tembo utarudi kama zamani Kua mvumilivu',
    'Kua mjamzito ni kua kila siku unakaribia kukutana na mpenzi mwingine wa maisha yako',
    'Mtoto hujaza nafasi moyoni mwako ambayo hukuwai kudhani ipo wazi',
    'Sikuwai kua mwenye furaha kama sasa nitajifungua watoto kumi kama nitaweza',
    'Maisha ni kijinga cha moto kiunguacho daima lakini hushika moto zaidi kila  mtoto anapo zaliwa',
    'Kujifungua ni kuzuri kuliko ushindi kunastaajabisha kuliko mapambano na ni bora kuliko viwili hivyo'
  ];

  @override
  void initState() {
    super.initState();
    pregnancy.updateValue(this.widget.currentUser);
    docExists();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen[00],
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(height: blockHeight * 1),
          buildPercentageBar(),
          SizedBox(height: blockHeight * 1.5),
          buildCountRow(),
          SizedBox(height: blockHeight * .1),
          buildDueRow(),
          // SizedBox(height: blockHeight * .1),
          ChildDimensions(this.widget.currentUser),
          stack(),
          todayTip(),
        ],
      ),
    );
  }
  todayTip(){
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 8,top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[300].withOpacity(0),
          border: Border.all(color: Colors.green)
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[600].withOpacity(.9)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dondoo ya Leo',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white)),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.calendar,size: 20,color: Colors.black),
                          SizedBox(width: 5,),
                          Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                   Icon(FontAwesomeIcons.info,size: 50,color: Colors.green),
                   Container(
                     width: MediaQuery.of(context).size.width/1.3,
                     child:  Container(
                       height: 200,
                       child: CarouselSlider(
                              items:quotes.map((item) => Container(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(item.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'CustomIcons',color:Colors.grey[800])),
                                  )
                                ),
                                color: Colors.transparent,
                              )).toList(),
                              options: CarouselOptions(
                                  //height: 400,
                                  aspectRatio: 16/9,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 10),
                                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.vertical,
                              )
                            ),
                     )
                     )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  stack(){
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[600].withOpacity(0),
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // boxShadow: [
          //   BoxShadow(
          //   color:Color(0xFFdedede),
          //   offset: Offset(2,2)
          // ),
          // ]
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Dimensions(this.widget.currentUser)));
              },
              child: Container(
                // height: 100,
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  // color: Colors.green[400],
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                  // boxShadow: [
                  //   BoxShadow(
                  //   color:Color(0xFFdedede),
                  //   offset: Offset(2,2)
                  // ),
                  // ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.weight,size: 50,color: Colors.green),
                      SizedBox(height: 5,),
                      Text('Uzito',
                      style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.green))
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Blood(this.widget.currentUser)));
              },
              child: Container(
                decoration: BoxDecoration(
                ),
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // if(exasta) Text('0')
                      // else FutureBuilder(
                      //   future: FirebaseFirestore.instance.collection('blood').doc(this.widget.currentUser.mobileNumber).collection('current').orderBy('time',descending: true).get(),
                      //   builder: (context,snapshot){
                      //         return Container(
                      //           width: 100,
                      //           height: 50,
                      //           child: ListView.builder(
                      //             itemCount: snapshot.data.docs.length,
                      //             itemBuilder: (context,index){
                      //               return Text(snapshot.data.docs[index]['weight'].toString());
                      //             }),
                      //         );
                      //   }),
                      Icon(FontAwesomeIcons.calendarWeek,size: 50,color: Colors.green),
                      SizedBox(height: 5,),
                      Text('Wingi Damu',
                      style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.green))
                    ],
                ),
                 ),
              ),
            )
          ],
        ),
      ),
    );
  }

  
     docExists() async{
      // DocumentSnapshot ds= await FirebaseFirestore
      // .instance
      // .collection('blood')
      // .doc(this.widget.currentUser.mobileNumber)
      // .collection('current')
      // .get().then((snapshot) {
      //   List<DocumentSnapshot> allDocs = snapshot.docs;
      //   for (DocumentSnapshot ds in allDocs){
      //     ds.reference.get();
      //     // .then((value){
      //     //   Navigator.pop(context);
      //     // });
      //   }
      // });
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection("blood").doc(this.widget.currentUser.mobileNumber).get();
    if(ds.exists){
      setState(() {
      exasta = true;
    });
    }
  }
  ovalap(){
   return Container(
    constraints: new BoxConstraints(
      maxHeight: 200,
      maxWidth: MediaQuery.of(context).size.width
    ),
    padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
    decoration: new BoxDecoration(
      shape: BoxShape.circle,
      image: new DecorationImage(
        image: new AssetImage('images/11.jpeg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      children: [
        new Positioned(
          right: 0.0,
          bottom: 3.0,
          child: Container(
            constraints: new BoxConstraints(
                maxHeight: 50.0,
                maxWidth: 50.0
            ),
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:Color(0xFFdedede),
                  offset: Offset(2,2)
                ),
              ],
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.photo_camera,
                  size: 34,
                  color: Color(0xFF00cde7),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
  }
  pregnancyTools() {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          //  boxShadow: [
          //   new BoxShadow(
          //     color: Colors.grey.withOpacity(.7),
          //     offset: new Offset(2.0, 2.0),
          //   ),
          // ],
        ),
        child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dimensions(this.widget.currentUser)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[600].withOpacity(.9),
                          // boxShadow: [
                          //   new BoxShadow(
                          //     color: Colors.grey,
                          //     offset: new Offset(5.0, 5.0),
                          //   ),
                          // ],
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        alignment: Alignment.center,
                        height: 150,
                        width: MediaQuery.of(context).size.width/2.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.run_circle,size: 50,color: Colors.green[200]),
                            SizedBox(height: 10,),
                            Text('Uzito',
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Colors.green[400]))
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Blood(this.widget.currentUser)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        alignment: Alignment.center,
                        height: 150,
                        width: MediaQuery.of(context).size.width/2.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calculate,size: 50,color: Colors.green[200]),
                            SizedBox(height: 10,),
                            Text('Blood Count',
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Colors.green[400]))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
      ),
    );
  }

  buildPercentageBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: blockWidth * 3),
      child: LinearPercentIndicator(
        animation: true,
        lineHeight: blockHeight * 5,
        animationDuration: 2500,
        percent: pregnancy.days / 280,
        center: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Una Ujauzito wa ',
                // text: 'You are ',
                style: TextStyle(
                    fontWeight: FontWeight.w100, fontSize: blockWidth * 4,fontFamily: 'Noto'),
              ),
              TextSpan(
                text: (pregnancy.days >= 7)
                    ? (pregnancy.days >= 7 && pregnancy.days <= 13)
                        ? ' wiki '
                        : ' wiki '
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: blockWidth * 4),
              ),
              TextSpan(
                text: (pregnancy.days >= 7)
                    ? (pregnancy.days / 7).toInt().toString() 
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: blockWidth * 5),
              ),
              // TextSpan(
              //   text: ((pregnancy.days % 7 != 0) && (pregnancy.days >= 7))
              //       ? ' & '
              //       : ' ',
              //   style: TextStyle(
              //       fontWeight: FontWeight.w300, fontSize: blockWidth * 4),
              // ),
              TextSpan(
                text: (pregnancy.days % 7 != 0)
                    ? (pregnancy.days % 7 == 1)
                        ? ' siku '
                        : ' siku '
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: blockWidth * 4),
              ),
              TextSpan(
                text: (pregnancy.days % 7 != 0)
                    ? (pregnancy.days % 7).toString()
                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: blockWidth * 5),
              ),
              // TextSpan(
              //   text: 'pregnant ',
              //   style: TextStyle(
              //       fontWeight: FontWeight.w300, fontSize: blockWidth * 4),
              // ),
            ],
          ),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.green[700],
        backgroundColor: Colors.green[400],
        curve: Curves.easeInOut,
      ),
    );
  }

  buildCountRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: blockWidth * 3),
      height: blockHeight * 15,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          color: Colors.green[400].withOpacity(0),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Siku',style: TextStyle(fontSize: 20,fontFamily: '', fontWeight: FontWeight.w300, color: Colors.grey[800])),
                CustomBannerText(
                  fontFamily: '',
                  color: Colors.green,
                  title: pregnancy.days.toString(),
                  size: blockWidth * 6,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: blockHeight * 2),
              child: VerticalDivider(
                color: Colors.green,
                width: blockWidth * 2,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Wiki',style: TextStyle(fontFamily: '', fontSize: 20,color: Colors.grey[800],fontWeight: FontWeight.w300)),
                // CustomBannerText(title: "Week"),
                CustomBannerText(
                  fontFamily: 'Noto',
                  color: Colors.green,
                  title:pregnancy.weeks<=1?pregnancy.weeks.toString() : '${pregnancy.weeks-1}',
                  // title: pregnancy.weeks.toString(),
                  size: blockWidth * 6,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: blockHeight * 2),
              child: VerticalDivider(
                color: Colors.green,
                width: blockWidth * 2,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Mwezi',style: TextStyle(fontFamily: '',fontSize: 20,color: Colors.grey[800],fontWeight: FontWeight.w300)),
                // CustomBannerText(title: "Month"),
                CustomBannerText(
                  fontFamily: 'Noto',
                  color: Colors.green,
                  title: pregnancy.months.toString(),
                  size: blockWidth * 6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildDueRow() {
    return Container(
      margin: EdgeInsets.only(top: blockHeight * 1),
      padding: EdgeInsets.symmetric(horizontal: blockWidth * 3),
      // height: blockHeight * 13,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[600].withOpacity(0),
          border: Border.all(color: Colors.green),
          // color: Colors.lightGreen[100],
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Tarehe ya Kujifungua',style: TextStyle(
                    fontFamily: '',
                    fontWeight: FontWeight.w300,
                    fontSize: blockWidth * 4,
                    color: Colors.white,
                  )),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tarehe ',
                            style: TextStyle(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              fontSize: blockWidth * 5,
                              color: Colors.grey[800],
                            ),
                          ),
                          TextSpan(
                            text: (pregnancy.dueDays <= 0) ? 'Ilikua ' : '',
                            // text: (pregnancy.dueDays <= 0) ? 'was ' : '',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: blockWidth * 5,
                              color: Colors.grey[800],
                            ),
                          ),
                          TextSpan(
                            text: ' ' +
                            '${this.widget.currentUser.dueDate.day}/ ${this.widget.currentUser.dueDate.month}/ ${this.widget.currentUser.dueDate.year}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: blockWidth * 5,
                              fontFamily: 'CustomIcons',
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: blockHeight),
                    RichText(
                      text: (pregnancy.dueDays > 0)
                          ? TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Zimebaki ',
                                  style: TextStyle(
                                    fontFamily: '',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey[800],
                                    fontSize: blockWidth * 5,
                                  ),
                                ),
                                TextSpan(
                                  text: (pregnancy.dueDays >= 7)
                                      ? (pregnancy.dueDays >= 7 &&
                                              pregnancy.dueDays <= 13)
                                              ? ' wiki '
                                              : ' wiki '
                                          // ? ' week '
                                          // : ' weeks '
                                      : '',
                                  style: TextStyle(
                                    fontFamily: '',
                                      fontWeight: FontWeight.w500,
                                      fontSize: blockWidth * 5,
                                      color: Colors.green[200]),
                                ),
                                TextSpan(
                                  text: (pregnancy.dueDays >= 7)
                                      ? (pregnancy.dueDays / 7).toInt().toString()
                                      : '',
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: blockWidth * 6,
                                      color: Colors.grey[800]),
                                ),
                                // TextSpan(
                                //   text: ((pregnancy.dueDays % 7 != 0) &&
                                //           (pregnancy.dueDays >= 7))
                                //       ? ' & '
                                //       : '',
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w500,
                                //     color: Colors.green,
                                //     fontSize: blockWidth * 5,
                                //   ),
                                // ),
                                TextSpan(
                                  text: (pregnancy.dueDays % 7 != 0)
                                      ? (pregnancy.dueDays % 7 == 1)
                                          ? ' siku '
                                          : ' siku '
                                      : '',
                                  style: TextStyle(
                                    fontFamily: '',
                                      fontWeight: FontWeight.w500,
                                      fontSize: blockWidth * 5,
                                      color: Colors.green[200]),
                                ),
                                TextSpan(
                                  text: (pregnancy.dueDays % 7 != 0)
                                      ? (pregnancy.dueDays % 7).toString()
                                      : '',
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: blockWidth * 6,
                                      color: Colors.grey[800]),
                                ),
                                // TextSpan(
                                //   text: 'left ',
                                //   style: TextStyle(
                                //     fontFamily: 'CustomIcons',
                                //     fontWeight: FontWeight.w400,
                                //     color: Colors.white,
                                //     fontSize: blockWidth * 5,
                                //   ),
                                // ),
                              ],
                            )
                          : TextSpan(
                              text: 'You will deliver soon',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: blockWidth * 5,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}