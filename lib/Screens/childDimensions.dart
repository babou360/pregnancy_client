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
  User1 currentUser;
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
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[600].withOpacity(0),
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                          ),
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Uzito wa Mtoto',style: TextStyle(fontFamily: '',fontSize: 18,fontWeight: FontWeight.w300,color: Colors.white)),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                // width: MediaQuery.of(context).size.width/2,
                                                decoration: BoxDecoration(
                                                  color: Colors.green[400].withOpacity(0),
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Row(
                                                    children: [
                                                      Text('Mwanao ana uzito wa',
                                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600])),
                                                      SizedBox(width: 5),
                                                      Text('20',
                                                      style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey[600])),
                                                      SizedBox(width: 2),
                                                      Text('gm',
                                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600]))
                                                    ],
                                                  )
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
                  }
                  if (currentBabySnap.hasData && currentBabySnap.data.length < 1) {
                    return Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[600].withOpacity(0),
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                          ),
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Uzito wa Mtoto',style: TextStyle(fontFamily: '',fontSize: 18,fontWeight: FontWeight.w300,color: Colors.white)),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                // width: MediaQuery.of(context).size.width/2,
                                                decoration: BoxDecoration(
                                                  color: Colors.green[400].withOpacity(0),
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Row(
                                                    children: [
                                                      Text('Mwanao ana uzito wa',
                                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600])),
                                                      SizedBox(width: 5),
                                                      Text('20',
                                                      style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey[600])),
                                                      SizedBox(width: 2),
                                                      Text('gm',
                                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600]))
                                                    ],
                                                  )
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
                  }
                  if (currentBabySnap.hasData) {
                    return Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[600].withOpacity(0),
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                          ),
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Uzito wa Mtoto',style: TextStyle(fontFamily: '',fontSize: 18,fontWeight: FontWeight.w300,color: Colors.white)),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                // width: MediaQuery.of(context).size.width/2,
                                                decoration: BoxDecoration(
                                                  color: Colors.green[400].withOpacity(0),
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Row(
                                                    children: [
                                                      Text('Mwanao ana uzito wa',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600])),
                                                      SizedBox(width: 5),
                                                      Text(currentBabySnap.data[index]['weight'].toString(),
                                                      style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey[600])),
                                                      SizedBox(width: 2),
                                                      Text(currentBabySnap.data[index]['dimension'].toString(),
                                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600]))
                                                    ],
                                                  )
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
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[600].withOpacity(0),
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                          ),
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Uzito wa Mtoto',style: TextStyle(fontFamily: '',fontSize: 18,fontWeight: FontWeight.w300,color: Colors.white)),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                // width: MediaQuery.of(context).size.width/2,
                                                decoration: BoxDecoration(
                                                  color: Colors.green[400].withOpacity(0),
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Row(
                                                    children: [
                                                      Text('Mwanao ana uzito wa',
                                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600])),
                                                      SizedBox(width: 5),
                                                      Text('20',
                                                      style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey[600])),
                                                      SizedBox(width: 2),
                                                      Text('gm',
                                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600]))
                                                    ],
                                                  )
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
                  } else {
                    return Padding(
                                padding: const EdgeInsets.only(left: 8,right: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[600].withOpacity(0),
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                          ),
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Uzito wa Mtoto',style: TextStyle(fontFamily: '',fontSize: 18,fontWeight: FontWeight.w300,color: Colors.white)),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                // width: MediaQuery.of(context).size.width/2,
                                                decoration: BoxDecoration(
                                                  color: Colors.green[400].withOpacity(0),
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight:Radius.circular(50),topLeft: Radius.circular(20),bottomLeft:Radius.circular(20)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Row(
                                                    children: [
                                                      Text('Mwanao ana uzito wa',
                                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600])),
                                                      SizedBox(width: 5),
                                                      Text('20',
                                                      style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey[600])),
                                                      SizedBox(width: 2),
                                                      Text('gm',
                                                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[600]))
                                                    ],
                                                  )
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
