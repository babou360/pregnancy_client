import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pregnancy_tracking_app/Screens/home/homeScreen.dart';
import 'package:pregnancy_tracking_app/Screens/auth/welcomeScreen.dart';
import 'package:pregnancy_tracking_app/Screens/payment/sorry.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/databaseService.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class SMS1 extends StatefulWidget {
  User1 currentUser;
  SMS1(this.currentUser);
  @override
  _SMS1State createState() => _SMS1State();
}

class _SMS1State extends State<SMS1> {
  DatabaseService _databaseService = DatabaseService();
  
  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages = new List<SmsMessage>();
  List<SmsMessage> messagefilter = new List<SmsMessage>();
  // List<SmsMessage> messages = [];
  // List<SmsMessage> messagefilter = [];
  bool saveit= false;
  bool isLoading = false;
  final spinkit = SpinKitFadingCube(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);
  @override
  initState() {
    super.initState();
    fetchSMS();
  }

  saveThem(String sender,String body,String id) {
      setState(() {
        isLoading= true;
      });
      this.widget.currentUser.payDate = DateTime.now().add(Duration(days: 30));
      this._databaseService.createUser(this.widget.currentUser, false);
        FirebaseFirestore.instance.collection('walipakodi').add({
          'name': this.widget.currentUser.name,
          'date': DateTime.now(),
          'image': this.widget.currentUser.profileImageURL,
          'sms-sender': sender,
          'sms-body': body,
          'sms-id': id
        });
      setState(() {
        isLoading= false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (_)=> WelcomeScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[400],
          //color: Colors.green[400],
          child: Icon(Icons.refresh),
          onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> SMS1(this.widget.currentUser))),
        ),
        appBar: AppBar(
          title: Center(child: Text('Subscription'))
        ),
        body: messages.length<1
        ?Sorry(): mySms()
      ),
    );
  }

   fetchSMS() async {
    messagefilter = await query.querySms(
      kinds: [SmsQueryKind.Inbox]
);

   if(messagefilter != null){
     setState(() {
       messages=messagefilter.where((s) => 
       (DateTime.now().difference(s.date).inDays <= 1)
       && (s.sender=='T-PESA' || s.sender=='M-PESA' || s.sender=='TIGOPESA' || s.sender=='HaloPesa' || s.sender=='AirtelMoney')
       && (s.body.contains('255787474787') || s.body.contains('787474787') || s.body.contains('+255787474787') || s.body.contains('0787474787') || s.body.contains('0744644225') || s.body.contains('255744644225') || s.body.contains('+255744644225') || s.body.contains('744644225'))
       //&& (s.body.contains('TSH') || s.body.contains('TSh') || s.body.contains('TZS') || s.body.contains('Tshs'))
       && (s.body.contains('ALIPO') || s.body.contains('Jiang') || s.body.contains('MWANDIMILA') || s.body.contains('Alipo'))
       && (s.body.contains('5,000') || s.body.contains('5,000.00') || s.body.contains('5000.00') || s.body.contains('5000'))
       ).toList();
     });
   }
    // messages = await query.getAllSms;
  }
   mySms(){
     return FutureBuilder(
        future: fetchSMS(),
        builder: (context, snapshot) {
          return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/1.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(messages[index].sender,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15)),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(messages[index].body,maxLines: 10),
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(messages[index].date.day.toString()),
                                      Text('.'),
                                      Text(messages[index].date.month.toString()),
                                      Text('.'),
                                      Text(messages[index].date.year.toString()),
                                      SizedBox(width: 7,),
                                      Text('@'),
                                      Text(messages[index].date.hour.toString()),
                                      Text(':'),
                                      Text(messages[index].date.minute.toString())
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DateTime.now().difference(messages[index].date).inDays <=1
                              ?isLoading?spinkit:GestureDetector(
                                onTap:()=> saveThem(messages[index].sender, messages[index].body, messages[index].id.toString()),
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Confirm',style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600)),
                                  ),
                                ),
                              )
                              :Text('Used'),
                            ))
                        ],
                      )
                    ],
                  ),
                );
              });
        },
      );
   }
}