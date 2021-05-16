import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/babyModel.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/services/userDatabaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomLoading.dart';
import 'package:pregnancy_tracking_app/widget/ImageView.dart';
import 'package:pregnancy_tracking_app/widget/tipContainer.dart';
import 'package:share/share.dart';

class BabyScreen extends StatefulWidget {
  User1 currentUser;
  BabyScreen(this.currentUser);

  @override
  _BabyScreenState createState() => _BabyScreenState();
}

class _BabyScreenState extends State<BabyScreen> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  Pregnancy pregnancy = Pregnancy();
  UserDatabaseService _userDatabaseService = UserDatabaseService();
  int _selectedIndex;
  Stream babyWeekStram;
  Future babyWeekStram1;
  Baby babyWeek = Baby();

  @override
  void initState() {
    super.initState();
    pregnancy.updateValue(this.widget.currentUser);
    _selectedIndex = pregnancy.weeks;
     babyWeekStram = _userDatabaseService.getBabyWeek(_selectedIndex);
    // babyWeekStram1 = _userDatabaseService.baby1(int.parse(_selectedIndex.toString()));
  }

  _onDaySelected(int index) {
    setState(() {
      _selectedIndex = index;
      // babyWeekStram = _userDatabaseService.getBabyWeek(_selectedIndex);
       babyWeekStram1 = _userDatabaseService.baby1(int.parse(_selectedIndex.toString()));
      // babyWeekStram1 = _userDatabaseService.baby1(int.parse(_selectedIndex.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: babyWeekStram1,
      // stream: babyWeekStram,
      builder: (context, currentBabySnap) {
        if (!currentBabySnap.hasData) {
          Center(
            child: Text('No Data '),
          );
        }
            if (currentBabySnap.hasData && currentBabySnap.data.exists) {
          // if (currentBabySnap.hasData) {
          // this.babyWeek.size = double.parse(currentBabySnap.data["length"]);
          // this.babyWeek.weight = double.parse(currentBabySnap.data["weight"]);
          this.babyWeek.imageURL = currentBabySnap.data["image"];
          this.babyWeek.title = currentBabySnap.data["title"];
          this.babyWeek.tipDescription = currentBabySnap.data["description"];
          // this.babyWeek.week = int.parse(currentBabySnap.data["week"]);
        }
        if (currentBabySnap.connectionState == ConnectionState.waiting) {
          return CustomLoading();
        }
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(height: blockHeight * 1),
                buildWeekRow(),
                Card(
                  child: Column(
                    children: [
                      Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: this.babyWeek.imageURL == null
                              ? Image.asset('images/baby.png',fit: BoxFit.fitHeight)
                              : Image.network(this.babyWeek.imageURL,
                                  fit: BoxFit.cover)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                                this.babyWeek.title == null
                                    ? "News From This Week"
                                    : this.babyWeek.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800])),
                            Text(
                                this.babyWeek.tipDescription == null
                                    ? "Your Baby is indeed a powerhouse of it's own busy growing and developing. At this week your baby is as big as bluebery the retinas and tongue are in their earliest stage of growth, as are the beds for fingernails.The brain and heart are becoming more developed.The nostrils, lungs, hands and feet are also developing rapidly. Moving down, the intestines and liver are also forming. The embryo still sports a small tail which will disappear during the next few weeks"
                                    : this.babyWeek.tipDescription,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800]))
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      RaisedButton(
                          child:  Icon(Icons.share),
                          onPressed: ()
                          {
                            final RenderBox box = context.findRenderObject();
                            Share.share(this.babyWeek.title==null ?"Hello" :this.babyWeek.title,
                                subject: this.babyWeek.tipDescription == null ?"hi" :this.babyWeek.tipDescription  ,
                                sharePositionOrigin:
                                box.localToGlobal(Offset.zero) &
                                box.size);
                          },
                        ),
                    ],
                  ),
                )
                // SizedBox(height: blockHeight * 2),
                // ImageView(imageURL: this.babyWeek.imageURL),
                // SizedBox(height: blockHeight * 2.5),
                // buildCountRow(),
                // SizedBox(height: blockHeight * 1),
                // TipContainer("fromBaby", this.babyWeek.tipDescription,
                //     this.babyWeek.week),
                // SizedBox(height: blockHeight * 2),
              ],
            ),
          ),
        );
      },
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
                                color: Colors.green[100],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      index.toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: blockWidth * 4,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // Text("Week",
                                    //     style: TextStyle(
                                    //       color: Colors.black87,
                                    //       fontSize: blockWidth * 2.5,
                                    //       fontWeight: FontWeight.w500,
                                    //     )),
                                  ],
                                ),
                              ),
                            )
                          : Text(
                              index.toString(),
                              style: TextStyle(
                                color: Colors.green[800],
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

  // buildCountRow() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: blockWidth * 3),
  //     height: blockHeight * 15,
  //     width: double.infinity,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.lightGreen[100].withOpacity(0.7),
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(15.0),
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               CustomBannerText(title: "Size"),
  //               CustomBannerText(
  //                   title: this.babyWeek.size.toString(),
  //                   // this.babyWeek.size.toString().toString(),
  //                   size: blockWidth * 10),
  //               CustomBannerText(title: "cm"),
  //             ],
  //           ),
  //           Padding(
  //             padding: EdgeInsets.symmetric(vertical: blockHeight * 2),
  //             child: VerticalDivider(
  //               color: Colors.green[700],
  //               // width: blockWidth * 2,
  //             ),
  //           ),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               CustomBannerText(title: "Weight"),
  //               CustomBannerText(
  //                   title: this.babyWeek.weight.toString(),
  //                   // title: this.babyWeek.weight.toString(),
  //                   size: blockWidth * 10),
  //               CustomBannerText(title: "g"),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
