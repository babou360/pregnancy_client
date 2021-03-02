import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_tracking_app/Screens/profile/PersonalInfo.dart';
import 'package:pregnancy_tracking_app/Screens/profile/pregInfo.dart';
import 'package:pregnancy_tracking_app/Screens/profile/update/updateLastDate.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/authService.dart';
import 'package:pregnancy_tracking_app/services/databaseService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  User currentUser;
  ProfileScreen(this.currentUser);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  DatabaseService dbs = DatabaseService();
  DateTime selectedDate;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  payDate() {

    final joined = this.widget.currentUser.joinedAt;
    final payDate = this.widget.currentUser.payDate;
    final renewal = this.widget.currentUser.renewalDate;
    final date2 = DateTime.now();
    final difference = date2.difference(joined).inDays;
    final ideal = 5-difference;
    final difference1 = renewal.difference(date2).inDays;

    check() {
      // if (difference > 5) {
      //  return Text("Your Trial Has Ended");
      // }else
       if(difference == 5){
        return Text("Trial yako inaisha leo");
      }else if(difference < 5){
        return Row(
          children: [
            Text('Trial yako itaisha baada ya siku ',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 15)),
            Text(ideal.toString(),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[800],fontSize: 15)),
            // Text(' Day(s) Time',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 15))
          ],
        );
      } else {
        return Row(
          children: [
            Text('Utalipa tena baada ya siku ',
            style: TextStyle(fontWeight: FontWeight.w500,
            fontFamily: '',
            color: Colors.white,fontSize: 15)),
            Text(difference1.toString(),
            style: TextStyle(fontWeight: FontWeight.w500,
            fontFamily: '',
            color: Colors.grey[800],fontSize: 20)),
            Text(' kupita',
            style: TextStyle(fontWeight: FontWeight.w500,
            fontFamily: '',
            color: Colors.white,fontSize: 15))
          ],
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green[600].withOpacity(.9),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Taarifa Za Malipo',
                  style: TextStyle(fontWeight: FontWeight.w400,
                  fontFamily: '',
                  color: Colors.grey[800],fontSize: 20)),
                  Icon(Icons.bookmark,size: 30,color: Colors.white)],
              ),
              SizedBox(height: 10,),
              check(),
            ],
          ),
        ),
      ),
    );
  }

  LastDate() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.green[600].withOpacity(.9),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mwisho wa Hedhi',
                      style: TextStyle(fontWeight: FontWeight.w400,
                      fontFamily: '',
                      color: Colors.grey[800],fontSize: 20)
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.green[300].withOpacity(.3),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: IconButton(
                        icon: Icon(Icons.edit,color: Colors.white),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) =>
                                  UpdateLastDate(this.widget.currentUser));
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Tarehe',
                        style: TextStyle(
                          fontFamily: '',
                          fontSize: 15,
                            fontWeight: FontWeight.w400, color: Colors.grey[800])),
                    SizedBox( width: 10),
                    Text(
                      DateFormat.yMd('en_US').format(this.widget.currentUser.lastPeriodDate)
                        // DateFormat('EEE, d MMM yyyy')
                        //     .format(this.widget.currentUser.lastPeriodDate)
                            .toString(),
                        style: TextStyle(
                          fontFamily: 'Noto',
                            fontWeight: FontWeight.w300, color: Colors.white))
                  ],
                )
              ],
            ),
          )),
    );
  }

  lastChild(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onClickLogout,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                        )),
                        Icon(Icons.outbond,color: Colors.white)
                      ],
                    ),
                  )
                ),
              ),
              VerticalDivider(
                color: Colors.white,
                thickness: 2,
              ),
              GestureDetector(
                onTap: contact,
                // onTap: _whatsapp,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Contact',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontSize: 18
                        )),
                        Icon(Icons.whatshot_sharp,color: Colors.white)
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.green[600].withOpacity(.9),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      ),
    );
  }

  _whatsapp() async {
  const url = 'https://wa.me/+255787474787';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_instagram() async {
  const url = 'https://www.instagram.com/mama.na.mwana.tips/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_facebook() async {
  const url = 'https://www.facebook.com/mamanamwana';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  onClickLogout() {
    var authService = AuthService();
    authService.signOut(this.context);
    // dbs.getSubscriptions(this.widget.currentUser.userId);
  }

  contact(){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              color: Colors.green[600]
            ),
            height: MediaQuery.of(context).size.height  * 0.4,
            child: Center(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(FontAwesomeIcons.projectDiagram,color: Colors.white),
                        Text('Contact Us',style: TextStyle(fontFamily: 'Noto',fontSize: 20,color: Colors.grey[800])),
                        IconButton(
                          icon: Icon(Icons.cancel_outlined,size: 40,color: Colors.white),
                          onPressed:()=> Navigator.pop(context)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _instagram,
                    child: Container(
                      // color: Colors.green[800],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.instagram,color: Colors.white),
                            SizedBox(width: 10,),
                            Text('Instagram',style: TextStyle(fontFamily: 'Noto',fontSize: 20,color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _whatsapp,
                    child: Container(
                      // color: Colors.green[900],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.whatsapp,color: Colors.white),
                            SizedBox(width: 10,),
                            Text('Whatsapp',style: TextStyle(fontFamily: 'Noto',fontSize: 20,color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _facebook,
                    child: Container(
                      // color: Colors.green[700],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.facebookF,color: Colors.white),
                            SizedBox(width: 10,),
                            Text('Facebook',style: TextStyle(fontFamily: 'Noto',fontSize: 20,color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PersonalInfo(this.widget.currentUser),
          PregnancyInfo(this.widget.currentUser),
          LastDate(),
          payDate(),
          SizedBox(height: 5.0),
          lastChild(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
