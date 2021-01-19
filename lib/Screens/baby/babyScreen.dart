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

class BabyScreen extends StatefulWidget {
  User currentUser;
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
  Baby babyWeek = Baby();

  @override
  void initState() {
    super.initState();
    pregnancy.updateValue(this.widget.currentUser);
    _selectedIndex = pregnancy.weeks;
    babyWeekStram = _userDatabaseService.getBabyWeek(_selectedIndex);
  }

  _onDaySelected(int index) {
    setState(() {
      _selectedIndex = index;
      babyWeekStram = _userDatabaseService.getBabyWeek(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: babyWeekStram,
      builder: (context, currentBabySnap) {
        if (currentBabySnap.hasData && currentBabySnap.data.exists) {
          this.babyWeek.size = double.parse(currentBabySnap.data["length"]);
          this.babyWeek.weight = double.parse(currentBabySnap.data["weight"]);
          this.babyWeek.imageURL = currentBabySnap.data["image"];
          this.babyWeek.tipDescription = currentBabySnap.data["description"];
          this.babyWeek.week = int.parse(currentBabySnap.data["week"]);
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
                       child: Image.network(this.babyWeek.imageURL,fit: BoxFit.cover)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(this.babyWeek.tipDescription,style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey[800]))
                          ],
                        ),
                      ),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Baby's Dimensions on Week ",style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(this.babyWeek.week.toString()),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                  ),
                            child: Column(
                              children: [
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text('Length'),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(this.babyWeek.size.toString() + ' CM'),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    // borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                  ),
                            child: Column(
                              children: [
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text('Weight'),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(this.babyWeek.weight.toString() + ' KG'),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    // borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
          );
        },
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
          color: Colors.lightGreen[100].withOpacity(0.7),
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
                CustomBannerText(title: "Size"),
                CustomBannerText(
                    title: this.babyWeek.size.toString(),
                    // this.babyWeek.size.toString().toString(),
                    size: blockWidth * 10),
                CustomBannerText(title: "cm"),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: blockHeight * 2),
              child: VerticalDivider(
                color: Colors.green[700],
                // width: blockWidth * 2,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomBannerText(title: "Weight"),
                CustomBannerText(
                    title: this.babyWeek.weight.toString(),
                    // title: this.babyWeek.weight.toString(),
                    size: blockWidth * 10),
                CustomBannerText(title: "g"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
