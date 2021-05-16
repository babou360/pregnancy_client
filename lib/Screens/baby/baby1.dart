import 'package:cached_network_image/cached_network_image.dart';
import 'package:pregnancy_tracking_app/widget/texts.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/babyModel.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/services/userDatabaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomLoading.dart';
import 'package:share/share.dart';

class Baby1 extends StatefulWidget {
  User1 currentUser;
  Baby1(this.currentUser);

  @override
  _Baby1State createState() => _Baby1State();
}

class _Baby1State extends State<Baby1> {
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
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height / 5,
              child: buildWeekRow(),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: FutureBuilder(
                future: babyWeekStram1,
                builder: (context, currentBabySnap) {
                  if (!currentBabySnap.hasData) {
                    Center(
                      child: Text('No Data '),
                    );
                  }
                  if (currentBabySnap.hasData && currentBabySnap.data.length < 1) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.black12,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                minHeight: 400,
                                maxHeight: 500,
                              ),
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("images/baby2.jpg",fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Maendeleo ya mtoto",
                                    style: TextStyle( fontSize: 17, fontFamily: 'Noto', color: Colors.green[400])),
                                    SizedBox(height: 5,),
                                    Text(Texts().mtoto,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: '',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]
                                      )
                                    ),
                                    SizedBox(height: 5,),
                                    Divider(color: Colors.green,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Maendeleo ya wiki', style: TextStyle( fontSize: 15,fontWeight: FontWeight.w600,  color: Colors.green[400],fontFamily: 'Noto')),
                                        // GestureDetector(
                                        //   onTap: (){
                                        //     Share.share(Texts().mtoto,subject:'Good Day',);
                                        //   },
                                        //   child: Icon(Icons.share,color: Colors.green),
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (currentBabySnap.hasData) {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: currentBabySnap.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 5,left: 5,right:5,bottom: 5),
                                child: Container(
                                  color: Colors.black12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context).size.width,
                                            constraints: BoxConstraints(
                                              minHeight: 300,
                                              maxHeight: 500,
                                            ),
                                            // height: 300,
                                            child: CachedNetworkImage(
                                                imageUrl: currentBabySnap.data[index]['image'],fit: BoxFit.fill,
                                                placeholder: (context, url) => Image.asset('images/place4.png',fit: BoxFit.cover),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                        SizedBox(height: 7 ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(currentBabySnap.data[index]['title'],
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'Noto',
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.green[400])),
                                              SizedBox( height: 7),
                                              Text( currentBabySnap.data[index]['description'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: '',
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.grey[600])),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 7),
                                        Divider(color: Colors.green,),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Text("Maendeleo ya wiki " +currentBabySnap.data[index]['week'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Noto',
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.green[400])),
                                              SizedBox(width:20),
                                              // GestureDetector(
                                              //   onTap: (){
                                              //     Share.share(currentBabySnap.data[index]['description'],subject:currentBabySnap.data[index]['image'],);
                                              //   },
                                              //   child: Icon(Icons.share,color: Colors.green),
                                              // )
                                              ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
                  }
                  if (currentBabySnap.connectionState ==
                      ConnectionState.waiting) {
                    return CustomLoading();
                  } else {
                    return Text('Hakuna Data');
                  }
                },
              ),
            )
          ],
        ),
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
