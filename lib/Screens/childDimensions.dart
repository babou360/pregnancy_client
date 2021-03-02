import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/babyModel.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/services/userDatabaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomLoading.dart';
import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class ChildDimensions extends StatefulWidget {
  User currentUser;
  ChildDimensions(this.currentUser);

  @override
  _ChildDimensionsState createState() => _ChildDimensionsState();
}

class _ChildDimensionsState extends State<ChildDimensions> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  Pregnancy pregnancy = Pregnancy();
  UserDatabaseService _userDatabaseService = UserDatabaseService();
  int _selectedIndex;
  Stream babyWeekStram;
  Future babyWeekStram1;
  Baby babyWeek = Baby();
  List<Baby> _baby = List<Baby>();

  @override
  void initState() {
    super.initState();
    pregnancy.updateValue(this.widget.currentUser);
    _selectedIndex = pregnancy.weeks;
    babyWeekStram = _userDatabaseService.getBabyWeek(_selectedIndex);
    babyWeekStram1 = _userDatabaseService.baby1(_selectedIndex);
  }

  _onDaySelected(int index) {
    setState(() {
      _selectedIndex = index;
      babyWeekStram1 = _userDatabaseService.baby1(_selectedIndex);
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height / 1.5,
              child: FutureBuilder(
                future: babyWeekStram1,
                builder: (context, currentBabySnap) {
                  if (!currentBabySnap.hasData) {
                    return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        // color: Colors.black26
                      ),
                      child: Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[600].withOpacity(.9),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          // boxShadow: [
                          //   BoxShadow(
                          //   color:Color(0xFFdedede),
                          //   offset: Offset(2,2)
                          // ),
                          // ]
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Vipimo Vya Mtoto',style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white)),
                            ),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    decoration: BoxDecoration(
                                      color: Colors.green[600],
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                        color:Color(0xFFdedede),
                                        offset: Offset(2,2)
                                      ),
                                      ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Uzito',style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white)),
                                          Text('20 gm')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Urefu',style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white)),
                                          Text(' 50 cm')
                                        ],
                                    ),
                                    ),
                                  ),
                              ],
                            ) 
                          ],
                        ),
                      ))
                    ));
                  }
                  if (currentBabySnap.hasData && currentBabySnap.data.length < 1) {
                    return Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        // color: Colors.black26
                      ),
                      child: Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[600].withOpacity(.9),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          // boxShadow: [
                          //   BoxShadow(
                          //   color:Color(0xFFdedede),
                          //   offset: Offset(2,2)
                          // ),
                          // ]
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Vipimo Vya Mtoto',style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white)),
                            ),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    decoration: BoxDecoration(
                                      color: Colors.green[600],
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                        color:Color(0xFFdedede),
                                        offset: Offset(2,2)
                                      ),
                                      ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Uzito',style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white)),
                                          Text('20 gm')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Urefu',style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white)),
                                          Text(' 50 cm')
                                        ],
                                    ),
                                    ),
                                  ),
                              ],
                            ) 
                          ],
                        ),
                      ))
                    ));
                  }
                  if (currentBabySnap.hasData) {
                    return Container(
                        // height: MediaQuery.of(context).size.height,
                        // //currentBabySnap.data[index]['image']
                        child: ListView.builder(
                          shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    // color: Colors.black26
                                  ),
                                  child: Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[600].withOpacity(.9),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //   color:Color(0xFFdedede),
                                      //   offset: Offset(2,2)
                                      // ),
                                      // ]
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Vipimo Vya Mtoto',style: TextStyle(fontFamily: '',fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white)),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width/2,
                                                decoration: BoxDecoration(
                                                  color: Colors.green[600],
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                    color:Color(0xFFdedede),
                                                    offset: Offset(2,2)
                                                  ),
                                                  ]
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('Uzito',style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white)),
                                                      Text(currentBabySnap.data[index]['weight'].toString() + ' gm')
                                                    ],
                                                  ),
                                                ),
                                              ),
                                             Container(
                                                decoration: BoxDecoration(
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text('Urefu',style: TextStyle(fontFamily: 'Noto',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white)),
                                                      Text(currentBabySnap.data[index]['length'].toString() + ' cm')
                                                    ],
                                                ),
                                                ),
                                              ),
                                          ],
                                        ) 
                                      ],
                                    ),
                                  ),
                                )
                                ),
                              );
                            }));
                  }
                  if (currentBabySnap.connectionState ==ConnectionState.waiting) {
                    return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.black26
                                  ),
                                  child: Column(
                                    children: [
                                      Text('Vipimo vya Mtoto',
                                      style: TextStyle(fontSize: 20,fontFamily: 'CustomIcons',color: Colors.green[400])),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text('Urefu',
                                                style: TextStyle(fontSize: 15,fontFamily: 'Noto',color: Colors.green[200])),
                                                Row(
                                                  children: [
                                                    Text('12',
                                                    style: TextStyle(fontSize: 17,fontFamily: 'CustomIcons',color: Colors.white)),
                                                    SizedBox(width: 5,),
                                                    Text('cm',
                                                    style: TextStyle(fontSize: 17,fontFamily: 'Noto',color: Colors.green[400]))
                                                  ])
                                              ],
                                            ),
                                            VerticalDivider(color: Colors.green[400]),
                                            Column(
                                              children: [
                                                Text('Uzito',
                                                style: TextStyle(fontSize: 15,fontFamily: 'Noto',color: Colors.green[200])),
                                                Row(
                                                  children: [
                                                    Text('12',
                                                    style: TextStyle(fontSize: 17,fontFamily: 'CustomIcons',color: Colors.white)),
                                                    SizedBox(width: 5,),
                                                    Text('gm',
                                                    style: TextStyle(fontSize: 17,fontFamily: 'Noto',color: Colors.green[400]))
                                                  ])
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black26
                        ),
                        child: Column(
                          children: [
                            Text('Vipimo vya Mtoto',
                            style: TextStyle(fontSize: 20,fontFamily: 'CustomIcons',color: Colors.green[400])),
                            Padding(
                              padding: const EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text('Urefu',
                                      style: TextStyle(fontSize: 15,fontFamily: 'Noto',color: Colors.green[200])),
                                      Row(
                                        children: [
                                          Text('12',
                                          style: TextStyle(fontSize: 17,fontFamily: 'CustomIcons',color: Colors.white)),
                                          SizedBox(width: 5,),
                                          Text('cm',
                                          style: TextStyle(fontSize: 17,fontFamily: 'Noto',color: Colors.green[400]))
                                        ])
                                    ],
                                  ),
                                  VerticalDivider(color: Colors.green[400]),
                                  Column(
                                    children: [
                                      Text('Uzito',
                                      style: TextStyle(fontSize: 15,fontFamily: 'Noto',color: Colors.green[200])),
                                      Row(
                                        children: [
                                          Text('12',
                                          style: TextStyle(fontSize: 17,fontFamily: 'CustomIcons',color: Colors.white)),
                                          SizedBox(width: 5,),
                                          Text('gm',
                                          style: TextStyle(fontSize: 17,fontFamily: 'Noto',color: Colors.green[400]))
                                        ])
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      );
  }

  buildWeekRow() {
    return Container(
      height: blockHeight * 6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 41,
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: (index != 0)
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: blockWidth * 3),
                    width: (_selectedIndex == index)
                        ? blockWidth * 12.5
                        : blockWidth * 7.5,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: Align(
                      alignment: Alignment.center,
                      child: (_selectedIndex == index)
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      index.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: blockWidth * 4,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Text(
                              index.toString(),
                              style: TextStyle(
                                color: Colors.green[400],
                                fontSize: blockWidth * 4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
                  )
                : Text(''),
            onTap: () => _onDaySelected(index),
            // onTap: () => _onDaySelected(int.parse(index.toString())),
          );
        },
      ),
    );
  }
}
