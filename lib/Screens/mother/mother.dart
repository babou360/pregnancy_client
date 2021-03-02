import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/motherModel.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/models/pregnancy.dart';
import 'package:pregnancy_tracking_app/services/userDatabaseService.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomLoading.dart';
import 'package:pregnancy_tracking_app/widget/texts.dart';
import 'package:share/share.dart';

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
  Future motherMonthStram;
  Mother mother = Mother();

  @override
  void initState() {
    super.initState();
    pregnancy.updateValue(this.widget.currentUser);
    // _selectedIndex = pregnancy.months;
    _selectedIndex = pregnancy.weeks;
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
    return  SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height / 5,
              child: buildMonthRow(),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: FutureBuilder(
                future: motherMonthStram,
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
                                height: 350,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("images/preg.jpg",fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Maendeleo ya Mama",
                                    style: TextStyle( fontSize: 17, fontFamily: 'Noto', color: Colors.green[400])),
                                    SizedBox(height: 5,),
                                    Text(Texts().mother,style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Economica',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800]
                                      )),
                                    SizedBox(height: 5,),
                                    Divider(color: Colors.green,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Maendeleo ya Mama',
                                         style: TextStyle( fontSize: 15,fontWeight: FontWeight.w600,  color: Colors.green[400],fontFamily: 'Noto')),
                                        GestureDetector(
                                          onTap: (){
                                            Share.share(Texts().mother,subject:'Good Day',);
                                          },
                                          child: Icon(Icons.share,color: Colors.green),
                                        )
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
                    // return Center(
                    //   child: Text('OOOOPS SORRY NO DATA',style: TextStyle(fontWeight: FontWeight.w500)),
                    // );
                  }
                  if (currentBabySnap.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // color: Colors.black26,
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: currentBabySnap.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    color: Colors.black12,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5,),
                                          Container(width: MediaQuery.of(context).size.width,
                                              height: 300,
                                              child: CachedNetworkImage(
                                                imageUrl: currentBabySnap.data[index]['image'],fit: BoxFit.fill,
                                                placeholder: (context, url) => Image.asset('images/place4.png',fit: BoxFit.cover),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                           ),
                                          SizedBox(height: 7),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                Text( currentBabySnap.data[index]['title'],
                                                    style: TextStyle(
                                                      fontFamily: 'Noto',
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.green[400])),
                                                SizedBox( height: 7),
                                                Text( currentBabySnap.data[index]['description'],
                                                    style: TextStyle(
                                                      fontFamily: 'Economica',
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.grey[800])),
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
                                                Text("Maendeleo ya Mama Wiki ${  currentBabySnap.data[index]['month']}",
                                                    style: TextStyle(
                                                        fontFamily: 'Noto',
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.green[400])),
                                                GestureDetector(
                                                  onTap: (){
                                                    Share.share(currentBabySnap.data[index]['description'],subject:currentBabySnap.data[index]['title'],);
                                                  },
                                                  child: Icon(Icons.share,color: Colors.green),
                                                )
                                                ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                    );
                  }
                  if (currentBabySnap.connectionState ==
                      ConnectionState.waiting) {
                    return CustomLoading();
                  } else {
                    return Text('No Data');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  buildMonthRow() {
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
                          : Text(index.toString(),
                              style: TextStyle(
                                color: Colors.green,
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
