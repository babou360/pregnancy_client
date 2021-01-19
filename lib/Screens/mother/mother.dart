import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/babyModel.dart';
import 'package:pregnancy_tracking_app/models/motherModel.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/services/userDatabaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomLoading.dart';
import 'package:pregnancy_tracking_app/widget/ImageView.dart';
import 'package:pregnancy_tracking_app/widget/tipContainer.dart';

class MotherNew extends StatefulWidget {
  User currentUser;
  MotherNew(this.currentUser);

  @override
  _MotherNewState createState() => _MotherNewState();
}

class _MotherNewState extends State<MotherNew> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  Pregnancy pregnancy = Pregnancy();
  UserDatabaseService _userDatabaseService = UserDatabaseService();
  int _selectedIndex;
  Stream motherMonthStram;
  Mother mother = Mother();

  @override
  void initState() {
    super.initState();
    pregnancy.updateValue(this.widget.currentUser);
    _selectedIndex = pregnancy.months;
    motherMonthStram = _userDatabaseService.getMomMonth(_selectedIndex);
  }

  _onDaySelected(int index) {
    setState(() {
      _selectedIndex = index;
      motherMonthStram = _userDatabaseService.getMomMonth(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: motherMonthStram,
      builder: (context, currentMotherSnap) {
        if (currentMotherSnap.hasData && currentMotherSnap.data.exists) {
          this.mother.size = int.parse(currentMotherSnap.data["length"]);
          this.mother.weight = int.parse(currentMotherSnap.data["weight"]);
          this.mother.imageURL = currentMotherSnap.data["image"];
          this.mother.tipDescription = currentMotherSnap.data["description"];
          this.mother.week = int.parse(currentMotherSnap.data["month"]);
        }
        if (currentMotherSnap.connectionState == ConnectionState.waiting) {
          return CustomLoading();
        }
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(height: blockHeight * 1),
                buildMonthRow(),
                Card(
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                       child: Image.network(this.mother.imageURL,fit: BoxFit.cover)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(this.mother.tipDescription,style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey[800]))
                          ],
                        ),
                      ),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Baby's Dimensions on Week ",style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(this.mother.week.toString()),
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
                                  child: Text(this.mother.size.toString() + ' CM'),
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
                                  child: Text(this.mother.weight.toString() + ' KG'),
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
                // ImageView(imageURL: this.mother.imageURL),
                // SizedBox(height: blockHeight * 2.5),
                // buildCountRow(),
                // SizedBox(height: blockHeight * 1),
                // TipContainer("fromBaby", this.mother.tipDescription,
                //     this.mother.week),
                // SizedBox(height: blockHeight * 2),
              ],
            ),
          ),
        );
      },
    );
  }

  buildMonthRow() {
    return Container(
      height: blockHeight * 6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 11,
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
                                    // Text("Month",
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
                    title: this.mother.size.toString(),
                    // this.mother.size.toString().toString(),
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
                    title: this.mother.weight.toString(),
                    // title: this.mother.weight.toString(),
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
