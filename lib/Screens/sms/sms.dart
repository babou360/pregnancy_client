import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/databaseService.dart';
import 'package:intl/intl.dart';
import 'package:sms/contact.dart';

class Sms extends StatefulWidget {
  User1 currentUser;
  Sms(this.currentUser);
  @override
  State createState() {
    return SmsState();
  }
}
class SmsState extends State {
   ContactQuery contacts = new ContactQuery();
  Contact contact;
  
  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages = new List<SmsMessage>();
  List<SmsMessage> messagefilter = new List<SmsMessage>();
  DatabaseService _databaseService = DatabaseService();
  bool saveit= false;
  @override
  initState() {
    super.initState();
    fetchSMS();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMS Inbox"),
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder(
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
                            width: MediaQuery.of(context).size.width/1.5,
                            child: Column(
                              children: [
                                Text(messages[index].sender),
                                Container(
                                  child: Text(messages[index].body,maxLines: 5,)
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Used'),
                            ))
                        ],
                      )
                    ],
                  ),
                  // child: ListTile(
                  //   leading: Icon(
                  //     Icons.markunread,
                  //     color: Colors.pink,
                  //   ),
                  //   title: Text(messages[index].sender),
                  //   subtitle: Column(
                  //     children: [
                  //       Text(
                  //       messages[index].body,
                  //       maxLines: 2,
                  //       style: TextStyle(),
                  //     ),
                  //     Text(messages[index].isRead ?'Imesomwa' : 'Bado'),
                  //     Text(messages[index].threadId.toString()),
                  //     Text(DateFormat.yMMMMEEEEd().format(messages[index].date)),
                  //     Text(DateTime.now().difference(messages[index].date).inHours.toString())
                  //     ],
                  //   ),
                  // ),
                );
              });
        },
      ),
    );
  }
  fetchSMS() async {
    messagefilter = await query.querySms(
      kinds: [SmsQueryKind.Inbox]
    // kinds: [SmsQueryKind.Inbox, SmsQueryKind.Sent]
);

   if(messagefilter != null){
     setState(() {
       messages=messagefilter.where((s) => 
       DateTime.now().difference(s.date).inDays <2
       && s.sender=='T-PESA' || s.sender=='M-PESA' || s.sender=='TIGOPESA' 
       || s.sender=='HaloPesa' || s.sender=='AirtelMoney'
      //  && s.body.contains('255787474787') || s.body.contains('787474787') || s.body.contains('0744644225') || s.body.contains('255744644225')
      //  && s.body.contains('ALIPO ALIPO MWANDIMILA') || s.body.contains('Jiang Alipo')
      //  && s.body.contains('TSH 5,000') || s.body.contains('Tsh5,000.00') || s.body.contains('Tsh 5,000.00') || s.body.contains('TSH5,000')
       ).toList();
     });
   }
    // messages = await query.getAllSms;
  }
}